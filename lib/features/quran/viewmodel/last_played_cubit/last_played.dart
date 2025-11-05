// last_played_cubit.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/quran_service.dart';

class LastPlayedCubit extends Cubit<Map<String, dynamic>?> {
  LastPlayedCubit(this._quranService) : super(null);

  final QuranService _quranService;
  StreamSubscription? _lastPlayedSubscription;

  Future<void> initialize() async {
    // تحميل آخر استماع عند البدء
    final lastPlayed = await _quranService.getLastPlayed();
    emit(lastPlayed);

    // الاستماع للتحديثات من الـ Stream
    _lastPlayedSubscription = _quranService.lastPlayedStream.listen((
      lastPlayed,
    ) {
      emit(lastPlayed);
    });
  }

  @override
  Future<void> close() {
    _lastPlayedSubscription?.cancel();
    return super.close();
  }
}
