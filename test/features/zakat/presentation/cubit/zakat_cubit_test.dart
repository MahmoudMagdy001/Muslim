import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muslim/core/error/failures.dart';
import 'package:muslim/features/zakat/domain/repositories/zakat_repository.dart';
import 'package:muslim/features/zakat/presentation/cubit/zakat_cubit.dart';
import 'package:muslim/features/zakat/presentation/cubit/zakat_state.dart';

class FakeZakatRepositorySuccess implements ZakatRepository {
  @override
  Future<Either<Failure, double>> getGoldPricePerGramInEgp() async => const Right(3500.0);
}

class FakeZakatRepositoryFailure implements ZakatRepository {
  @override
  Future<Either<Failure, double>> getGoldPricePerGramInEgp() async => const Left(ServerFailure('Network error'));
}

void main() {
  group('ZakatCubit Tests', () {
    test('initial state has default status initial', () {
      final cubit = ZakatCubit(repository: FakeZakatRepositorySuccess());
      expect(cubit.state.status, ZakatRequestStatus.initial);
      expect(cubit.state.goldPricePerGram, 0.0);
    });

    test('loadGoldPrice emits loading then success on repository success', () async {
      final cubit = ZakatCubit(repository: FakeZakatRepositorySuccess());

      unawaited(
        expectLater(
          cubit.stream,
          emitsInOrder([
            const ZakatState(status: ZakatRequestStatus.loading),
            const ZakatState(status: ZakatRequestStatus.success, goldPricePerGram: 3500.0),
          ]),
        ),
      );

      await cubit.loadGoldPrice();
    });

    test('loadGoldPrice emits loading then error on repository failure', () async {
      final cubit = ZakatCubit(repository: FakeZakatRepositoryFailure());

      unawaited(
        expectLater(
          cubit.stream,
          emitsInOrder([
            const ZakatState(status: ZakatRequestStatus.loading),
            const ZakatState(status: ZakatRequestStatus.error, errorMessage: 'Network error'),
          ]),
        ),
      );

      await cubit.loadGoldPrice();
    });

    test('setManualGoldPrice emits success with custom gold price', () {
      final cubit = ZakatCubit(repository: FakeZakatRepositorySuccess())..setManualGoldPrice(4000.0);

      expect(cubit.state.status, ZakatRequestStatus.success);
      expect(cubit.state.goldPricePerGram, 4000.0);
    });
  });
}
