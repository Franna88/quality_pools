import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/CommonComponants/reusable_gradient_button.dart';
import 'package:quality_pools/Models/test_strip_result.dart';
import 'package:quality_pools/MyPools/PoolMainPage/my_pools.dart';
import 'package:quality_pools/MyPools/PoolNotes/pool_notes.dart';
import 'package:quality_pools/MyPools/TestPool/test_pool.dart';
import 'package:quality_pools/Services/test_strip_analyzer_service.dart';
import 'package:quality_pools/Services/test_strip_repository.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/main_page_layout.dart';

class TestResults extends StatefulWidget {
  final TestStripResult testResult;
  final String poolId;
  final String poolName;
  final Uint8List imageData;

  const TestResults({
    Key? key,
    required this.testResult,
    required this.poolId,
    required this.poolName,
    required this.imageData,
  }) : super(key: key);

  @override
  _TestResultsState createState() => _TestResultsState();
}

class _TestResultsState extends State<TestResults> {
  final TestStripRepository _repository = TestStripRepository();
  bool _isSaving = false;
  String? _imageUrl;
  late TestStripResult _testResult;

  @override
  void initState() {
    super.initState();
    _testResult = widget.testResult;
    _uploadImageAndUpdateResult();
  }

  Future<void> _uploadImageAndUpdateResult() async {
    final analyzerService = TestStripAnalyzerService();

    try {
      // Upload image to Firebase Storage (reusing the method from the analyzer service)
      final imageUrl =
          await analyzerService.uploadImageToStorage(widget.imageData);

      if (imageUrl != null) {
        setState(() {
          _imageUrl = imageUrl;
          _testResult = TestStripResult(
            chlorine: _testResult.chlorine,
            ph: _testResult.ph,
            totalAlkalinity: _testResult.totalAlkalinity,
            calcium: _testResult.calcium,
            cyanuricAcid: _testResult.cyanuricAcid,
            confidence: _testResult.confidence,
            recommendations: _testResult.recommendations,
            imageUrl: imageUrl,
            timestamp: _testResult.timestamp,
          );
        });
      }
    } catch (e) {
      debugPrint('Error uploading image: $e');
    }
  }

  Future<void> _saveResults() async {
    setState(() {
      _isSaving = true;
    });

    try {
      // Show the loading screen
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          );
        },
      );

      // Save the test result
      await _repository.saveTestResult(_testResult, widget.poolId);

      // Close the loading dialog
      Navigator.of(context).pop();

      // Navigate to MyPools page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyPools()),
        (route) => false,
      );
    } catch (e) {
      // Close the loading dialog
      Navigator.of(context).pop();

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving results: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  void _handleSaveResults() {
    if (!_isSaving) {
      _saveResults();
    }
  }

  List<Widget> _buildRecommendationWidgets() {
    final List<Widget> widgets = [];

    if (_testResult.recommendations.isEmpty) {
      widgets.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'All OK',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'All readings are within normal range',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Recommended Action:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text('• Continue regular pool maintenance'),
            ],
          ),
        ),
      );
      return widgets;
    }

    _testResult.recommendations.forEach((key, value) {
      final status = value['status'] as String;
      final chemReading = value['value'] as double;
      final cause = value['cause'] as String?;
      final fix = value['fix'] as String?;

      widgets.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_getChemicalName(key)} ${status.capitalize()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${chemReading.toStringAsFixed(1)} ${_getUnit(key)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(status),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (cause != null) ...[
                const Text(
                  'Possible Causes:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text('• $cause'),
                const SizedBox(height: 8),
              ],
              if (fix != null) ...[
                const Text(
                  'Recommended Action:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text('• $fix'),
              ],
            ],
          ),
        ),
      );
    });

    return widgets;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'low':
        return Colors.orange;
      case 'high':
        return Colors.red;
      case 'normal':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  String _getChemicalName(String key) {
    switch (key) {
      case 'chlorine':
        return 'Chlorine';
      case 'ph':
        return 'pH';
      case 'totalAlkalinity':
        return 'Alkalinity';
      case 'calcium':
        return 'Calcium';
      case 'cyanuricAcid':
        return 'Stabilizer';
      default:
        return key.capitalize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainPageLayout(
      bodyContent: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 20),
                const Spacer(),
                Text(
                  widget.poolName,
                  style: QualityPoolTextstyle(context).pageTitle,
                ),
                const Spacer(),
                const SizedBox(width: 20)
              ],
            ),
            SizedBox(height: MyUtility(context).height * 0.02),
            // Display the test strip image
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(16.0),
              ),
              child: _imageUrl != null
                  ? Image.network(
                      _imageUrl!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Image.memory(
                      widget.imageData,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(height: MyUtility(context).height * 0.02),
            // Display the test results
            _buildReadingsGrid(),

            // Display confidence score if available
            if (_testResult.confidence > 0) ...[
              SizedBox(height: MyUtility(context).height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getConfidenceColor(_testResult.confidence),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Analysis Confidence: ${(_testResult.confidence * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            SizedBox(height: MyUtility(context).height * 0.05),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Recommendations:',
                style: QualityPoolTextstyle(context).blackStyleMedium,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: MyUtility(context).height * 0.02),
            // Display AI-generated recommendations
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: _buildRecommendationWidgets(),
              ),
            ),
            SizedBox(height: MyUtility(context).height * 0.04),
            ReusableGradientButton(
                text: 'Create a Note',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PoolNotes()),
                  );
                }),
            SizedBox(height: MyUtility(context).height * 0.02),
            ReusableGradientButton(
                text: 'Redo Analysis',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestPool(
                        poolId: widget.poolId,
                        poolName: widget.poolName,
                      ),
                    ),
                  );
                }),
            SizedBox(height: MyUtility(context).height * 0.05),
            ReusableGradientButton(
                text: 'Save Results',
                useCustomGreen: true,
                onTap: _isSaving ? () {} : _handleSaveResults),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.85) {
      return Colors.green;
    } else if (confidence >= 0.7) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  Widget _buildReadingsGrid() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            alignment: WrapAlignment.center,
            children: [
              _buildReadingContainer(
                  'Chlorine', _testResult.chlorine.toString(), 'chlorine'),
              _buildReadingContainer('pH', _testResult.ph.toString(), 'ph'),
              _buildReadingContainer('Alkalinity',
                  _testResult.totalAlkalinity.toString(), 'totalAlkalinity'),
              _buildReadingContainer(
                  'Calcium', _testResult.calcium.toString(), 'calcium'),
              _buildReadingContainer('Stabilizer',
                  _testResult.cyanuricAcid.toString(), 'cyanuricAcid'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReadingContainer(String displayName, String value, String key) {
    final ranges = TestStripAnalyzerService.optimalRanges;
    String status = 'normal';

    if (ranges.containsKey(key)) {
      final range = ranges[key]!;
      final min = range['min'] as double;
      final max = range['max'] as double;
      final double numValue = double.parse(value);

      if (numValue < min) {
        status = 'low';
      } else if (numValue > max) {
        status = 'high';
      }
    }

    return Container(
      height: MyUtility(context).width * 0.22,
      width: MyUtility(context).width * 0.22,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0XFF1A8CF0),
            Color(0XFF095BB2),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                displayName,
                style: QualityPoolTextstyle(context).readingType,
                textAlign: TextAlign.center,
              ),
              Text(
                double.parse(value).toStringAsFixed(1),
                style: QualityPoolTextstyle(context).readingType.copyWith(
                      color: _getValueColor(status),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                _getUnit(key),
                style: QualityPoolTextstyle(context).whitebodyText,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getValueColor(String status) {
    switch (status) {
      case 'low':
        return Colors.orange;
      case 'high':
        return Colors.red;
      case 'normal':
        return const Color.fromARGB(255, 76, 219, 81); // Green for good values
      default:
        return const Color.fromARGB(255, 76, 219, 81); // Default green
    }
  }

  String _getUnit(String type) {
    if (type == 'ph') {
      return '';
    }
    return 'ppm';
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
