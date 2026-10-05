# FLUTTER PRODUCTION PERFORMANCE & GOOGLE PLAY RELEASE AUDIT

You are working on an existing production Flutter application.

The primary objective is to perform a **complete production-readiness, performance, stability, resource-usage, build, Android, and Google Play release audit** and implement all safe, evidence-based improvements required before publishing the next version to Google Play.

This is an existing application.

Your job is NOT to rewrite the application.

Your job is to:

> **AUDIT → IDENTIFY → MEASURE → FIX → VALIDATE → VERIFY → PREPARE FOR RELEASE**

The final application must be stable, performant, memory-efficient, battery-conscious, startup-efficient, release-ready, and compliant with modern Google Play / Android expectations.

---

# 🚨 ABSOLUTE ARCHITECTURE RULES

## DO NOT REDESIGN THE EXISTING ARCHITECTURE

The existing architecture MUST remain intact.

If the project currently uses:

```text
Clean Architecture
Feature-First
Repository Pattern
BLoC/Cubit
Dependency Injection
Freezed
fpdart
```

preserve these architectural decisions.

DO NOT:

* Replace Clean Architecture.
* Replace BLoC/Cubit.
* Introduce Riverpod.
* Introduce Provider.
* Introduce another state-management solution.
* Merge architectural layers.
* Remove repositories.
* Remove data sources.
* Remove use cases unless explicitly proven dead and already approved.
* Move features between layers.
* Redesign dependency injection.
* Rewrite the application architecture.

Performance optimization must happen **inside the existing architecture**.

---

# 🚨 DO NOT CHANGE BUSINESS BEHAVIOR

Do not change:

* business rules
* API contracts
* database behavior
* authentication behavior
* prayer calculations
* Quran behavior
* Azkar behavior
* Qiblah behavior
* notifications
* audio behavior
* localization behavior
* navigation behavior
* user preferences
* persistence behavior

unless the change is strictly required to fix a proven performance, stability, compatibility, or release issue.

Behavioral equivalence is mandatory.

---

# OBJECTIVES

Audit and optimize the application across all of the following:

1. Startup performance
2. App launch time
3. First frame rendering
4. Time to interactive
5. UI rendering performance
6. Flutter frame performance
7. Jank
8. Widget rebuilds
9. BLoC/Cubit rebuilds
10. Memory usage
11. Memory leaks
12. Garbage collection pressure
13. CPU usage
14. Battery usage
15. Network performance
16. API calls
17. Database/local storage performance
18. Image performance
19. Audio performance
20. Scrolling performance
21. Background tasks
22. Timers
23. Streams
24. Subscriptions
25. Isolates
26. Async operations
27. Disk I/O
28. JSON parsing
29. Large collections
30. Expensive computations
31. App size
32. APK/AAB size
33. Android configuration
34. Release configuration
35. R8/shrinking
36. ProGuard rules
37. Native Android compatibility
38. Android 15+ compatibility
39. Google Play release readiness
40. Crash/stability risks

---

# PHASE 0 — FULL PROJECT DISCOVERY

Before changing anything, inspect the entire project.

Inspect:

```text
pubspec.yaml
android/
ios/
lib/
assets/
test/
integration_test/
build configuration
Gradle configuration
AndroidManifest.xml
ProGuard/R8 rules
```

Identify:

* Flutter version
* Dart version
* compileSdk
* targetSdk
* minSdk
* AGP version
* Gradle version
* Kotlin version
* Java/JDK version
* architecture
* state management
* networking
* storage
* audio
* notifications
* permissions
* background services
* analytics
* crash reporting
* image handling
* code generation
* large dependencies.

Do NOT modify anything during discovery.

Create an internal performance inventory.

---

# PHASE 1 — BASELINE MEASUREMENTS

Do NOT optimize blindly.

Establish a baseline first.

Measure where possible:

* debug performance
* profile performance
* release performance
* cold startup
* warm startup
* first frame
* first useful frame
* screen transition time
* scrolling smoothness
* memory usage
* CPU usage
* network requests
* disk operations
* APK/AAB size.

Use Flutter profiling tools where available.

Prefer evidence over assumptions.

For every major optimization:

```text
BEFORE
↓
CHANGE
↓
AFTER
```

Record measurable improvement when possible.

---

# PHASE 2 — STARTUP PERFORMANCE

Audit application startup.

Inspect:

* `main()`
* initialization order
* dependency injection initialization
* SharedPreferences initialization
* Hive initialization
* database initialization
* Firebase initialization
* notification initialization
* audio initialization
* location initialization
* permissions
* services
* network calls
* synchronous file I/O
* heavy object creation
* unnecessary startup dependencies.

Find work that blocks the first frame.

Do NOT initialize expensive services before they are needed.

Prefer:

```text
Critical initialization
        ↓
First frame
        ↓
Deferred initialization
```

Use lazy initialization where safe.

Do NOT delay anything required for correct application behavior.

---

# PHASE 3 — UI RENDERING & JANK

Audit all important screens.

Pay particular attention to:

* Home
* Prayer Times
* Quran
* Azkar
* Qiblah
* Settings
* Lists
* Audio player
* Tafsir
* Names of Allah.

Look for:

* unnecessary rebuilds
* large widget trees
* expensive build methods
* expensive calculations inside `build()`
* repeated formatting
* repeated parsing
* unnecessary `setState`
* unnecessary Bloc rebuilds
* missing `buildWhen`
* missing `BlocSelector`
* unnecessary listeners
* animations causing jank
* expensive layouts
* nested scrolling
* oversized widgets
* excessive opacity operations
* unnecessary clipping
* unnecessary saveLayer usage.

IMPORTANT:

Do not rewrite BLoC/Cubit architecture.

Optimize consumption of existing states only when it is safe.

---

# PHASE 4 — BLOC/CUBIT PERFORMANCE

Keep the existing Bloc/Cubit architecture.

Audit:

* event frequency
* state frequency
* redundant emissions
* duplicate states
* unnecessary rebuilds
* listeners
* subscriptions
* stream transformations
* timers
* debounce/throttle behavior.

Use appropriate existing Flutter Bloc mechanisms such as:

```dart
BlocBuilder
BlocSelector
buildWhen
listenWhen
BlocListener
```

when they reduce unnecessary work.

Do NOT convert:

```text
Bloc → Cubit
Cubit → Bloc
Bloc → Riverpod
```

This is strictly prohibited.

---

# PHASE 5 — MEMORY OPTIMIZATION

Audit for memory problems.

Look for:

* controllers not disposed
* AnimationController leaks
* ScrollController leaks
* TextEditingController leaks
* StreamSubscription leaks
* timers not cancelled
* listeners not removed
* audio resources not released
* image caches
* large lists retained in memory
* unnecessary duplicate data
* static references
* closures retaining large objects
* large JSON structures
* unnecessary caching.

Verify lifecycle methods:

```dart
initState
dispose
didChangeDependencies
```

and equivalent lifecycle handling.

Fix actual leaks.

Do not introduce premature caching.

---

# PHASE 6 — LIST & SCROLL PERFORMANCE

Audit every large or potentially large list.

Look for:

* `ListView` with unnecessary eager children
* `Column` containing large lists
* unnecessary `shrinkWrap`
* nested scroll views
* expensive item builders
* rebuilding every item
* large widget trees per item
* unnecessary keys
* excessive layout calculations.

Prefer lazy rendering:

```dart
ListView.builder
ListView.separated
GridView.builder
SliverList
```

where appropriate.

Do not change UX.

---

# PHASE 7 — IMAGE PERFORMANCE

Audit all images.

Check:

* image dimensions
* resolution
* file sizes
* decoding cost
* cache behavior
* network images
* local assets
* unnecessary oversized images.

Do not load a 3000px image when a 300px image is sufficient.

Check:

* `cacheWidth`
* `cacheHeight`
* appropriate formats
* asset optimization.

Do NOT degrade visual quality unnecessarily.

---

# PHASE 8 — AUDIO PERFORMANCE

Audit Quran/audio functionality.

Check:

* initialization
* player lifecycle
* buffering
* streams
* subscriptions
* background audio
* notification integration
* memory
* unnecessary updates
* position update frequency.

Avoid rebuilding the entire player UI for every tiny position update.

Preserve:

* play
* pause
* seek
* next
* previous
* background playback
* lock-screen controls
* notification controls.

---

# PHASE 9 — NETWORK PERFORMANCE

Audit every API/network flow.

Look for:

* duplicate requests
* unnecessary requests
* requests triggered during rebuild
* missing caching
* repeated API calls
* excessive polling
* unnecessary payloads
* poor timeout configuration
* missing cancellation
* sequential requests that could safely be parallelized.

Prefer:

```dart
Future.wait(...)
```

when operations are independent.

Do not parallelize operations that have dependencies.

Check:

* connection timeout
* receive timeout
* send timeout
* retry behavior
* error handling.

Do not introduce aggressive retries.

---

# PHASE 10 — JSON / DATA PROCESSING

Look for expensive:

* JSON parsing
* mapping
* sorting
* filtering
* date conversion
* formatting
* calculations.

Do not perform heavy transformations repeatedly inside `build()`.

Cache or precompute only when justified.

For genuinely heavy CPU work, evaluate whether an isolate is appropriate.

Do NOT introduce isolates unnecessarily.

---

# PHASE 11 — LOCAL STORAGE

Audit:

* SharedPreferences
* Hive
* SQLite
* local files
* caches.

Look for:

* synchronous disk access
* repeated reads
* repeated writes
* writes during build
* unnecessary serialization
* large objects being stored unnecessarily.

Avoid excessive persistence operations.

Batch or defer writes where safe.

---

# PHASE 12 — STREAMS / TIMERS / BACKGROUND WORK

Audit:

* Stream subscriptions
* timers
* periodic timers
* notifications
* location updates
* Qiblah updates
* audio streams
* connectivity monitoring.

Check:

* subscription lifecycle
* update frequency
* cancellation
* duplicate listeners
* unnecessary background activity.

Battery usage is especially important.

Do not keep high-frequency streams active when their screen is not visible unless required.

---

# PHASE 13 — BATTERY OPTIMIZATION

Identify unnecessary background work.

Look for:

* frequent timers
* high-frequency streams
* location polling
* repeated network requests
* unnecessary wakeups
* continuous sensor listeners.

Optimize frequency without breaking functionality.

Pay particular attention to:

* Qiblah
* prayer notifications
* audio
* periodic reminders
* connectivity.

Do not disable required background functionality.

---

# PHASE 14 — DEPENDENCY AUDIT

Audit every dependency in `pubspec.yaml`.

For each package determine:

* Is it actually used?
* Is it used in production?
* Is there duplicate functionality?
* Is it expensive?
* Does Flutter/Dart already provide the functionality?
* Is there a lighter alternative?

Remove ONLY dependencies proven unnecessary.

Do not remove:

```text
freezed
freezed_annotation
fpdart
```

if they are part of the intended architecture.

Do not remove packages simply because they are small or appear unnecessary.

Validate every removal.

---

# PHASE 15 — CODE GENERATION

Audit:

* Freezed
* JSON serialization
* generated code
* build_runner.

Ensure generated code is not unnecessarily duplicated.

Do not manually edit generated files.

After changes run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

# PHASE 16 — ANDROID RELEASE CONFIGURATION

Perform a complete Android release audit.

Inspect:

```text
android/app/build.gradle
android/build.gradle
android/settings.gradle
gradle.properties
AndroidManifest.xml
proguard-rules.pro
```

Verify:

* compileSdk
* targetSdk
* minSdk
* Java version
* Kotlin version
* AGP compatibility
* Gradle compatibility
* namespace
* release signing
* shrinker
* resource shrinking
* minification
* multidex requirements
* ABI configuration.

Do not blindly upgrade versions.

Only upgrade when compatibility and stability are verified.

---

# PHASE 17 — R8 / MINIFICATION

Evaluate release shrinking.

Verify whether:

```text
minifyEnabled
shrinkResources
R8
```

are correctly configured for release.

Check all third-party libraries for required keep rules.

Do NOT disable R8 merely because of a warning.

Do NOT add broad keep rules such as keeping the entire application.

Use the smallest necessary keep rules.

---

# PHASE 18 — APP SIZE OPTIMIZATION

Build release artifacts.

Measure:

```text
APK size
AAB size
```

Identify large contributors.

Inspect:

* assets
* fonts
* images
* native libraries
* dependencies.

Use:

```bash
flutter build appbundle --release
```

and analyze the output.

Do not remove assets required by the application.

---

# PHASE 19 — ANDROID 15+ COMPATIBILITY

Audit compatibility with modern Android versions.

Pay attention to:

* edge-to-edge
* notification permissions
* background restrictions
* foreground services
* exact alarms
* storage permissions
* battery optimization
* Android 15 behavior changes
* deprecated APIs
* notification behavior
* predictive back/navigation
* system bars.

Do not introduce compatibility workarounds unless required.

---

# PHASE 20 — PERMISSIONS AUDIT

Review every permission.

For each permission determine:

* why it exists
* where it is used
* whether it is required
* whether it is requested at the correct time
* whether it is required for Google Play declarations.

Remove unused permissions.

Do not request permissions at startup unless absolutely necessary.

Prefer requesting permissions contextually.

---

# PHASE 21 — CRASH & STABILITY AUDIT

Search for:

* `!` that can realistically fail
* unsafe casts
* `late` initialization risks
* unhandled Futures
* unhandled stream errors
* empty catch blocks
* swallowed exceptions
* race conditions
* disposed widget access
* `setState()` after dispose
* async lifecycle problems
* platform exceptions.

Fix real crash risks.

Do not hide errors.

---

# PHASE 22 — ERROR HANDLING

Verify that failures are correctly propagated.

Preserve the existing:

```text
fpdart
Failure
Either
Bloc/Cubit
UI
```

flow.

Do not introduce generic `try/catch` blocks everywhere.

Do not silently ignore errors.

Do not expose internal exceptions to users.

---

# PHASE 23 — RELEASE BUILD

Create a real release build.

Run:

```bash
flutter clean
flutter pub get

dart run build_runner build --delete-conflicting-outputs

flutter analyze
flutter test

flutter build appbundle --release
```

If signing is configured and safe to validate, verify the signed release artifact.

---

# PHASE 24 — REAL DEVICE TESTING

If a physical Android device/emulator is available, test the release build.

Test:

### Startup

* cold launch
* warm launch
* background → foreground

### Navigation

* every major screen
* rapid navigation
* back navigation

### Quran

* open Surah
* scroll
* play audio
* seek
* background audio
* lock screen

### Prayer Times

* refresh
* location
* notifications

### Qiblah

* sensor updates
* rotation
* screen lifecycle

### Azkar

* large lists
* audio
* progress

### Settings

* theme
* language
* font size
* persistence

### Network

* online
* offline
* slow network
* failed requests

### Lifecycle

* rotate if supported
* background
* foreground
* process recreation where possible.

---

# PHASE 25 — PERFORMANCE REGRESSION CHECK

After all optimizations compare:

```text
BEFORE
vs
AFTER
```

for:

* startup
* frame performance
* jank
* memory
* CPU
* battery-sensitive operations
* network calls
* app size.

Do not claim improvement without evidence.

If something cannot be measured, explicitly say:

```text
Not measured
```

instead of inventing numbers.

---

# PHASE 26 — FINAL GOOGLE PLAY READINESS CHECKLIST

Verify:

## Build

* [ ] Release build succeeds.
* [ ] AAB generated successfully.
* [ ] No build errors.
* [ ] No unexpected warnings.
* [ ] Correct version name.
* [ ] Correct version code.

## Android

* [ ] targetSdk is appropriate.
* [ ] compileSdk is appropriate.
* [ ] Release signing is correct.
* [ ] R8 works.
* [ ] No unnecessary permissions.
* [ ] Android 15+ compatibility checked.

## Performance

* [ ] Startup optimized.
* [ ] No obvious jank.
* [ ] No unnecessary rebuilds.
* [ ] No obvious memory leaks.
* [ ] No unnecessary background work.
* [ ] Network requests audited.
* [ ] Large lists optimized.
* [ ] Images optimized.
* [ ] Audio lifecycle verified.

## Stability

* [ ] No obvious crash risks.
* [ ] Async lifecycle safe.
* [ ] Streams disposed.
* [ ] Controllers disposed.
* [ ] Errors handled.
* [ ] Release build tested.

## Dependencies

* [ ] No unnecessary dependency remains without justification.
* [ ] Required dependencies preserved.
* [ ] Generated code valid.

---

# 🚨 WHAT YOU MUST NOT DO

Do NOT:

* rewrite the application
* redesign architecture
* migrate BLoC
* migrate Cubit
* migrate to Riverpod
* migrate to Provider
* redesign UI
* change business logic
* remove Clean Architecture
* remove repositories
* remove data sources
* remove use cases unless explicitly approved
* change APIs
* change database schema
* change authentication
* change navigation
* blindly upgrade every dependency
* blindly add packages
* optimize without measurement
* make speculative optimizations
* hide analyzer errors
* disable lints
* suppress warnings without justification.

---

# EXECUTION RULE

Work phase-by-phase.

For every phase:

1. Audit.
2. Identify actual problems.
3. Measure when possible.
4. Make the smallest safe change.
5. Run validation.
6. Confirm no regression.
7. Continue.

Do NOT make hundreds of unrelated changes at once.

Keep the project buildable after every major phase.

---

# FINAL REPORT

At the end provide a production-quality report containing:

## Executive Summary

* Overall release readiness.
* Critical issues.
* High-priority issues.
* Medium-priority issues.
* Low-priority issues.

## Performance

Report:

* startup improvements
* rendering improvements
* rebuild reductions
* memory improvements
* CPU improvements
* network improvements
* battery improvements
* app size improvements.

Use actual measurements only.

## Architecture

Explicitly confirm:

```text
Clean Architecture: PRESERVED
BLoC/Cubit: PRESERVED
Business Logic: PRESERVED
Feature Structure: PRESERVED
```

## Dependencies

List:

* removed
* retained
* upgraded
* reason for each change.

## Android

Report:

* compileSdk
* targetSdk
* minSdk
* AGP
* Gradle
* Java
* Kotlin
* R8
* resource shrinking
* release configuration.

## Release

Report:

```text
flutter analyze
flutter test
flutter build appbundle --release
```

and whether each succeeded.

## Remaining Risks

List anything that still needs manual testing or cannot be verified automatically.

## Final Recommendation

End with one of:

```text
READY FOR GOOGLE PLAY
```

or

```text
NOT READY FOR GOOGLE PLAY
```

If NOT READY, clearly list the blocking issues.

---

# FINAL HARD CONSTRAINT

This project is being prepared for a real production release.

Therefore:

> **STABILITY > PERFORMANCE**

and:

> **MEASURED OPTIMIZATION > SPECULATIVE OPTIMIZATION**

and:

> **MINIMAL SAFE CHANGE > LARGE REFACTOR**

Preserve the existing architecture and application behavior.

Do not optimize something merely because it looks theoretically inefficient.

Only make changes that are technically justified, measurable where possible, and safe for production.

The final goal is:

> **A stable, fast, memory-efficient, battery-conscious, crash-resistant Flutter release build that is ready for Google Play publication.**
