import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/features/quran/data/services/quran_service.dart';
import 'package:muslim/features/quran/presentation/bloc/last_played/last_played_event.dart';
import 'package:muslim/features/quran/presentation/bloc/last_played/last_played_state.dart';

export 'last_played_event.dart';

class LastPlayedBloc extends Bloc<LastPlayedEvent, LastPlayedState> {
  LastPlayedBloc([QuranService? quranService])
    : _quranService = quranService ?? getIt<QuranService>(),
      super(const LastPlayedState()) {
    on<LastPlayedInitialize>(_onInitialize);
    on<LastPlayedDataReceived>(_onDataReceived);
  }

  final QuranService _quranService;
  StreamSubscription<Map<String, dynamic>?>? _lastPlayedSubscription;

  Future<void> _onInitialize(
    LastPlayedInitialize event,
    Emitter<LastPlayedState> emit,
  ) async {
    final lastPlayed = await _quranService.getLastPlayed();
    emit(LastPlayedState(lastPlayed: lastPlayed));

    await _lastPlayedSubscription?.cancel();
    _lastPlayedSubscription = _quranService.lastPlayedStream.listen((data) {
      add(LastPlayedEvent.dataReceived(data));
    });
  }

  void _onDataReceived(
    LastPlayedDataReceived event,
    Emitter<LastPlayedState> emit,
  ) {
    emit(LastPlayedState(lastPlayed: event.data));
  }

  // Convenience method
  Future<void> initialize() async => add(const LastPlayedEvent.initialize());

  @override
  Future<void> close() async {
    await _lastPlayedSubscription?.cancel();
    return super.close();
  }
}
