import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

/// A service for extracting reference information from PDF documents
/// This is a simplified version without the PDF library dependency
class PdfReferenceService {
  // Singleton pattern
  static final PdfReferenceService _instance = PdfReferenceService._internal();
  factory PdfReferenceService() => _instance;
  PdfReferenceService._internal();

  // Storage path constants
  static const String _pdfStoragePath = '';

  // Reference PDFs
  static const String _poolChemicalGuide = 'Waterwell Pool Care Guide.pdf';
  static const String _waterBalanceRecommendations =
      'Waterwell Product Manual ~ Rev. July 2021.pdf';

  // Cache for extracted content
  final Map<String, String> _extractedContent = {};
  bool _contentLoaded = false;

  // Chemical abbreviation mapping
  final Map<String, String> _chemicalFullNames = {
    'chlorine': 'Free Chlorine',
    'ph': 'pH',
    'totalAlkalinity': 'Total Alkalinity',
    'calcium': 'Calcium Hardness',
    'cyanuricAcid': 'Cyanuric Acid',
  };

  /// Download reference PDFs from Firebase Storage
  Future<void> downloadReferencePdfs() async {
    try {
      final storage = FirebaseStorage.instance;

      // Get references to the PDFs
      final poolGuideRef =
          storage.ref().child('$_pdfStoragePath$_poolChemicalGuide');
      final balanceRef =
          storage.ref().child('$_pdfStoragePath$_waterBalanceRecommendations');

      // Check if the files exist
      try {
        await poolGuideRef.getMetadata();
        await balanceRef.getMetadata();

        debugPrint('PDF reference files found in Firebase Storage');

        // FUTURE IMPLEMENTATION:
        // Once the syncfusion_flutter_pdf library is working properly,
        // this is where you would:
        // 1. Download the actual PDF files to local storage
        // 2. Use PdfDocument to parse the PDFs
        // 3. Extract the text content using PdfTextExtractor
        // 4. Store the extracted content in _extractedContent
        //
        // Example code:
        // final bytes = await poolGuideRef.getData();
        // if (bytes != null) {
        //   final document = PdfDocument(inputBytes: bytes);
        //   String extractedText = '';
        //   for (int i = 0; i < document.pages.count; i++) {
        //     extractedText += PdfTextExtractor(document).extractText(
        //       startPageIndex: i,
        //       endPageIndex: i
        //     );
        //   }
        //   _extractedContent[_poolChemicalGuide] = extractedText;
        //   document.dispose();
        // }

        // For now, we'll just mark content as loaded without actually downloading
        _contentLoaded = true;

        // Load mock content for testing
        _loadMockContent();
      } catch (e) {
        debugPrint('PDF files not found in Firebase Storage: $e');
        debugPrint(
            'Make sure to upload PDFs to $_pdfStoragePath in Firebase Storage');
        // Load mock content anyway for testing
        _contentLoaded = true;
        _loadMockContent();
      }
    } catch (e) {
      debugPrint('Error downloading reference PDFs: $e');
      // Load mock content as fallback
      _contentLoaded = true;
      _loadMockContent();
    }
  }

  /// Load mock content for testing
  void _loadMockContent() {
    _extractedContent[_poolChemicalGuide] = '''
Free Chlorine: The ideal free chlorine level is between 1.0 and 3.0 ppm. 
If chlorine is too low, bacteria and algae can grow. If it's too high, it can cause eye irritation and equipment damage.

pH: The ideal pH level is between 7.2 and 7.8. 
If pH is too low (acidic), it can cause eye irritation and equipment corrosion. 
If pH is too high (basic), chlorine becomes less effective and scaling can occur.

Total Alkalinity: The ideal total alkalinity level is between 80 and 120 ppm. 
Low alkalinity causes pH to fluctuate. High alkalinity makes pH difficult to adjust.

Calcium Hardness: The ideal calcium hardness level is between 200 and 400 ppm. 
Low calcium can cause plaster etching. High calcium can cause scaling and cloudy water.

Cyanuric Acid: The ideal cyanuric acid level is between 30 and 50 ppm. 
Too little won't protect chlorine from sunlight. Too much reduces chlorine effectiveness.
''';

    _extractedContent[_waterBalanceRecommendations] = '''
Water Balance Recommendations:

Chlorine Low (below 1.0 ppm): Add chlorine shock treatment. Possible causes include heavy bather load, high temperatures, or insufficient sanitizer.

Chlorine High (above 3.0 ppm): Wait for chlorine to naturally dissipate or use a chlorine neutralizer. Possible causes include over-shocking or improper measurement.

pH Low (below 7.2): Add pH increaser (sodium carbonate). Possible causes include acid rain, leaves, or other acidic materials in the pool.

pH High (above 7.8): Add pH decreaser (sodium bisulfate). Possible causes include algae growth or high total alkalinity.

Total Alkalinity Low (below 80 ppm): Add alkalinity increaser (sodium bicarbonate). Possible causes include heavy rainfall or frequent backwashing.

Total Alkalinity High (above 120 ppm): Add pH decreaser gradually. Possible causes include using too much alkalinity increaser or hard source water.

Calcium Hardness Low (below 200 ppm): Add calcium hardness increaser. Possible causes include using soft water for filling.

Calcium Hardness High (above 400 ppm): Partially drain and refill pool with fresh water. Possible causes include evaporation or hard source water.

Cyanuric Acid High (above 50 ppm): Partially drain and refill pool with fresh water. Possible causes include too much stabilized chlorine use.
''';
  }

  /// Get chemical references from extracted content
  List<String> getChemicalReferences(String chemicalName) {
    if (!_contentLoaded) {
      downloadReferencePdfs();
    }

    final fullName =
        _chemicalFullNames[chemicalName.toLowerCase()] ?? chemicalName;
    final references = <String>[];

    _extractedContent.forEach((_, content) {
      // Find paragraphs containing the chemical name
      final RegExp regExp =
          RegExp('$fullName:.*?\\n', caseSensitive: false, dotAll: true);
      final matches = regExp.allMatches(content);

      for (final match in matches) {
        references.add(content.substring(match.start, match.end).trim());
      }
    });

    return references;
  }

  /// Generate recommendations based on test results
  Map<String, dynamic> getRecommendationsFromReference(
    Map<String, dynamic> testResults,
  ) {
    final recommendations = <String, dynamic>{};

    testResults.forEach((chemical, value) {
      if (chemical == 'confidence') return;

      final recommendation = _getRecommendationForChemical(chemical, value);
      if (recommendation != null) {
        recommendations[chemical] = recommendation;
      }
    });

    return recommendations;
  }

  /// Get recommendation for a specific chemical
  Map<String, dynamic>? _getRecommendationForChemical(
    String chemical,
    double value,
  ) {
    var status = 'normal';
    String? cause;
    String? fix;

    // Get reference ranges and recommendations
    switch (chemical.toLowerCase()) {
      case 'chlorine':
        if (value < 1.0) {
          status = 'low';
          cause =
              'Heavy bather load, high temperatures, or insufficient sanitizer';
          fix = 'Add chlorine shock treatment';
        } else if (value > 3.0) {
          status = 'high';
          cause = 'Over-shocking or improper measurement';
          fix =
              'Wait for chlorine to naturally dissipate or use a chlorine neutralizer';
        }
        break;
      case 'ph':
        if (value < 7.2) {
          status = 'low';
          cause = 'Acid rain, leaves, or other acidic materials in the pool';
          fix = 'Add pH increaser (sodium carbonate)';
        } else if (value > 7.8) {
          status = 'high';
          cause = 'Algae growth or high total alkalinity';
          fix = 'Add pH decreaser (sodium bisulfate)';
        }
        break;
      case 'totalalkalinity':
        if (value < 80) {
          status = 'low';
          cause = 'Heavy rainfall or frequent backwashing';
          fix = 'Add alkalinity increaser (sodium bicarbonate)';
        } else if (value > 120) {
          status = 'high';
          cause = 'Using too much alkalinity increaser or hard source water';
          fix = 'Add pH decreaser gradually';
        }
        break;
      case 'calcium':
        if (value < 200) {
          status = 'low';
          cause = 'Using soft water for filling';
          fix = 'Add calcium hardness increaser';
        } else if (value > 400) {
          status = 'high';
          cause = 'Evaporation or hard source water';
          fix = 'Partially drain and refill pool with fresh water';
        }
        break;
      case 'cyanuricacid':
        if (value < 30) {
          status = 'low';
          cause = 'Insufficient stabilizer';
          fix = 'Add cyanuric acid';
        } else if (value > 50) {
          status = 'high';
          cause = 'Too much stabilized chlorine use';
          fix = 'Partially drain and refill pool with fresh water';
        }
        break;
      default:
        return null;
    }

    return {'status': status, 'value': value, 'cause': cause, 'fix': fix};
  }

  /// Utility method to check if PDFs are available in Firebase Storage
  /// Returns a map with status information
  Future<Map<String, dynamic>> checkPdfAvailability() async {
    Map<String, dynamic> result = {
      'poolChemicalGuideAvailable': false,
      'waterBalanceRecommendationsAvailable': false,
      'error': null
    };

    try {
      final storage = FirebaseStorage.instance;

      // Get references to the PDFs
      final poolGuideRef =
          storage.ref().child('$_pdfStoragePath$_poolChemicalGuide');
      final balanceRef =
          storage.ref().child('$_pdfStoragePath$_waterBalanceRecommendations');

      try {
        // Check if files exist by getting metadata
        await poolGuideRef.getMetadata();
        result['poolChemicalGuideAvailable'] = true;
      } catch (e) {
        result['poolChemicalGuideAvailable'] = false;
      }

      try {
        await balanceRef.getMetadata();
        result['waterBalanceRecommendationsAvailable'] = true;
      } catch (e) {
        result['waterBalanceRecommendationsAvailable'] = false;
      }

      if (!result['poolChemicalGuideAvailable'] &&
          !result['waterBalanceRecommendationsAvailable']) {
        result['error'] =
            'PDF files not found in Firebase Storage path: $_pdfStoragePath';
      }
    } catch (e) {
      result['error'] = 'Error checking PDF availability: $e';
    }

    return result;
  }
}
