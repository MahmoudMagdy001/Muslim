You are a Senior Flutter/Dart Architect and Clean Architecture expert.

TASK:
Perform a COMPLETE project-wide migration from Equatable to Freezed AND introduce fpdart properly across the architecture.

This is NOT a simple package replacement.

You must:
1. Completely migrate appropriate Equatable usage to Freezed.
2. Introduce fpdart for functional error handling and composable asynchronous operations.
3. Preserve all existing business behavior.
4. Improve the architecture where necessary without over-engineering.
5. Execute the migration PHASE BY PHASE.
6. Validate every phase before continuing.

==================================================
PROJECT ARCHITECTURE TARGET
==================================================

The target architecture should follow:

Flutter
│
├── Presentation
│   ├── Pages / Screens
│   ├── Widgets
│   └── Cubit / Bloc
│
├── Domain
│   ├── Entities
│   ├── Repository Contracts
│   ├── Use Cases
│   └── Failures
│
└── Data
    ├── Models / DTOs
    ├── Data Sources
    ├── Repository Implementations
    └── Services

Core principles:

- Freezed → immutable models, entities, states, events, unions
- fpdart → functional error handling and composable operations
- Repository → Either<Failure, Data>
- UseCase → Either / TaskEither where appropriate
- Cubit/Bloc → consumes domain results and maps them into UI states
- Exceptions → handled at Data layer and converted into domain Failures
- UI → should NOT deal with raw exceptions
- Domain layer → should NOT depend on Flutter/framework-specific code

==================================================
PHASE 1 — FULL PROJECT AUDIT
==================================================

Before changing anything, scan the ENTIRE project.

Identify:

### Equatable
- extends Equatable
- EquatableMixin
- props
- manual == implementations
- manual hashCode implementations

### Models
- API models
- DTOs
- entities
- request models
- response models

### State Management
- Cubits
- Blocs
- States
- Events

### Error Handling
Find:

- try/catch
- throw
- rethrow
- Exception
- custom exceptions
- generic Exception
- DioException
- HTTP errors
- repository errors
- API errors
- manually returned null on failure
- boolean success/failure patterns
- Result-like custom classes

### Architecture
Identify:

- Data layer
- Domain layer
- Presentation layer
- repositories
- use cases
- services
- data sources
- dependency injection

### Dependencies
Inspect:

- pubspec.yaml
- current Dart version
- current Flutter version
- freezed/freezed_annotation
- json_serializable
- build_runner
- existing functional programming packages

DO NOT modify anything during this phase.

Create a migration report first.

==================================================
PHASE 2 — DEPENDENCIES
==================================================

Add only the required dependencies.

Runtime:

freezed_annotation
fpdart

Development:

freezed
build_runner

If JSON serialization is already used:

json_annotation
json_serializable

DO NOT upgrade unrelated packages.

DO NOT introduce another functional programming package.

DO NOT introduce another state management package.

After modifying pubspec.yaml:

flutter pub get

==================================================
PHASE 3 — FREEZED MIGRATION
==================================================

Migrate appropriate Equatable classes to Freezed.

Use Freezed for:

- immutable entities
- immutable models
- DTOs
- request/response objects
- Cubit/Bloc states
- Bloc events
- sealed state/event hierarchies

Example:

BEFORE:

class User extends Equatable {
  final String id;
  final String name;

  const User({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

AFTER:

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
  }) = _User;
}

For JSON:

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
}

Preserve:

- field names
- nullability
- default values
- JSON keys
- serialization behavior
- API contracts
- custom converters
- business logic

==================================================
PHASE 4 — FREEZED STATE MIGRATION
==================================================

Inspect every Cubit and Bloc state.

Use Freezed unions for mutually exclusive states.

Example:

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitial;

  const factory LoginState.loading() = LoginLoading;

  const factory LoginState.success({
    required User user,
  }) = LoginSuccess;

  const factory LoginState.failure({
    required Failure failure,
  }) = LoginFailure;
}

Use:

when
maybeWhen
map
maybeMap

or Dart pattern matching where appropriate.

Do NOT blindly convert every state into a union.

For states representing multiple independent values, use:

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    User? user,
    String? error,
  }) = _HomeState;
}

Choose based on actual semantics.

==================================================
PHASE 5 — FPDART FOUNDATION
==================================================

Introduce a centralized functional programming strategy.

Use:

Either<L, R>

for operations that can fail.

Use:

TaskEither<L, R>

for asynchronous operations where composability is beneficial.

Use:

Option<T>

only when absence is semantically meaningful and preferable to nullable values.

Do NOT replace every nullable field with Option.

Do NOT use functional abstractions simply for the sake of using fpdart.

==================================================
PHASE 6 — DOMAIN FAILURE SYSTEM
==================================================

Create or improve a centralized domain failure hierarchy.

Prefer Freezed for Failure modeling.

Example:

@freezed
class Failure with _$Failure {
  const factory Failure.server({
    String? message,
  }) = ServerFailure;

  const factory Failure.network({
    String? message,
  }) = NetworkFailure;

  const factory Failure.unauthorized({
    String? message,
  }) = UnauthorizedFailure;

  const factory Failure.notFound({
    String? message,
  }) = NotFoundFailure;

  const factory Failure.validation({
    String? message,
  }) = ValidationFailure;

  const factory Failure.cache({
    String? message,
  }) = CacheFailure;

  const factory Failure.unknown({
    String? message,
  }) = UnknownFailure;
}

Adapt the actual failure categories to the existing project.

DO NOT create unnecessary failure types.

Failure must be domain-friendly and must not expose Dio/HTTP implementation details to Domain.

==================================================
PHASE 7 — DATA EXCEPTIONS
==================================================

Keep technical exceptions in the Data layer.

For example:

- DioException
- SocketException
- FormatException
- server-specific exceptions

Map them into domain Failure.

Example concept:

DioException
        ↓
Data Exception
        ↓
Failure
        ↓
Either<Failure, Success>

Do NOT expose DioException to the UI.

Do NOT expose raw Exception objects from repositories.

==================================================
PHASE 8 — REPOSITORY MIGRATION
==================================================

Review every repository contract.

Change methods that currently throw exceptions or return ambiguous results.

Example:

BEFORE:

Future<User> getUser();

AFTER:

Future<Either<Failure, User>> getUser();

Or, when TaskEither improves composability:

TaskEither<Failure, User> getUser();

Choose ONE consistent strategy for the project.

Do not randomly mix:

Future<Either<Failure, T>>

and

TaskEither<Failure, T>

without architectural justification.

Repository interfaces belong to Domain.

Repository implementations belong to Data.

==================================================
PHASE 9 — DATASOURCE MIGRATION
==================================================

Data sources may continue using technical exceptions internally.

Example:

RemoteDataSource:

Future<UserModel> getUser();

Repository implementation:

Future<Either<Failure, User>> getUser() async {
  try {
    final model = await remoteDataSource.getUser();

    return Right(model.toEntity());
  } on DioException catch (e) {
    return Left(mapDioExceptionToFailure(e));
  } catch (e) {
    return Left(
      const Failure.unknown(),
    );
  }
}

Improve this according to the project's existing architecture.

Do not allow infrastructure exceptions to leak into Domain or Presentation.

==================================================
PHASE 10 — USE CASES
==================================================

Introduce or improve Use Cases where the project architecture supports them.

Example:

class GetUser {
  final UserRepository repository;

  const GetUser(this.repository);

  Future<Either<Failure, User>> call() {
    return repository.getUser();
  }
}

If TaskEither is used:

TaskEither<Failure, User> call() {
  return repository.getUser();
}

Use cases should:

- contain business rules
- compose repository operations
- return domain-safe results
- avoid UI concerns
- avoid Flutter dependencies

==================================================
PHASE 11 — FPDART COMPOSITION
==================================================

Where multiple dependent operations exist, use fpdart composition instead of deeply nested try/catch blocks.

Example concept:

repository
  .getUser()
  .flatMap(...)
  .map(...)
  .mapLeft(...)

For asynchronous pipelines, consider:

TaskEither

when it makes the flow clearer.

DO NOT force functional chaining where ordinary Dart is more readable.

Readability and maintainability are more important than maximizing fpdart usage.

==================================================
PHASE 12 — CUBIT INTEGRATION
==================================================

Cubits should consume Either/TaskEither results.

Example:

Future<void> loadUser() async {
  emit(const UserState.loading());

  final result = await getUser();

  result.fold(
    (failure) => emit(
      UserState.failure(failure: failure),
    ),
    (user) => emit(
      UserState.success(user: user),
    ),
  );
}

Do NOT:

- throw domain failures from Cubit
- catch repository implementation exceptions in Cubit
- expose DioException to UI
- duplicate error mapping in every Cubit

Error mapping should happen in the appropriate layer.

==================================================
PHASE 13 — REMOVE EQUATABLE COMPLETELY
==================================================

Search the entire project again.

Remove:

- Equatable imports
- extends Equatable
- EquatableMixin
- props
- redundant == overrides
- redundant hashCode implementations

Remove Equatable from pubspec.yaml if no longer needed.

There must be ZERO unnecessary Equatable usage.

If any Equatable reference remains, document exactly why.

==================================================
PHASE 14 — GENERATED FILES
==================================================

Generate all Freezed/JSON files:

dart run build_runner build --delete-conflicting-outputs

Never manually edit:

*.freezed.dart
*.g.dart

If generation fails:

1. Read the actual error.
2. Fix the source.
3. Regenerate.
4. Repeat until successful.

==================================================
PHASE 15 — ARCHITECTURE REVIEW
==================================================

Review the entire project after migration.

Verify:

Presentation
↓
Cubit/Bloc
↓
Use Case
↓
Repository Contract
↓
Repository Implementation
↓
Data Source
↓
API / Local Storage

And errors flow as:

Technical Exception
↓
Data Error Mapping
↓
Domain Failure
↓
Either<Failure, T>
↓
Cubit
↓
Freezed UI State
↓
UI

Ensure Domain does not depend on:

- Flutter
- Dio
- Supabase implementation details
- HTTP implementation details
- Data-layer exceptions

==================================================
PHASE 16 — QUALITY RULES
==================================================

Do NOT:

- use fpdart everywhere
- replace every nullable field with Option
- convert every Future into TaskEither
- create unnecessary UseCases
- create unnecessary Failure types
- create unnecessary Freezed classes
- introduce abstractions without value
- change business logic unnecessarily
- change API contracts
- change backend behavior
- change UI behavior unnecessarily
- introduce Bloc if Cubit is already appropriate

DO:

- keep the architecture simple
- use Freezed where immutability/equality/unions are useful
- use Either for explicit recoverable failures
- use TaskEither when asynchronous composition benefits from it
- keep technical exceptions in Data
- keep domain failures in Domain
- keep UI states immutable
- preserve existing behavior

==================================================
PHASE 17 — VALIDATION
==================================================

Run:

flutter pub get

dart run build_runner build --delete-conflicting-outputs

flutter analyze

flutter test

If tests do not exist, report that clearly.

Fix ALL errors introduced by the migration.

Do not suppress analyzer errors.

Do not use ignore comments to hide migration problems.

==================================================
PHASE 18 — FINAL PROJECT-WIDE SCAN
==================================================

Perform a final complete scan.

Verify:

### Equatable
ZERO unnecessary Equatable references.

### Freezed
All intended models/states/events use Freezed.

### fpdart
Repository and UseCase error handling consistently follows the selected Either/TaskEither strategy.

### Architecture
Domain does not depend on Data implementation details.

### Error handling
No raw technical exceptions leak into Presentation.

### Serialization
All JSON serialization still works.

### State management
Cubit/Bloc state transitions remain correct.

### Build
Project builds successfully.

### Analyze
flutter analyze passes.

### Tests
Existing tests pass.

==================================================
FINAL REPORT
==================================================

Provide:

1. Equatable usages before migration.
2. Equatable usages after migration.
3. Number of models migrated to Freezed.
4. Number of entities migrated.
5. Number of states migrated.
6. Number of events migrated.
7. Number of Failure types created.
8. Number of repositories migrated to Either/TaskEither.
9. Number of UseCases updated/created.
10. Number of technical exceptions mapped to domain failures.
11. Whether Equatable was removed from pubspec.yaml.
12. Whether Freezed generation succeeded.
13. Whether flutter analyze passes.
14. Whether tests pass.
15. Any remaining Equatable usage and justification.
16. Any remaining technical exceptions exposed outside Data.
17. Any files requiring manual review.
18. Summary of architecture improvements.

MOST IMPORTANT:

DO NOT JUST GIVE ME INSTRUCTIONS.

ACTUALLY PERFORM THE MIGRATION.

Work PHASE BY PHASE.

After completing each phase:
- validate it
- fix issues
- continue to the next phase

Do not stop until the entire project has been migrated, generated, analyzed, tested, and reviewed.