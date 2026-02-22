/// Core Module
/// 
/// Shared utilities and base classes used across all features.
/// 
/// ## Usage
/// 
/// ```dart
/// import 'package:coursesapp/core/core.dart';
/// 
/// // Use failures
/// return Left(ServerFailure(message: 'Error'));
/// 
/// // Use validators
/// final isValid = Validators.isValidEmail(email);
/// 
/// // Use network info
/// if (await networkInfo.isConnected) { ... }
/// ```
library core;

// Constants
export 'constants/api_constants.dart';
export 'constants/app_constants.dart';
export 'constants/firebase_constants.dart';

// Errors
export 'errors/exceptions.dart';
export 'errors/failures.dart';

// Network
export 'network/network_info.dart';

// Providers
export 'providers/user_id_provider.dart';

// Use Cases
export 'usecases/usecase.dart';

// Utils
export 'utils/rank_calculator.dart';
export 'utils/typedef.dart';
export 'utils/validators.dart';
