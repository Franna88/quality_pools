import 'package:flutter/material.dart';
import 'package:quality_pools/Services/pdf_reference_service.dart';

/// A utility screen to check the status of the app's services
class ServiceStatusScreen extends StatefulWidget {
  const ServiceStatusScreen({Key? key}) : super(key: key);

  @override
  _ServiceStatusScreenState createState() => _ServiceStatusScreenState();
}

class _ServiceStatusScreenState extends State<ServiceStatusScreen> {
  final PdfReferenceService _pdfService = PdfReferenceService();

  bool _isLoading = false;
  Map<String, dynamic> _pdfStatus = {};
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _checkServiceStatus();
  }

  Future<void> _checkServiceStatus() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Check PDF availability
      final pdfStatus = await _pdfService.checkPdfAvailability();

      setState(() {
        _pdfStatus = pdfStatus;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error checking services: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Status'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PDF Reference Documents',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildPdfStatusCards(),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Service Setup Instructions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildInstructionCard(
              title: 'PDF Setup',
              instructions: [
                '1. Log in to your Firebase Console',
                '2. Go to Storage',
                '3. Upload "Waterwell Pool Care Guide.pdf"',
                '4. Upload "Waterwell Product Manual ~ Rev. July 2021.pdf"',
              ],
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _checkServiceStatus,
                child: const Text('Refresh Status'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPdfStatusCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatusCard(
          title: 'Pool Chemical Guide',
          isAvailable: _pdfStatus['poolChemicalGuideAvailable'] ?? false,
          details: 'File: Waterwell Pool Care Guide.pdf',
        ),
        const SizedBox(height: 12),
        _buildStatusCard(
          title: 'Water Balance Recommendations',
          isAvailable:
              _pdfStatus['waterBalanceRecommendationsAvailable'] ?? false,
          details: 'File: Waterwell Product Manual ~ Rev. July 2021.pdf',
        ),
        if (_pdfStatus['error'] != null)
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              '${_pdfStatus['error']}',
              style: const TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }

  Widget _buildStatusCard({
    required String title,
    required bool isAvailable,
    required String details,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isAvailable ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    details,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isAvailable ? 'Available' : 'Not Found',
                    style: TextStyle(
                      color: isAvailable ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionCard({
    required String title,
    required List<String> instructions,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            ...instructions.map(
              (instruction) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(instruction),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
