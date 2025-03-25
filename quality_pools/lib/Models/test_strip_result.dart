class TestStripResult {
  final double chlorine;
  final double ph;
  final double totalAlkalinity;
  final double calcium;
  final double cyanuricAcid;
  final double confidence;
  final Map<String, dynamic> recommendations;
  final String imageUrl;
  final DateTime timestamp;

  TestStripResult({
    required this.chlorine,
    required this.ph,
    required this.totalAlkalinity,
    required this.calcium,
    required this.cyanuricAcid,
    required this.confidence,
    required this.recommendations,
    required this.imageUrl,
    required this.timestamp,
  });

  // Create from AI service response
  factory TestStripResult.fromAnalysis(Map<String, dynamic> analysis,
      Map<String, dynamic> recommendations, String imageUrl) {
    return TestStripResult(
      chlorine: analysis['chlorine'] as double,
      ph: analysis['ph'] as double,
      totalAlkalinity: analysis['totalAlkalinity'] as double,
      calcium: analysis['calcium'] as double,
      cyanuricAcid: analysis['cyanuricAcid'] as double,
      confidence: analysis.containsKey('confidence')
          ? analysis['confidence'] as double
          : 0.0,
      recommendations: recommendations,
      imageUrl: imageUrl,
      timestamp: DateTime.now(),
    );
  }

  // Convert to map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'chlorine': chlorine,
      'ph': ph,
      'totalAlkalinity': totalAlkalinity,
      'calcium': calcium,
      'cyanuricAcid': cyanuricAcid,
      'confidence': confidence,
      'recommendations': recommendations,
      'imageUrl': imageUrl,
      'timestamp': timestamp,
    };
  }

  // Create from Firestore document
  factory TestStripResult.fromMap(Map<String, dynamic> map) {
    return TestStripResult(
      chlorine: map['chlorine'] as double,
      ph: map['ph'] as double,
      totalAlkalinity: map['totalAlkalinity'] as double,
      calcium: map['calcium'] as double,
      cyanuricAcid: map['cyanuricAcid'] as double,
      confidence:
          map.containsKey('confidence') ? map['confidence'] as double : 0.0,
      recommendations: map['recommendations'] as Map<String, dynamic>,
      imageUrl: map['imageUrl'] as String,
      timestamp: (map['timestamp'] as DateTime),
    );
  }
}
