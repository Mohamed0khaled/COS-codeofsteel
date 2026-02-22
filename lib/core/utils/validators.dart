/// Email validation regex
class Validators {
  Validators._();

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  /// Validates email format
  static bool isValidEmail(String email) {
    return _emailRegex.hasMatch(email.trim());
  }

  /// Validates password strength
  /// Minimum 8 characters, at least one letter and one number
  static bool isValidPassword(String password) {
    return _passwordRegex.hasMatch(password);
  }

  /// Validates username
  /// Between 3 and 20 characters, alphanumeric and underscores only
  static bool isValidUsername(String username) {
    if (username.length < 3 || username.length > 20) return false;
    return RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username);
  }

  /// Returns error message for email validation
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!isValidEmail(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Returns error message for password validation
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!isValidPassword(password)) {
      return 'Password must contain at least one letter and one number';
    }
    return null;
  }

  /// Returns error message for username validation
  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    if (username.length < 3) {
      return 'Username must be at least 3 characters';
    }
    if (username.length > 20) {
      return 'Username must be less than 20 characters';
    }
    if (!isValidUsername(username)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    return null;
  }
}
