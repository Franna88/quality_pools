import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quality_pools/Models/test_strip_result.dart';

class TestStripRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection paths
  String get _userID => _auth.currentUser?.uid ?? '';
  String get _userTestResultsPath => 'users/$_userID/test_results';
  String get _poolPath => 'users/$_userID/pools';

  // Save test result
  Future<void> saveTestResult(TestStripResult result, String poolId) async {
    try {
      // Check if user is authenticated
      if (_userID.isEmpty) {
        throw Exception('User not authenticated');
      }

      // Save to Firestore
      await _firestore.collection(_userTestResultsPath).doc().set({
        ...result.toMap(),
        'poolId': poolId,
      });

      // Update latest reading for pool
      await _firestore.collection(_poolPath).doc(poolId).update({
        'latestTestResult': result.toMap(),
        'lastTestedDate': result.timestamp
      });
    } catch (e) {
      print('Error saving test result: $e');
      rethrow;
    }
  }

  // Get test results for a specific pool
  Future<List<TestStripResult>> getTestResultsForPool(String poolId) async {
    try {
      if (_userID.isEmpty) {
        throw Exception('User not authenticated');
      }

      final snapshot = await _firestore
          .collection(_userTestResultsPath)
          .where('poolId', isEqualTo: poolId)
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => TestStripResult.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error getting test results: $e');
      return [];
    }
  }

  // Get latest test result for a pool
  Future<TestStripResult?> getLatestTestResultForPool(String poolId) async {
    try {
      if (_userID.isEmpty) {
        throw Exception('User not authenticated');
      }

      final snapshot = await _firestore
          .collection(_userTestResultsPath)
          .where('poolId', isEqualTo: poolId)
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }

      return TestStripResult.fromMap(snapshot.docs.first.data());
    } catch (e) {
      print('Error getting latest test result: $e');
      return null;
    }
  }
}
