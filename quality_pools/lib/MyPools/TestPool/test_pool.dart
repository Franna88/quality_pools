import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quality_pools/CommonComponants/back_button.dart';
import 'package:quality_pools/CommonComponants/blue_page_layout.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/Models/test_strip_result.dart';
import 'package:quality_pools/MyPools/TestPool/test_results.dart';
import 'package:quality_pools/Services/test_strip_analyzer_service.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';

class TestPool extends StatefulWidget {
  final String poolId;
  final String poolName;

  const TestPool({
    Key? key,
    required this.poolId,
    required this.poolName,
  }) : super(key: key);

  @override
  _TestPoolState createState() => _TestPoolState();
}

class _TestPoolState extends State<TestPool> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _imageData;
  bool _isAnalyzing = false;
  final TestStripAnalyzerService _analyzerService = TestStripAnalyzerService();
  String? _errorMessage;

  // Wrapper function to convert Future<void> to VoidCallback
  void _handleAnalyzeButtonTap() {
    if (!_isAnalyzing) {
      _analyzeTestStrip();
    }
  }

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 90,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (photo != null) {
      final bytes = await photo.readAsBytes();
      setState(() {
        _imageData = bytes;
        _errorMessage = null;
      });
    }
  }

  Future<void> _selectImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _imageData = bytes;
        _errorMessage = null;
      });
    }
  }

  Future<void> _analyzeTestStrip() async {
    if (_imageData == null) {
      // Show a snackbar if no image is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Please select or take a photo of your test strip first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isAnalyzing = true;
      _errorMessage = null;
    });

    // Show the loading screen
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(MyColors().lightBlue),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: const [
                    Text(
                      'Analyzing your test strip...',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'This may take a few moments',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

    try {
      // Call the AI service to analyze the test strip
      final analysisResults =
          await _analyzerService.analyzeTestStrip(_imageData!);

      if (analysisResults != null) {
        // Generate recommendations based on the analysis results
        final recommendations =
            await _analyzerService.generateRecommendations(analysisResults);

        // Close the loading dialog
        Navigator.of(context).pop();

        // Create a TestStripResult object - imageUrl will be updated later
        final testStripResult = TestStripResult.fromAnalysis(
          analysisResults,
          recommendations,
          '', // This will be updated after the image is uploaded
        );

        // Navigate to TestResults page with the analysis data
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TestResults(
              testResult: testStripResult,
              poolId: widget.poolId,
              poolName: widget.poolName,
              imageData: _imageData!,
            ),
          ),
        );
      } else {
        // Close the loading dialog
        Navigator.of(context).pop();

        // Show error message
        setState(() {
          _errorMessage =
              'Failed to analyze test strip. Please ensure the image is clear and well-lit.';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage!),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      // Close the loading dialog
      Navigator.of(context).pop();

      // Show error message
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      setState(() {
        _isAnalyzing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BluePageLayout(
            pageContents: [
              Text(
                'Upload an image of the pool test strip',
                style: QualityPoolTextstyle(context).whiteStyleBody,
                textAlign: TextAlign.center,
              ),
              InkWell(
                onTap: _takePhoto,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors().lightBlue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: MyColors().lightBlue, width: 2),
                      ),
                      child: _imageData != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: Image.memory(
                                _imageData!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: MyColors().lightBlue,
                                    ),
                                    onPressed: _takePhoto,
                                    iconSize: 60.0,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Take a photo',
                                    style: QualityPoolTextstyle(context)
                                        .whiteStyleBody,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              CommonButton(
                buttonText: 'Select from Gallery',
                onPressed: _selectImage,
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(
                        color: Colors.red[300], fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Tips for best results:',
                  style: QualityPoolTextstyle(context)
                      .whiteStyleBody
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '• Make sure test strip is dry and fully developed\n• Take photo in good lighting\n• Keep the test strip flat and centered',
                  style: QualityPoolTextstyle(context).smallText,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
            onTap: _isAnalyzing ? () {} : _handleAnalyzeButtonTap,
            buttonText: 'Analyze Test Strip',
          ),
          Positioned(
            top: 30.0,
            left: 16.0,
            child: CustomBackButton(),
          ),
        ],
      ),
    );
  }
}
