import 'package:coursesapp/core/constants/app_constants.dart';

/// Utility class for rank and level calculations.
/// Extracted from business logic that was previously in UI files.
class RankCalculator {
  RankCalculator._();

  /// Calculate rank based on score
  static String calculateRank(int score) {
    if (score >= 1500) return 'S';
    if (score >= 1000) return 'A++';
    if (score >= 600) return 'A+';
    if (score >= 300) return 'A';
    if (score >= 150) return 'B';
    if (score >= 70) return 'C';
    if (score >= 10) return 'D';
    return 'E';
  }

  /// Calculate level based on score
  static int calculateLevel(int score) {
    if (score >= 1500) return 6;
    if (score >= 600) return 5;
    if (score >= 300) return 4;
    if (score >= 150) return 3;
    if (score >= 70) return 2;
    if (score >= 10) return 1;
    return 0;
  }

  /// Get the score threshold for next rank
  static int getNextRankThreshold(int currentScore) {
    final thresholds = AppConstants.rankThresholds.values.toList()..sort();
    for (final threshold in thresholds) {
      if (currentScore < threshold) return threshold;
    }
    return currentScore; // Already at max rank
  }

  /// Calculate progress percentage to next rank
  static double calculateProgressToNextRank(int currentScore) {
    final thresholds = AppConstants.rankThresholds.values.toList()..sort();
    
    int previousThreshold = 0;
    for (final threshold in thresholds) {
      if (currentScore < threshold) {
        final range = threshold - previousThreshold;
        final progress = currentScore - previousThreshold;
        return progress / range;
      }
      previousThreshold = threshold;
    }
    return 1.0; // Max rank reached
  }
}
