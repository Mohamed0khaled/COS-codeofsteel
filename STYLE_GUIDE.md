# Code of Steel - Design Pattern & Style Guide

## Architecture Overview

This project follows **Clean Architecture** with the following layers:

```
┌─────────────────────────────────────────────────────────────┐
│                     PRESENTATION                              │
│  (Cubits, States, Pages, Widgets)                             │
│  - UI components and state management                         │
│  - Depends on: Domain layer only                              │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                       DOMAIN                                  │
│  (Entities, Repositories, Use Cases)                          │
│  - Business logic and rules                                   │
│  - No external dependencies                                   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                        DATA                                   │
│  (Models, DataSources, Repository Implementations)            │
│  - Data handling and external services                        │
│  - Implements domain interfaces                               │
└─────────────────────────────────────────────────────────────┘
```

## Design Patterns Used

| Pattern | Usage |
|---------|-------|
| **Repository Pattern** | Abstract data access, implementations in data layer |
| **Use Case Pattern** | Single responsibility business operations |
| **Cubit Pattern** | State management (simplified BLoC) |
| **Factory Pattern** | DI container creates instances |
| **Dependency Injection** | get_it service locator |
| **Either Pattern** | Functional error handling with dartz |

---

## Folder Structure

```
lib/
├── core/                           # Shared utilities across features
│   ├── constants/                  # App-wide constants
│   │   └── app_constants.dart
│   ├── errors/                     # Error handling
│   │   ├── exceptions.dart         # Exception classes
│   │   └── failures.dart           # Failure classes
│   ├── network/                    # Network utilities
│   │   └── network_info.dart
│   ├── providers/                  # Inherited widgets for data passing
│   │   └── user_id_provider.dart
│   ├── usecases/                   # Base use case class
│   │   └── usecase.dart
│   ├── utils/                      # Helper functions
│   │   └── input_validators.dart
│   └── core.dart                   # Barrel export
│
├── features/                       # Feature modules
│   └── feature_name/
│       ├── domain/                 # Business logic (innermost layer)
│       │   ├── entities/           # Business objects
│       │   │   └── feature_entity.dart
│       │   ├── repositories/       # Abstract interfaces
│       │   │   └── feature_repository.dart
│       │   └── usecases/           # Business operations
│       │       └── do_something_usecase.dart
│       │
│       ├── data/                   # Data handling (outer layer)
│       │   ├── models/             # DTOs with serialization
│       │   │   └── feature_model.dart
│       │   ├── datasources/        # Remote/Local data sources
│       │   │   └── feature_remote_datasource.dart
│       │   └── repositories/       # Repository implementations
│       │       └── feature_repository_impl.dart
│       │
│       ├── presentation/           # UI layer
│       │   ├── cubit/              # State management
│       │   │   ├── feature_cubit.dart
│       │   │   └── feature_state.dart
│       │   ├── pages/              # Full screen widgets
│       │   │   └── feature_page.dart
│       │   └── widgets/            # Reusable UI components
│       │       └── feature_widget.dart
│       │
│       └── feature_name.dart       # Barrel export for feature
│
├── injection_container.dart        # Dependency injection setup
└── main.dart                       # App entry point
```

---

## Naming Conventions

### Files (snake_case)

| Type | Pattern | Example |
|------|---------|---------|
| Entity | `{name}_entity.dart` | `user_entity.dart` |
| Model | `{name}_model.dart` | `user_model.dart` |
| Repository (interface) | `{name}_repository.dart` | `auth_repository.dart` |
| Repository (impl) | `{name}_repository_impl.dart` | `auth_repository_impl.dart` |
| DataSource | `{name}_remote_datasource.dart` | `auth_remote_datasource.dart` |
| Use Case | `{action}_{noun}_usecase.dart` | `get_user_profile_usecase.dart` |
| Cubit | `{feature}_cubit.dart` | `auth_cubit.dart` |
| State | `{feature}_state.dart` | `auth_state.dart` |
| Page | `{feature}_page.dart` | `profile_page.dart` |
| Widget | `{name}_widget.dart` | `score_card_widget.dart` |

### Classes (PascalCase)

| Type | Pattern | Example |
|------|---------|---------|
| Entity | `{Name}Entity` | `UserEntity` |
| Model | `{Name}Model` | `UserModel` |
| Repository | `{Name}Repository` | `AuthRepository` |
| Repository Impl | `{Name}RepositoryImpl` | `AuthRepositoryImpl` |
| DataSource | `{Name}RemoteDataSource` | `AuthRemoteDataSource` |
| Use Case | `{Action}{Noun}UseCase` | `GetUserProfileUseCase` |
| Cubit | `{Feature}Cubit` | `AuthCubit` |
| State | `{Feature}{State}` | `AuthLoading`, `AuthAuthenticated` |
| Params | `{UseCase}Params` | `LoginParams` |

---

## Import Order

Always organize imports in this order with blank lines between groups:

```dart
// 1. Dart SDK
import 'dart:async';
import 'dart:convert';

// 2. Flutter SDK
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 3. Third-party packages (alphabetical)
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 4. Project core
import 'package:coursesapp/core/errors/failures.dart';
import 'package:coursesapp/core/usecases/usecase.dart';

// 5. Project features (current feature first, then others)
import 'package:coursesapp/features/auth/domain/entities/user_entity.dart';
```

---

## Class Structure

### Entity Template

```dart
import 'package:equatable/equatable.dart';

/// Brief description of what this entity represents.
/// 
/// This entity is framework-agnostic and contains only
/// essential business data for the domain layer.
class {Name}Entity extends Equatable {
  // 1. Fields (final, required first, then optional)
  final String id;
  final String name;
  final int? optionalField;

  // 2. Constructor
  const {Name}Entity({
    required this.id,
    required this.name,
    this.optionalField,
  });

  // 3. Computed properties (getters)
  bool get hasOptionalField => optionalField != null;

  // 4. copyWith method
  {Name}Entity copyWith({
    String? id,
    String? name,
    int? optionalField,
  }) {
    return {Name}Entity(
      id: id ?? this.id,
      name: name ?? this.name,
      optionalField: optionalField ?? this.optionalField,
    );
  }

  // 5. Equatable props
  @override
  List<Object?> get props => [id, name, optionalField];

  // 6. toString (optional but helpful for debugging)
  @override
  String toString() => '{Name}Entity(id: $id, name: $name)';
}
```

### Model Template

```dart
import 'package:coursesapp/features/{feature}/domain/entities/{name}_entity.dart';

/// Data model that extends entity with serialization.
/// 
/// Maps to external data sources (Firebase, API, etc.)
class {Name}Model extends {Name}Entity {
  const {Name}Model({
    required super.id,
    required super.name,
    super.optionalField,
  });

  /// Create from JSON/Map (Firebase, API response)
  factory {Name}Model.fromJson(Map<String, dynamic> json) {
    return {Name}Model(
      id: json['id'] as String,
      name: json['name'] as String,
      optionalField: json['optional_field'] as int?,
    );
  }

  /// Convert to JSON/Map for persistence
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'optional_field': optionalField,
    };
  }

  /// Create from entity (for mapping)
  factory {Name}Model.fromEntity({Name}Entity entity) {
    return {Name}Model(
      id: entity.id,
      name: entity.name,
      optionalField: entity.optionalField,
    );
  }
}
```

### Repository Interface Template

```dart
import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import 'package:coursesapp/features/{feature}/domain/entities/{name}_entity.dart';

/// Abstract repository interface for {Feature} operations.
/// 
/// Implementations should handle data source interactions
/// and error mapping.
abstract class {Name}Repository {
  /// Gets a single item by ID
  Future<Either<Failure, {Name}Entity>> getById(String id);

  /// Gets all items
  Future<Either<Failure, List<{Name}Entity>>> getAll();

  /// Creates a new item
  Future<Either<Failure, {Name}Entity>> create({Name}Entity entity);

  /// Updates an existing item
  Future<Either<Failure, Unit>> update({Name}Entity entity);

  /// Deletes an item by ID
  Future<Either<Failure, Unit>> delete(String id);
}
```

### Use Case Template

```dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:coursesapp/core/errors/failures.dart';
import 'package:coursesapp/core/usecases/usecase.dart';
import 'package:coursesapp/features/{feature}/domain/repositories/{name}_repository.dart';

/// Use case to {describe what it does}.
/// 
/// Example:
/// ```dart
/// final result = await useCase(Params(id: '123'));
/// result.fold(
///   (failure) => print(failure.message),
///   (data) => print(data),
/// );
/// ```
class {Action}{Noun}UseCase implements UseCase<{ReturnType}, {Action}{Noun}Params> {
  final {Name}Repository _repository;

  {Action}{Noun}UseCase(this._repository);

  @override
  Future<Either<Failure, {ReturnType}>> call({Action}{Noun}Params params) {
    return _repository.{method}(params.{param});
  }
}

/// Parameters for {Action}{Noun}UseCase
class {Action}{Noun}Params extends Equatable {
  final String param;

  const {Action}{Noun}Params({required this.param});

  @override
  List<Object?> get props => [param];
}
```

### Cubit Template

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coursesapp/features/{feature}/presentation/cubit/{feature}_state.dart';

/// Cubit for managing {Feature} state.
/// 
/// Handles all {feature}-related business operations and state transitions.
class {Feature}Cubit extends Cubit<{Feature}State> {
  // 1. Dependencies (private, prefixed with _)
  final {Action}UseCase _{action}UseCase;

  // 2. Constructor with required dependencies
  {Feature}Cubit({
    required {Action}UseCase {action}UseCase,
  }) : _{action}UseCase = {action}UseCase,
       super(const {Feature}Initial());

  // 3. Public methods for UI to call
  
  /// Loads the {feature} data.
  Future<void> load{Feature}() async {
    emit(const {Feature}Loading());

    final result = await _{action}UseCase(params);

    result.fold(
      (failure) => emit({Feature}Error(failure.message)),
      (data) => emit({Feature}Loaded(data)),
    );
  }

  /// Resets state to initial.
  void reset() => emit(const {Feature}Initial());
}
```

### State Template

```dart
import 'package:equatable/equatable.dart';

/// Base class for all {Feature} states.
sealed class {Feature}State extends Equatable {
  const {Feature}State();

  @override
  List<Object?> get props => [];
}

/// Initial state before any action.
final class {Feature}Initial extends {Feature}State {
  const {Feature}Initial();
}

/// Loading state while fetching data.
final class {Feature}Loading extends {Feature}State {
  const {Feature}Loading();
}

/// Data loaded successfully.
final class {Feature}Loaded extends {Feature}State {
  final {Data} data;

  const {Feature}Loaded(this.data);

  @override
  List<Object?> get props => [data];
}

/// Error state when operation fails.
final class {Feature}Error extends {Feature}State {
  final String message;

  const {Feature}Error(this.message);

  @override
  List<Object?> get props => [message];
}
```

---

## Error Handling

### Failure Classes

```dart
// Always use named parameters for Failure
return Left(ServerFailure(message: 'Error description'));
return Left(NetworkFailure());  // Uses default message
return Left(AuthFailure(message: 'Invalid credentials'));
```

### Repository Error Handling Pattern

```dart
@override
Future<Either<Failure, Entity>> getData() async {
  try {
    final data = await remoteDataSource.getData();
    return Right(data);
  } on FirebaseException catch (e) {
    return Left(FirebaseFailure(message: e.message ?? 'Firebase error'));
  } on SocketException {
    return Left(const NetworkFailure());
  } catch (e) {
    return Left(ServerFailure(message: e.toString()));
  }
}
```

---

## Dependency Injection

### Feature Registration Pattern

```dart
void _init{Feature}Feature() {
  // 1. Data Sources (bottom up)
  sl.registerLazySingleton<{Feature}RemoteDataSource>(
    () => {Feature}RemoteDataSourceImpl(
      firestore: sl(),
      // other dependencies
    ),
  );

  // 2. Repositories
  sl.registerLazySingleton<{Feature}Repository>(
    () => {Feature}RepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // 3. Use Cases
  sl.registerLazySingleton(() => Get{Feature}UseCase(sl()));
  sl.registerLazySingleton(() => Update{Feature}UseCase(sl()));

  // 4. Cubits (Factory for fresh instances)
  sl.registerFactory(
    () => {Feature}Cubit(
      get{Feature}UseCase: sl(),
      update{Feature}UseCase: sl(),
    ),
  );
}
```

---

## Documentation Standards

### File Header (for barrel exports)

```dart
/// {Feature Name} Feature
/// 
/// Clean Architecture implementation for {description}.
/// 
/// ## Usage
/// 
/// ```dart
/// import 'package:coursesapp/features/{feature}/{feature}.dart';
/// 
/// // In widget
/// BlocProvider<{Feature}Cubit>(
///   create: (_) => sl<{Feature}Cubit>()..load(),
///   child: {Feature}Page(),
/// );
/// ```

// Domain
export 'domain/entities/{name}_entity.dart';
// ... other exports
```

### Method Documentation

```dart
/// Brief description of what the method does.
/// 
/// Detailed description if needed.
/// 
/// Parameters:
/// - [param1]: Description of param1
/// - [param2]: Description of param2
/// 
/// Returns [ReturnType] on success.
/// 
/// Throws [ExceptionType] if something goes wrong.
/// 
/// Example:
/// ```dart
/// final result = await method(param1, param2);
/// ```
Future<ReturnType> methodName(Type param1, Type param2) async {
  // implementation
}
```

---

## Testing Conventions

```
test/
├── features/
│   └── {feature}/
│       ├── domain/
│       │   └── usecases/
│       │       └── {usecase}_test.dart
│       ├── data/
│       │   ├── models/
│       │   │   └── {model}_test.dart
│       │   └── repositories/
│       │       └── {repository}_impl_test.dart
│       └── presentation/
│           └── cubit/
│               └── {cubit}_test.dart
└── core/
    └── utils/
        └── {util}_test.dart
```

---

## Quick Reference Checklist

- [ ] File uses correct naming convention (snake_case with suffix)
- [ ] Class uses correct naming convention (PascalCase with suffix)
- [ ] Imports are organized (Dart → Flutter → Packages → Core → Features)
- [ ] Entity extends Equatable with props
- [ ] Model extends Entity with fromJson/toJson
- [ ] Repository uses Either<Failure, T>
- [ ] Use case has Params class
- [ ] Cubit dependencies are private with underscore prefix
- [ ] States extend base state class with Equatable
- [ ] Public APIs have documentation comments
- [ ] Failure uses named `message:` parameter
