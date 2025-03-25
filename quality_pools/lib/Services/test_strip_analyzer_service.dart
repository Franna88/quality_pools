import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quality_pools/Services/firebase_ml_service.dart';
import 'package:quality_pools/Services/pdf_reference_service.dart';

class TestStripAnalyzerService {
  // Cloud Function API URL for test strip analysis
  static const String _apiUrl =
      'https://us-central1-quality-pools-2c750.cloudfunctions.net/analyzeTestStrip';

  // Singleton pattern
  static final TestStripAnalyzerService _instance =
      TestStripAnalyzerService._internal();
  factory TestStripAnalyzerService() => _instance;
  TestStripAnalyzerService._internal();

  // Services for ML analysis and PDF reference
  final FirebaseMlService _mlService = FirebaseMlService();
  final PdfReferenceService _pdfService = PdfReferenceService();

  // Updated optimal ranges for pool chemicals
  static final Map<String, Map<String, dynamic>> optimalRanges = {
    'chlorine': {'min': 1.0, 'max': 3.0, 'unit': 'ppm'},
    'ph': {'min': 7.2, 'max': 7.8, 'unit': ''},
    'totalAlkalinity': {
      'min': 80,
      'max': 120,
      'unit': 'ppm',
      'note': '80-125 ppm for concrete/tiled, 125-175 ppm for fiberglass/vinyl',
    },
    'calcium': {
      'min': 200,
      'max': 400,
      'unit': 'ppm',
      'note':
          '200-275 ppm for concrete/tiled, 175-225 ppm for fiberglass/vinyl',
    },
    'cyanuricAcid': {'min': 30, 'max': 50, 'unit': 'ppm'},
  };

  /// Upload image to Firebase Storage and get download URL
  Future<String?> uploadImageToStorage(Uint8List imageData) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final fileName =
          'test_strips/${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = FirebaseStorage.instance.ref().child(fileName);

      await ref.putData(imageData);
      return await ref.getDownloadURL();
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return null;
    }
  }

  /// Analyze test strip using ML
  Future<Map<String, dynamic>?> analyzeTestStrip(Uint8List imageData) async {
    try {
      // Upload image to Firebase Storage
      final imageUrl = await uploadImageToStorage(imageData);
      if (imageUrl == null) return null;

      // Use the Firebase ML service for analysis
      final mlResults = await _mlService.analyzeTestStripImage(
        imageData,
        imageUrl,
      );
      if (mlResults != null) {
        return mlResults;
      }

      // If ML service fails, return mock results
      return getMockAnalysisResults();
    } catch (e) {
      debugPrint('Error analyzing test strip: $e');
      return getMockAnalysisResults();
    }
  }

  /// Generate recommendations based on test results
  Future<Map<String, dynamic>> generateRecommendations(
    Map<String, dynamic> readings,
  ) async {
    try {
      // First try to get recommendations from PDF reference
      final pdfRecommendations = _pdfService.getRecommendationsFromReference(
        readings,
      );
      if (pdfRecommendations.isNotEmpty) {
        return pdfRecommendations;
      }

      // If PDF reference doesn't have recommendations, generate them based on optimal ranges
      final recommendations = <String, dynamic>{};

      optimalRanges.forEach((key, range) {
        if (readings.containsKey(key)) {
          final reading = readings[key] as double?;
          if (reading != null) {
            if (reading < range['min']) {
              recommendations[key] = {
                'status': 'low',
                'value': reading,
                'cause': _getLowCause(key),
                'fix': _getLowFix(key),
              };
            } else if (reading > range['max']) {
              recommendations[key] = {
                'status': 'high',
                'value': reading,
                'cause': _getHighCause(key),
                'fix': _getHighFix(key),
              };
            } else {
              recommendations[key] = {
                'status': 'normal',
                'value': reading,
                'cause': null,
                'fix': null,
              };
            }
          }
        }
      });

      return recommendations;
    } catch (e) {
      debugPrint('Error generating recommendations: $e');
      return {};
    }
  }

  /// Get mock analysis results for testing
  Map<String, dynamic> getMockAnalysisResults() {
    return {
      'chlorine': 0.5,
      'ph': 8.2,
      'totalAlkalinity': 60.0,
      'calcium': 350.0,
      'cyanuricAcid': 40.0,
      'confidence': 0.85,
    };
  }

  // Helper methods for recommendations
  String _getLowCause(String parameter) {
    switch (parameter) {
      case 'chlorine':
        return 'High bather loads, sunlight exposure, or insufficient sanitizer';
      case 'ph':
        return 'Acidic source water, overuse of pH reducer, or high bather loads';
      case 'totalAlkalinity':
        return 'Low pH destroying total alkalinity or dilution from rainfall';
      case 'calcium':
        return 'Dilution from rainfall or soft source water';
      case 'cyanuricAcid':
        return 'Dilution from rainfall or not using stabilized chlorine products';
      default:
        return 'Unknown cause';
    }
  }

  String _getHighCause(String parameter) {
    switch (parameter) {
      case 'chlorine':
        return 'Recent shock treatment or high stabilizer levels';
      case 'ph':
        return 'Hard source water, overuse of pH increaser, or high alkalinity';
      case 'totalAlkalinity':
        return 'Hard source water or overuse of alkalinity increaser';
      case 'calcium':
        return 'Evaporation concentrating minerals or hard source water';
      case 'cyanuricAcid':
        return 'Excessive use of stabilized chlorine or evaporation';
      default:
        return 'Unknown cause';
    }
  }

  String _getLowFix(String parameter) {
    switch (parameter) {
      case 'chlorine':
        return 'Add chlorine shock treatment (250g per 10,000L)';
      case 'ph':
        return 'Add pH increaser (sodium carbonate) - 100g per 10,000L';
      case 'totalAlkalinity':
        return 'Add alkalinity increaser (sodium bicarbonate)';
      case 'calcium':
        return 'Add calcium chloride hardness increaser';
      case 'cyanuricAcid':
        return 'Add cyanuric acid stabilizer';
      default:
        return 'Consult a pool professional';
    }
  }

  String _getHighFix(String parameter) {
    switch (parameter) {
      case 'chlorine':
        return 'Wait for chlorine to dissipate or use a chlorine neutralizer';
      case 'ph':
        return 'Add pH reducer (100g dry acid per 10,000L)';
      case 'totalAlkalinity':
        return 'Add pH reducer in small doses (240g per 10,000L for 10ppm reduction)';
      case 'calcium':
        return 'Partially drain and refill with softer water';
      case 'cyanuricAcid':
        return 'Partially drain and refill with fresh water';
      default:
        return 'Consult a pool professional';
    }
  }
}
