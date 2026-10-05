import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

/// Mixin providing lifecycle-safe methods for any [Bloc] instance.
///
/// Solves common crashes and unhandled exceptions when:
/// 1. Awaiting stream state transitions after the screen/bloc has been closed (`safeFirstWhere`).
/// 2. Adding events to a closed Bloc (`safeAdd`).
/// 3. Dispatching an event and awaiting its completion with a timeout (`safeDispatch`).
mixin SafeBlocMixin<Event, State> on Bloc<Event, State> {
  /// Safely adds an [event] only if the Bloc is not closed.
  ///
  /// Returns `true` if the event was successfully added, or `false` if the Bloc was already closed.
  bool safeAdd(Event event) {
    if (isClosed) return false;
    add(event);
    return true;
  }

  /// Safely waits for a state matching [test] without throwing a [StateError]
  /// if the Bloc closes while waiting or if it was already closed.
  ///
  /// - If the Bloc is already closed, returns [fallbackState] or the current [state] immediately.
  /// - If the current [state] already satisfies [test], returns immediately.
  /// - If the stream closes before matching [test], returns [fallbackState] or [state] via `orElse`.
  /// - If [timeout] expires, returns [fallbackState] or [state] without throwing a [TimeoutException].
  Future<State> safeFirstWhere(
    bool Function(State state) test, {
    Duration? timeout,
    State? fallbackState,
  }) async {
    final fallback = fallbackState ?? state;
    if (isClosed) return fallback;
    if (test(state)) return state;

    try {
      final future = stream.firstWhere(
        test,
        orElse: () => fallback,
      );

      if (timeout != null) {
        return await future.timeout(
          timeout,
          onTimeout: () => fallback,
        );
      }
      return await future;
    } on Object catch (_) {
      return fallback;
    }
  }

  /// Safely dispatches an [event] and optionally waits until a state matching [until] is emitted.
  ///
  /// Ideal for convenience methods like `load()` or `refresh()` called from `RefreshIndicator`
  /// or screen initialization without risking `StateError: Bad state: No element`.
  Future<State?> safeDispatch(
    Event event, {
    bool Function(State state)? until,
    Duration timeout = const Duration(seconds: 15),
  }) async {
    final added = safeAdd(event);
    if (!added) return null;
    if (until == null) return state;
    return safeFirstWhere(until, timeout: timeout);
  }
}

/// Base class extending [Bloc] with [SafeBlocMixin] for lifecycle safety.
abstract class SafeBloc<Event, State> extends Bloc<Event, State>
    with SafeBlocMixin<Event, State> {
  SafeBloc(super.initialState);
}

/// Mixin providing lifecycle-safe stream methods for [Cubit] instances.
mixin SafeCubitMixin<State> on Cubit<State> {
  /// Safely waits for a state matching [test] without throwing [StateError]
  /// if the Cubit closes while waiting or is already closed.
  Future<State> safeFirstWhere(
    bool Function(State state) test, {
    Duration? timeout,
    State? fallbackState,
  }) async {
    final fallback = fallbackState ?? state;
    if (isClosed) return fallback;
    if (test(state)) return state;

    try {
      final future = stream.firstWhere(
        test,
        orElse: () => fallback,
      );

      if (timeout != null) {
        return await future.timeout(
          timeout,
          onTimeout: () => fallback,
        );
      }
      return await future;
    } on Object catch (_) {
      return fallback;
    }
  }
}

/// Base class extending [Cubit] with [SafeCubitMixin] for lifecycle safety.
abstract class SafeCubit<State> extends Cubit<State>
    with SafeCubitMixin<State> {
  SafeCubit(super.initialState);
}
