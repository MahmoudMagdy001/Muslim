import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// State class
class ReciterState {
  ReciterState({required this.selectedReciter});
  final String selectedReciter;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReciterState &&
          runtimeType == other.runtimeType &&
          selectedReciter == other.selectedReciter;

  @override
  int get hashCode => selectedReciter.hashCode;
}

// Cubit class
class ReciterCubit extends Cubit<ReciterState> {
  ReciterCubit() : super(ReciterState(selectedReciter: _defaultReciter)) {
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
      emit(ReciterState(selectedReciter: _defaultReciter));
    }
  }

  Future<void> _loadReciter() async {
    final prefs = await SharedPreferences.getInstance();
    final savedReciter = prefs.getString(_reciterKey);

    if (savedReciter != null) {
      emit(ReciterState(selectedReciter: savedReciter));
    } else {
      emit(ReciterState(selectedReciter: _defaultReciter));
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
      emit(previousState);
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
