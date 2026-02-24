import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/azkar_audio_state.dart';
import '../../domain/entities/azkar_entity.dart';
import '../../domain/repositories/azkar_repository.dart';
import '../datasources/azkar_audio_data_source.dart';
import '../datasources/azkar_local_data_source.dart';
import '../datasources/azkar_remote_data_source.dart';
import '../models/azkar_model.dart';

class AzkarRepositoryImpl implements AzkarRepository {
  AzkarRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._audioDataSource,
  );
  final AzkarRemoteDataSource _remoteDataSource;
  final AzkarLocalDataSource _localDataSource;
  final AzkarAudioDataSource _audioDataSource;

  @override
  Future<Either<Failure, List<AzkarEntity>>> getAzkarList() async {
    try {
      final json = await _localDataSource.loadAzkarFromAssets();
      final List<dynamic> data = json['data'] as List<dynamic>;
      final result = data
          .map((e) => AzkarModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AzkarContentEntity>>> getAzkarContent(
    String url,
  ) async {
    try {
      final json = await _remoteDataSource.fetchAzkarContent(url);
      // The API returns a map where the key is the title and value is a list of items
      if (json.isNotEmpty) {
        final List<dynamic> data = json.values.first as List<dynamic>;
        final result = data
            .map((e) => AzkarContentModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(result);
      }
      return const Right([]);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveAzkarCount(
    String sourceUrl,
    int index,
    int count,
  ) async {
    try {
      await _localDataSource.saveCount(sourceUrl, index, count);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int?>> getAzkarCount(
    String sourceUrl,
    int index,
  ) async {
    try {
      final count = await _localDataSource.getCount(sourceUrl, index);
      return Right(count);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearAzkarCountIfNewDay() async {
    try {
      await _localDataSource.clearIfNewDay();
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> playAudio(String url, {String? title}) async {
    try {
      await _audioDataSource.play(url, title: title);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> stopAudio() async {
    try {
      await _audioDataSource.stop();
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<AzkarAudioState> getAudioStateStream() => _audioDataSource.stateStream;

  @override
  AzkarAudioState get currentAudioState => _audioDataSource.currentState;
}
