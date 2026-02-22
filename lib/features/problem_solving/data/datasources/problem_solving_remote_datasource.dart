import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/problem_model.dart';
import '../models/evaluation_model.dart';

/// Remote data source for Problem Solving - handles Firestore operations
abstract class ProblemSolvingRemoteDataSource {
  /// Get a random problem by level from Firestore
  Future<ProblemModel> getRandomProblem(int level);

  /// Save evaluation result to Firestore
  Future<void> saveEvaluationResult(EvaluationModel evaluation, String userId);

  /// Get solution history from Firestore
  Future<List<EvaluationModel>> getSolutionHistory(String userId);
}

class ProblemSolvingRemoteDataSourceImpl implements ProblemSolvingRemoteDataSource {
  final FirebaseFirestore firestore;

  ProblemSolvingRemoteDataSourceImpl({required this.firestore});

  @override
  Future<ProblemModel> getRandomProblem(int level) async {
    try {
      final String levelKey = 'level$level';
      
      // Fetch the questions from the pms collection
      final QuerySnapshot querySnapshot = await firestore.collection('pms').get();
      
      if (querySnapshot.docs.isEmpty) {
        throw Exception('No problems available');
      }

      // Get the first document (contains all level questions)
      final DocumentSnapshot docSnapshot = querySnapshot.docs.first;
      final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

      // Get questions for the specified level
      final List<String> levelQuestions = List<String>.from(data[levelKey] ?? []);
      
      if (levelQuestions.isEmpty) {
        throw Exception('No problems available for level $level');
      }

      // Select a random question
      final int randomIndex = Random().nextInt(levelQuestions.length);
      final String question = levelQuestions[randomIndex];

      return ProblemModel.fromQuestion(question, level);
    } catch (e) {
      throw Exception('Failed to fetch problem: $e');
    }
  }

  @override
  Future<void> saveEvaluationResult(EvaluationModel evaluation, String userId) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('evaluations')
          .doc(evaluation.id)
          .set(evaluation.toJson());
    } catch (e) {
      throw Exception('Failed to save evaluation: $e');
    }
  }

  @override
  Future<List<EvaluationModel>> getSolutionHistory(String userId) async {
    try {
      final QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('evaluations')
          .orderBy('evaluatedAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => EvaluationModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch solution history: $e');
    }
  }
}
