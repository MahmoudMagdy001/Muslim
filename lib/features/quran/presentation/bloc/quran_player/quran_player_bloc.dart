import 'dart:async';

import 'package:muslim/core/bloc/safe_bloc.dart';

import 'package:muslim/features/quran/data/services/quran_service.dart';
import 'package:muslim/features/quran/presentation/bloc/quran_player/quran_player_event.dart';
import 'package:muslim/features/quran/presentation/bloc/quran_player/quran_player_state.dart';

export 'quran_player_event.dart';

class QuranPlayerBloc extends SafeBloc<QuranPlayerEvent, QuranPlayerState> {
  QuranPlayerBloc(this._quranService, {int? initialSurah})
    : super(
        QuranPlayerState(
          currentSurah: _quranService.currentSurah ?? initialSurah,
          currentAyah: _quranService.audioPlayer.currentIndex != null
              ? _quranService.audioPlayer.currentIndex! + 1
              : null,
          isPlaying: _quranService.isQuranPlaying,
          currentPosition: _quranService.audioPlayer.position,
          totalDuration: _quranService.audioPlayer.duration ?? Duration.zero,
        ),
      ) {
    on<QuranPlayerLoadSurah>(_onLoadSurah);
    on<QuranPlayerLoadRange>(_onLoadRange);
    on<QuranPlayerPlay>(_onPlay);
    on<QuranPlayerPause>(_onPause);
    on<QuranPlayerSeek>(_onSeek);
    on<QuranPlayerSeekToAyah>(_onSeekToAyah);
    on<QuranPlayerSeekToNext>(_onSeekToNext);
    on<QuranPlayerSeekToPrevious>(_onSeekToPrevious);
    on<QuranPlayerPositionChanged>(_onPositionChanged);
    on<QuranPlayerDurationChanged>(_onDurationChanged);
    on<QuranPlayerPlayerStateChanged>(_onPlayerStateChanged);
    on<QuranPlayerCurrentIndexChanged>(_onCurrentIndexChanged);

    _initializeListeners();
  }

  final QuranService _quranService;
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  bool _isRangeMode = false;

  void _initializeListeners() {
    _subscriptions.add(
      _quranService.audioPlayer.positionStream.listen(
        (position) {
          add(QuranPlayerEvent.positionChanged(position));
        },
        onError: (_) {},
      ),
    );

    _subscriptions.add(
      _quranService.audioPlayer.durationStream.listen(
        (duration) {
          if (duration != null && duration.inMilliseconds > 0) {
            add(QuranPlayerEvent.durationChanged(duration));
          }
        },
        onError: (_) {},
      ),
    );

    _subscriptions.add(
      _quranService.audioPlayer.playerStateStream.listen(
        (_) {
          add(QuranPlayerEvent.playerStateChanged(isPlaying: _quranService.isQuranPlaying));
        },
        onError: (_) {},
      ),
    );

    _subscriptions.add(
      _quranService.audioPlayer.currentIndexStream.listen(
        (index) {
          if (index != null) {
            add(QuranPlayerEvent.currentIndexChanged(index));
          }
        },
        onError: (_) {},
      ),
    );

    _subscriptions.add(
      _quranService.audioPlayer.playbackEventStream.listen(
        (_) {},
        onError: (_) {
          add(const QuranPlayerEvent.playerStateChanged(isPlaying: false));
        },
      ),
    );
  }

  void _onPositionChanged(
    QuranPlayerPositionChanged event,
    Emitter<QuranPlayerState> emit,
  ) {
    emit(state.copyWith(currentPosition: event.position));
  }

  void _onDurationChanged(
    QuranPlayerDurationChanged event,
    Emitter<QuranPlayerState> emit,
  ) {
    emit(state.copyWith(totalDuration: event.duration));
  }

  void _onPlayerStateChanged(
    QuranPlayerPlayerStateChanged event,
    Emitter<QuranPlayerState> emit,
  ) {
    emit(state.copyWith(isPlaying: event.isPlaying));
  }

  void _onCurrentIndexChanged(
    QuranPlayerCurrentIndexChanged event,
    Emitter<QuranPlayerState> emit,
  ) {
    if (_isRangeMode) {
      final entry = _quranService.getAyahAtIndex(event.index);
      if (entry != null) {
        emit(
          state.copyWith(
            currentSurah: entry.surah,
            currentAyah: entry.ayah,
          ),
        );
      }
    } else {
      final currentAyah = event.index + 1;
      emit(state.copyWith(currentAyah: currentAyah));
    }
  }

  Future<void> _onLoadSurah(
    QuranPlayerLoadSurah event,
    Emitter<QuranPlayerState> emit,
  ) async {
    _isRangeMode = false;
    try {
      await _quranService.prepareSurahPlaylist(
        surahNumber: event.surah,
        reciter: event.reciter,
      );

      final targetIndex = event.startAyah - 1;
      final isAlreadyAtTarget =
          _quranService.currentSurah == event.surah &&
          _quranService.audioPlayer.currentIndex == targetIndex;

      if (event.startAyah > 1 && !isAlreadyAtTarget) {
        await _quranService.seek(Duration.zero, index: targetIndex);
      }
    } on Object catch (_) {}
    emit(state.copyWith(currentSurah: event.surah, currentAyah: event.startAyah));
  }

  Future<void> _onLoadRange(
    QuranPlayerLoadRange event,
    Emitter<QuranPlayerState> emit,
  ) async {
    _isRangeMode = true;
    try {
      await _quranService.prepareRangePlaylist(
        fromPage: event.fromPage,
        toPage: event.toPage,
        reciter: event.reciter,
      );

      var targetIndex = 0;
      for (var i = 0; ; i++) {
        final entry = _quranService.getAyahAtIndex(i);
        if (entry == null) break;
        if (entry.surah == event.startSurah && entry.ayah == event.startAyah) {
          targetIndex = i;
          break;
        }
      }

      if (targetIndex > 0) {
        await _quranService.seek(Duration.zero, index: targetIndex);
      }
    } on Object catch (_) {}

    emit(state.copyWith(currentSurah: event.startSurah, currentAyah: event.startAyah));
  }

  Future<void> _onPlay(
    QuranPlayerPlay event,
    Emitter<QuranPlayerState> emit,
  ) async {
    try {
      await _quranService.play();
    } on Object catch (_) {
      emit(state.copyWith(isPlaying: false));
    }
  }

  Future<void> _onPause(
    QuranPlayerPause event,
    Emitter<QuranPlayerState> emit,
  ) async {
    try {
      await _quranService.pause();
    } on Object catch (_) {
      emit(state.copyWith(isPlaying: false));
    }
  }

  Future<void> _onSeek(
    QuranPlayerSeek event,
    Emitter<QuranPlayerState> emit,
  ) async {
    try {
      await _quranService.seek(event.position, index: event.index);
      if (event.surah != null) emit(state.copyWith(currentSurah: event.surah));
    } on Object catch (_) {}
  }

  Future<void> _onSeekToAyah(
    QuranPlayerSeekToAyah event,
    Emitter<QuranPlayerState> emit,
  ) async {
    try {
      if (_isRangeMode) {
        for (var i = 0; ; i++) {
          final entry = _quranService.getAyahAtIndex(i);
          if (entry == null) break;
          if (entry.surah == event.surah && entry.ayah == event.ayah) {
            await _quranService.seek(Duration.zero, index: i);
            emit(state.copyWith(currentSurah: event.surah, currentAyah: event.ayah));
            return;
          }
        }
      } else {
        await _quranService.seek(Duration.zero, index: event.ayah - 1);
        emit(state.copyWith(currentSurah: event.surah, currentAyah: event.ayah));
      }
    } on Object catch (_) {}
  }

  Future<void> _onSeekToNext(
    QuranPlayerSeekToNext event,
    Emitter<QuranPlayerState> emit,
  ) async {
    try {
      await _quranService.seekToNext();
    } on Object catch (_) {}
  }

  Future<void> _onSeekToPrevious(
    QuranPlayerSeekToPrevious event,
    Emitter<QuranPlayerState> emit,
  ) async {
    try {
      await _quranService.seekToPrevious();
    } on Object catch (_) {}
  }

  // Convenience methods
  Future<void> loadSurah(int surah, String reciter, {int startAyah = 1}) async =>
      safeAdd(QuranPlayerEvent.loadSurah(surah: surah, reciter: reciter, startAyah: startAyah));

  Future<void> loadRange({
    required int fromPage,
    required int toPage,
    required String reciter,
    required int startSurah,
    required int startAyah,
  }) async =>
      safeAdd(
        QuranPlayerEvent.loadRange(
          fromPage: fromPage,
          toPage: toPage,
          reciter: reciter,
          startSurah: startSurah,
          startAyah: startAyah,
        ),
      );

  Future<void> play() async => safeAdd(const QuranPlayerEvent.play());
  Future<void> pause() async => safeAdd(const QuranPlayerEvent.pause());
  Future<void> seek(Duration position, {int? index, int? surah}) async =>
      safeAdd(QuranPlayerEvent.seek(position: position, index: index, surah: surah));
  Future<void> seekToAyah(int surah, int ayah) async =>
      safeAdd(QuranPlayerEvent.seekToAyah(surah: surah, ayah: ayah));
  Future<void> seekToNext() async => safeAdd(const QuranPlayerEvent.seekToNext());
  Future<void> seekToPrevious() async => safeAdd(const QuranPlayerEvent.seekToPrevious());

  @override
  Future<void> close() async {
    for (final sub in _subscriptions) {
      await sub.cancel();
    }
    return super.close();
  }
}
