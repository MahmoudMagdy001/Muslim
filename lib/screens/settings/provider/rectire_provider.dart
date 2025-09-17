import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReciterProvider extends ChangeNotifier {
  ReciterProvider() {
    _initializeReciter();
  }
  static const String _defaultReciter = 'ar.alafasy';
  static const String _reciterKey = 'selected_reciter';

  String _selectedReciter = _defaultReciter;
  String get selectedReciter => _selectedReciter;

  Future<void> _initializeReciter() async {
    try {
      await _loadReciter();
    } catch (error) {
      debugPrint('Error initializing reciter: $error');
      // Fall back to default value but still notify listeners
      _selectedReciter = _defaultReciter;
      notifyListeners();
    }
  }

  Future<void> _loadReciter() async {
    final prefs = await SharedPreferences.getInstance();
    final savedReciter = prefs.getString(_reciterKey);

    if (savedReciter != null) {
      _selectedReciter = savedReciter;
    } else {
      _selectedReciter = _defaultReciter;
    }
    notifyListeners();
  }

  Future<void> saveReciter(String reciter) async {
    if (reciter == _selectedReciter) return;

    final previousReciter = _selectedReciter;
    _selectedReciter = reciter;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_reciterKey, reciter);
    } catch (error) {
      debugPrint('Error saving reciter: $error');
      // Revert the change if saving fails
      _selectedReciter = previousReciter;
      notifyListeners();
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
