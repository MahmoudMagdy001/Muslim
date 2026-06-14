import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/features/quran/service/quran_service.dart';
import 'package:muslim/features/quran/viewmodel/last_played_cubit/last_played_state.dart';

class LastPlayedCubit extends Cubit<LastPlayedState> {
  LastPlayedCubit([QuranService? quranService])
    : _quranService = quranService ?? getIt<QuranService>(),
      super(const LastPlayedState());

  final QuranService _quranService;
  StreamSubscription<Map<String, dynamic>?>? _lastPlayedSubscription;

  Future<void> initialize() async {
    // تحميل آخر استماع عند البدء
    final lastPlayed = await _quranService.getLastPlayed();
    if (!isClosed) emit(LastPlayedState(lastPlayed: lastPlayed));

    // الاستماع للتحديثات من الـ Stream
    _lastPlayedSubscription = _quranService.lastPlayedStream.listen((data) {
      if (!isClosed) emit(LastPlayedState(lastPlayed: data));
    });
  }

  @override
  Future<void> close() async {
    await _lastPlayedSubscription?.cancel();
    return super.close();
  }
}
