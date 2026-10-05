
import 'package:flutter_test/flutter_test.dart';
import 'package:muslim/core/bloc/safe_bloc.dart';

// Test Event & State
sealed class TestEvent {
  const TestEvent();
}

class IncrementEvent extends TestEvent {
  const IncrementEvent();
}

class DelayedIncrementEvent extends TestEvent {
  const DelayedIncrementEvent();
}

class TestState {
  const TestState({required this.count, this.isLoading = false});
  final int count;
  final bool isLoading;
}

class TestSafeBloc extends SafeBloc<TestEvent, TestState> {
  TestSafeBloc() : super(const TestState(count: 0)) {
    on<IncrementEvent>((event, emit) {
      emit(TestState(count: state.count + 1));
    });

    on<DelayedIncrementEvent>((event, emit) async {
      emit(TestState(count: state.count, isLoading: true));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      if (!isClosed) {
        emit(TestState(count: state.count + 1));
      }
    });
  }

  Future<void> delayedIncrement() async {
    await safeDispatch(
      const DelayedIncrementEvent(),
      until: (s) => !s.isLoading && s.count > 0,
    );
  }
}

void main() {
  group('SafeBloc Tests', () {
    late TestSafeBloc bloc;

    setUp(() {
      bloc = TestSafeBloc();
    });

    tearDown(() async {
      if (!bloc.isClosed) {
        await bloc.close();
      }
    });

    test('safeAdd adds event when bloc is open', () async {
      final added = bloc.safeAdd(const IncrementEvent());
      expect(added, isTrue);

      await expectLater(
        bloc.stream,
        emits(predicate<TestState>((s) => s.count == 1)),
      );
    });

    test('safeAdd returns false and does not throw when bloc is closed', () async {
      await bloc.close();
      final added = bloc.safeAdd(const IncrementEvent());
      expect(added, isFalse);
    });

    test('safeFirstWhere returns immediately if state already matches', () async {
      final result = await bloc.safeFirstWhere((s) => s.count == 0);
      expect(result.count, 0);
    });

    test('safeFirstWhere returns fallback if bloc is already closed', () async {
      await bloc.close();
      final result = await bloc.safeFirstWhere(
        (s) => s.count == 99,
        fallbackState: const TestState(count: -1),
      );
      expect(result.count, -1);
    });

    test('safeFirstWhere does NOT throw StateError when bloc is closed while waiting', () async {
      // Start waiting for an event that will never come because we close the bloc
      final future = bloc.safeFirstWhere(
        (s) => s.count == 100,
        fallbackState: const TestState(count: 999),
      );

      // Close the bloc while waiting
      await Future<void>.delayed(const Duration(milliseconds: 20));
      await bloc.close();

      final result = await future;
      expect(result.count, 999);
    });

    test('safeDispatch succeeds when completing normally', () async {
      await bloc.delayedIncrement();
      expect(bloc.state.count, 1);
      expect(bloc.state.isLoading, isFalse);
    });

    test('safeDispatch does not throw if closed while loading', () async {
      final future = bloc.delayedIncrement();

      // Screen pops: close bloc during loading
      await Future<void>.delayed(const Duration(milliseconds: 10));
      await bloc.close();

      // Must complete peacefully without unhandled exception
      await expectLater(future, completes);
    });

    test('safeFirstWhere handles timeout without throwing TimeoutException', () async {
      final result = await bloc.safeFirstWhere(
        (s) => s.count == 50,
        timeout: const Duration(milliseconds: 50),
        fallbackState: const TestState(count: -99),
      );
      expect(result.count, -99);
    });
  });
}
