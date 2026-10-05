# STRICT FLUTTER REFACTORING TASK

## FREEZED + FPDART + DEPENDENCY CLEANUP + DEAD CODE ONLY

You are working on an existing production Flutter/Dart project.

Your task is strictly limited to **four areas**:

1. `freezed`
2. `freezed_annotation`
3. `fpdart`
4. Safe dependency + dead-code cleanup explicitly listed below

Everything else is OUT OF SCOPE.

---

# 🚨 ABSOLUTE ARCHITECTURE RULES

## DO NOT TOUCH CLEAN ARCHITECTURE

The existing Clean Architecture MUST remain intact.

DO NOT:

* Remove repositories.
* Remove repository interfaces.
* Remove repository implementations.
* Remove data sources.
* Remove use cases EXCEPT the explicitly approved `CalculateNextPrayerUseCase`.
* Merge entities and models.
* Merge architecture layers.
* Move features between layers.
* Change dependency direction.
* Replace Clean Architecture.
* Introduce another architecture.
* Flatten the architecture.
* Redesign dependency injection.
* Perform YAGNI-based architectural cleanup.

Even if a class appears to be a simple wrapper or single implementation:

> **DO NOT REMOVE OR MODIFY IT unless it is explicitly listed in this prompt.**

---

# 🚨 DO NOT TOUCH BLOC / CUBIT ARCHITECTURE

The existing Bloc/Cubit architecture MUST remain unchanged.

DO NOT:

* Remove any Bloc.
* Convert Bloc → Cubit.
* Convert Cubit → Bloc.
* Replace Bloc with Riverpod.
* Replace Bloc with Provider.
* Replace Bloc with ChangeNotifier.
* Replace Bloc with ValueNotifier.
* Replace Bloc with StreamBuilder.
* Merge Blocs.
* Split Blocs.
* Redesign events.
* Redesign states.
* Change business logic.
* Change state transitions.
* Change Bloc responsibilities.

### IMPORTANT

Some Freezed classes may be used for Bloc events/states.

You may update the Freezed implementation of those events/states if required by the Freezed migration.

However:

> **The Bloc architecture, events, states, and behavior MUST remain intact.**

---

# PART 1 — FREEZED

Audit the entire project for:

```text
freezed
freezed_annotation
@freezed
@Freezed
part '*.freezed.dart'
```

Determine which Freezed types should:

* remain Freezed
* or safely migrate to native Dart 3 features.

Prefer native Dart when Freezed provides no meaningful value.

Use:

```dart
sealed class
final class
pattern matching
switch expressions
records
```

where appropriate.

However:

## DO NOT REMOVE FREEZED BLINDLY

Keep Freezed when it provides substantial value, especially for:

* complex immutable models
* complex unions
* large state hierarchies
* extensive `copyWith`
* complicated generated equality
* structures where Freezed materially improves maintainability.

The goal is NOT:

> "Remove Freezed everywhere."

The goal is:

> "Use Freezed only where it provides real value and use native Dart where it is clearly better."

---

# PART 2 — FPDART

`fpdart` MUST REMAIN in the project.

Do NOT remove it.

Audit all usages of:

```dart
Either
Left
Right
Option
Some
None
Task
TaskEither
IO
IOEither
Reader
ReaderEither
```

and functional operations such as:

```dart
map()
flatMap()
fold()
match()
getOrElse()
tryCatch()
```

Improve consistency where appropriate.

Prefer existing project patterns.

Do NOT replace `fpdart` with:

* custom Result classes
* custom sealed Result
* another functional package
* exceptions everywhere

---

# FPDART + EXISTING ARCHITECTURE

Preserve the existing flow:

```text
Presentation
    ↓
Bloc/Cubit
    ↓
UseCase
    ↓
Repository
    ↓
DataSource
```

Do not remove any layer because of fpdart.

For repository/use-case operations, use the project's existing `Failure` hierarchy and patterns.

Prefer consistent types such as:

```dart
Future<Either<Failure, T>>
```

where appropriate.

Do not create duplicate failure classes.

---

# PART 3 — DEPENDENCY CLEANUP

Remove ONLY the following dependencies if the audit confirms they are used solely for the purposes described below.

## 3.1 `syncfusion_flutter_sliders`

Current usage:

* Used only for the Quran audio scrubber / slider.

Replace it with Flutter's native:

```dart
Slider
```

Requirements:

* Preserve the exact existing behavior.
* Preserve min/max values.
* Preserve current position.
* Preserve callbacks.
* Preserve interaction.
* Preserve appearance as closely as reasonably possible.
* Do not redesign the audio player.
* Do not change Quran audio logic.

After migration:

* Remove `syncfusion_flutter_sliders` from `pubspec.yaml`.
* Remove all imports.
* Search the entire project to confirm there are no remaining usages.

---

## 3.2 `screenshot`

Current usage:

* Used for creating shareable images/screenshots in:

  * Tafsir sharing
  * Names of Allah sharing

Replace it with Flutter's native rendering APIs.

Use an appropriate Flutter-native approach such as:

```dart
RenderRepaintBoundary.toImage()
```

or another native Flutter rendering mechanism where appropriate.

Requirements:

* Preserve the existing sharing behavior.
* Preserve generated image quality as much as possible.
* Preserve the widget's visual output.
* Preserve RTL/LTR behavior.
* Preserve text rendering.
* Preserve image dimensions where possible.
* Do not redesign the share UI.

After migration:

* Remove `screenshot` from `pubspec.yaml`.
* Remove all imports/usages.
* Search the entire project for remaining references.

---

## 3.3 `rxdart`

Current usage:

* Used only for throttling/sampling Qiblah updates, specifically `.sampleTime(16ms)`.

Replace the RxDart usage with Dart's native:

```dart
dart:async
```

and a lightweight timestamp/throttling mechanism.

Requirements:

* Preserve the effective update frequency.
* Preserve Qiblah responsiveness.
* Avoid unnecessary rebuilds.
* Do not redesign `QiblahBloc`.
* Do not change Bloc architecture.
* Do not change Qiblah business logic.

After migration:

* Remove `rxdart` from `pubspec.yaml`.
* Remove all imports.
* Search the entire project for remaining RxDart usage.

---

## 3.4 `disable_battery_optimization`

Current usage:

* Used only for disabling battery optimization.

Replace it with the existing:

```dart
permission_handler
```

capability:

```dart
Permission.ignoreBatteryOptimizations
```

Requirements:

* Preserve the existing permission behavior.
* Preserve Android-specific handling.
* Handle unsupported platforms safely.
* Do not introduce another package.
* Do not change unrelated permission behavior.

After migration:

* Remove `disable_battery_optimization` from `pubspec.yaml`.
* Remove all imports/usages.
* Search the entire project for remaining references.

---

# DEPENDENCY CLEANUP SAFETY RULE

Before removing ANY dependency:

1. Search the entire repository.
2. Identify every import.
3. Identify every API usage.
4. Verify the dependency is only used for the explicitly described functionality.
5. Replace all usages.
6. Run static analysis.
7. Run tests.
8. Only then remove the dependency from `pubspec.yaml`.

Do NOT remove a dependency based only on the audit report.

---

# PART 4 — APPROVED DEAD CODE REMOVAL

The following dead code is explicitly approved for removal.

## 4.1 `GoldPriceEntity`

Remove:

```text
lib/features/zakat/domain/entities/gold_price_entity.dart
```

and its generated Freezed file if one exists.

Before deletion:

* Search the entire project for `GoldPriceEntity`.
* Confirm there are no valid references.
* Remove only the unused entity and generated artifacts directly belonging to it.

Do NOT modify the Zakat architecture.

---

# 4.2 `CalculateNextPrayerUseCase`

Remove:

```text
CalculateNextPrayerUseCase
```

including:

* class
* file
* dependency injection registration if present
* imports
* references
* generated artifacts if any

BUT:

Before removing it:

1. Search the entire repository.
2. Confirm there are no runtime usages.
3. Confirm prayer calculation logic already exists elsewhere.
4. Ensure removing the use case does not change prayer calculations.

The existing prayer calculation behavior MUST remain unchanged.

Do NOT use this as an opportunity to redesign the Prayer Times feature.

---

# 4.3 `RateAppHelper.resetReviewState()`

Remove ONLY:

```dart
RateAppHelper.resetReviewState()
```

if confirmed unused.

Do NOT remove:

* `RateAppHelper`
* other valid review functionality
* production rating behavior.

Search all references before deleting.

---

# 4.4 `RateAppHelper.getDebugInfo()`

Remove ONLY:

```dart
getDebugInfo()
```

if confirmed unused.

Do not modify other functionality in `RateAppHelper`.

---

# 🚨 DEAD CODE RULE

Do NOT expand dead-code cleanup beyond the explicitly approved items.

Even if you discover other apparently unused classes, methods, repositories, services, or utilities:

> **DO NOT DELETE THEM.**

Report them in the final report under:

```text
Potential future cleanup
```

but do not modify them.

---

# DO NOT TOUCH THESE AREAS

The following are explicitly OUT OF SCOPE:

* Clean Architecture redesign
* Bloc/Cubit redesign
* Riverpod
* Provider
* UI redesign
* navigation redesign
* API redesign
* database redesign
* authentication redesign
* feature restructuring
* dependency injection redesign
* performance optimization unrelated to this task
* localization redesign
* theme redesign
* networking redesign
* storage redesign
* business logic changes
* feature behavior changes

---

# PUBSPEC REQUIREMENTS

After the migration, verify:

### MUST REMAIN

```yaml
freezed:
freezed_annotation:
fpdart:
```

### SHOULD BE REMOVED ONLY AFTER SUCCESSFUL MIGRATION

```yaml
syncfusion_flutter_sliders:
screenshot:
rxdart:
disable_battery_optimization:
```

Do not remove any of the above if another legitimate usage still exists.

---

# CODE GENERATION

After modifying Freezed code:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Verify:

* no stale `.freezed.dart`
* no broken `part` directives
* no duplicate generated classes
* no missing generated implementations
* no invalid Freezed annotations.

---

# VALIDATION

After all changes run:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter build apk --debug
```

If the project has additional existing validation commands, run them too.

Fix all errors introduced by this migration.

Do NOT:

* weaken analyzer rules
* add `// ignore:` to hide problems
* disable lints
* suppress errors without justification.

---

# PHASED EXECUTION

## PHASE 1 — AUDIT

Inspect the entire project.

Create an internal inventory of:

* Freezed usage
* fpdart usage
* dependency usages
* approved dead-code references
* generated files

DO NOT modify anything during this phase.

---

## PHASE 2 — FREEZED

Perform the Freezed/native Dart migration where justified.

Regenerate code.

Run:

```bash
flutter analyze
```

Fix issues before continuing.

---

## PHASE 3 — FPDART

Standardize/improve fpdart usage.

Preserve all existing architectural boundaries.

Run:

```bash
flutter analyze
flutter test
```

---

## PHASE 4 — DEPENDENCY CLEANUP

Migrate:

1. `syncfusion_flutter_sliders`
2. `screenshot`
3. `rxdart`
4. `disable_battery_optimization`

One dependency at a time.

After each dependency:

* search remaining usages
* analyze
* test
* verify behavior
* then remove from `pubspec.yaml`.

---

## PHASE 5 — APPROVED DEAD CODE

Remove only:

```text
GoldPriceEntity
CalculateNextPrayerUseCase
RateAppHelper.resetReviewState()
RateAppHelper.getDebugInfo()
```

Verify every reference before deletion.

---

## PHASE 6 — FINAL VALIDATION

Run:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter build apk --debug
```

---

# FINAL REPORT

Provide a detailed final report containing:

## 1. Freezed

* What was migrated.
* What remains Freezed.
* Why remaining Freezed usage is justified.
* Number of generated lines removed.

## 2. fpdart

* What was improved.
* Where `Either` is used.
* Any consistency improvements.

## 3. Dependencies

For each:

```text
syncfusion_flutter_sliders
screenshot
rxdart
disable_battery_optimization
```

Report:

* previous usage
* replacement
* files changed
* confirmation of removal.

## 4. Dead Code

Confirm removal of:

```text
GoldPriceEntity
CalculateNextPrayerUseCase
RateAppHelper.resetReviewState()
RateAppHelper.getDebugInfo()
```

## 5. Architecture Safety

Explicitly confirm:

```text
Clean Architecture: NOT CHANGED
BLoC/Cubit Architecture: NOT CHANGED
Business Logic: NOT CHANGED
Feature Structure: NOT CHANGED
```

## 6. Validation

Report results for:

```text
flutter analyze
flutter test
flutter build apk --debug
```

## 7. Potential Future Cleanup

If you discover other questionable code, list it here only.

DO NOT modify it.

---

# FINAL HARD CONSTRAINT

The allowed scope is ONLY:

```text
FREEZED
+
FREEZED_ANNOTATION
+
FPDART
+
4 SPECIFIC DEPENDENCIES
+
4 SPECIFIC DEAD-CODE ITEMS
```

Nothing else.

If a change is not directly related to these items:

> **DO NOT MAKE THE CHANGE.**

When in doubt:

> **PRESERVE THE EXISTING CODE AND ARCHITECTURE.**
