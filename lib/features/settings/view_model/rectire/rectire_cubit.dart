import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// State class
class ReciterState extends Equatable {
  const ReciterState({required this.selectedReciter});
  final String selectedReciter;

  @override
  List<Object?> get props => [selectedReciter];
}

// Cubit class
class ReciterCubit extends Cubit<ReciterState> {
  ReciterCubit() : super(const ReciterState(selectedReciter: _defaultReciter)) {
    _initializeReciter();
  }
  static const String _defaultReciter = 'ar.alafasy';
  static const String _reciterKey = 'selected_reciter';

  Future<void> _initializeReciter() async {
    try {
      await _loadReciter();
    } catch (error) {
      debugPrint('Error initializing reciter: $error');
      // Fall back to default value
      emit(const ReciterState(selectedReciter: _defaultReciter));
    }
  }

  Future<void> _loadReciter() async {
    final prefs = await SharedPreferences.getInstance();
    final savedReciter = prefs.getString(_reciterKey);

    if (savedReciter != null) {
      if (!isClosed) emit(ReciterState(selectedReciter: savedReciter));
    } else {
      if (!isClosed) emit(const ReciterState(selectedReciter: _defaultReciter));
    }
  }

  Future<void> saveReciter(String reciterId) async {
    if (reciterId == state.selectedReciter) return;

    final previousState = state;
    emit(ReciterState(selectedReciter: reciterId));

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_reciterKey, reciterId);
    } catch (error) {
      debugPrint('Error saving reciter: $error');
      // Revert the change if saving fails
      if (!isClosed) emit(previousState);
    }
  }

  // تحديث القارئ من أي مكان في التطبيق
  Future<void> refreshReciter() async {
    try {
      await _loadReciter();
    } catch (error) {
      debugPrint('Error refreshing reciter: $error');
    }
  }
}
