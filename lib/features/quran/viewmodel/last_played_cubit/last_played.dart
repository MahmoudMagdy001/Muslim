import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../service/quran_service.dart';
import 'last_played_state.dart';

class LastPlayedCubit extends Cubit<LastPlayedState> {
  LastPlayedCubit([QuranService? quranService])
    : _quranService = quranService ?? getIt<QuranService>(),
      super(const LastPlayedState());

  final QuranService _quranService;
  StreamSubscription? _lastPlayedSubscription;

  Future<void> initialize() async {
    // تحميل آخر استماع عند البدء
    final lastPlayed = await _quranService.getLastPlayed();
    emit(LastPlayedState(lastPlayed: lastPlayed));

    // الاستماع للتحديثات من الـ Stream
    _lastPlayedSubscription = _quranService.lastPlayedStream.listen((data) {
      emit(LastPlayedState(lastPlayed: data));
    });
  }

  @override
  Future<void> close() {
    _lastPlayedSubscription?.cancel();
    return super.close();
  }
}
