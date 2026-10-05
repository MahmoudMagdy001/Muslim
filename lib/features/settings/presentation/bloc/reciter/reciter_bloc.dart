import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/core/bloc/safe_bloc.dart';
import 'package:muslim/features/settings/presentation/bloc/reciter/reciter_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'reciter_event.dart';

part 'reciter_bloc.freezed.dart';

// State class
@freezed
abstract class ReciterState with _$ReciterState {
  const factory ReciterState({required String selectedReciter}) = _ReciterState;
}

// Bloc class
class ReciterBloc extends SafeBloc<ReciterEvent, ReciterState> {
  ReciterBloc() : super(const ReciterState(selectedReciter: _defaultReciter)) {
    on<ReciterInitialize>(_onInitialize);
    on<ReciterSaveReciter>(_onSaveReciter);

    add(const ReciterEvent.initialize());
  }

  static const String _defaultReciter = 'ar.alafasy';
  static const String _reciterKey = 'selected_reciter';

  Future<void> _onInitialize(
    ReciterInitialize event,
    Emitter<ReciterState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedReciter = prefs.getString(_reciterKey);

      if (savedReciter != null) {
        emit(ReciterState(selectedReciter: savedReciter));
      } else {
        emit(const ReciterState(selectedReciter: _defaultReciter));
      }
    } on Object catch (error) {
      debugPrint('Error initializing reciter: $error');
      emit(const ReciterState(selectedReciter: _defaultReciter));
    }
  }

  Future<void> _onSaveReciter(
    ReciterSaveReciter event,
    Emitter<ReciterState> emit,
  ) async {
    if (event.reciterId == state.selectedReciter) return;

    final previousState = state;
    emit(ReciterState(selectedReciter: event.reciterId));

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_reciterKey, event.reciterId);
    } on Object catch (error) {
      debugPrint('Error saving reciter: $error');
      emit(previousState);
    }
  }

  // Convenience method
  Future<void> saveReciter(String reciterId) async =>
      safeAdd(ReciterEvent.saveReciter(reciterId));
}
