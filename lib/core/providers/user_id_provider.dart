import 'package:flutter/widgets.dart';

/// InheritedWidget that provides userId down the widget tree.
/// 
/// This allows child widgets to access the current user's ID
/// without directly depending on FirebaseAuth or AuthCubit.
/// 
/// Usage:
/// ```dart
/// // In parent widget (usually near root):
/// UserIdProvider(
///   userId: 'current-user-id',
///   child: MyApp(),
/// )
/// 
/// // In any child widget:
/// final userId = UserIdProvider.of(context);
/// ```
class UserIdProvider extends InheritedWidget {
  final String userId;

  const UserIdProvider({
    super.key,
    required this.userId,
    required super.child,
  });

  /// Get the userId from the nearest UserIdProvider ancestor.
  /// Returns empty string if no provider is found or user is not logged in.
  static String of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<UserIdProvider>();
    return provider?.userId ?? '';
  }

  /// Get the userId without listening to changes (for callbacks).
  /// Returns empty string if no provider is found or user is not logged in.
  static String read(BuildContext context) {
    final provider = context.getInheritedWidgetOfExactType<UserIdProvider>();
    return provider?.userId ?? '';
  }

  /// Check if user is authenticated (userId is not empty).
  static bool isAuthenticated(BuildContext context) {
    return of(context).isNotEmpty;
  }

  @override
  bool updateShouldNotify(UserIdProvider oldWidget) {
    return userId != oldWidget.userId;
  }
}
