import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:muslim/core/error/failures.dart';
import 'package:muslim/features/zakat/domain/repositories/zakat_repository.dart';
import 'package:muslim/features/zakat/presentation/bloc/zakat_bloc.dart';

class FakeZakatRepositorySuccess implements ZakatRepository {
  @override
  Future<Either<Failure, double>> getGoldPricePerGramInEgp() async => const Right(3500.0);
}

class FakeZakatRepositoryFailure implements ZakatRepository {
  @override
  Future<Either<Failure, double>> getGoldPricePerGramInEgp() async => const Left(ServerFailure('Network error'));
}

void main() {
  group('ZakatBloc Tests', () {
    test('initial state has default status initial', () {
      final bloc = ZakatBloc(repository: FakeZakatRepositorySuccess());
      expect(bloc.state.status, ZakatRequestStatus.initial);
      expect(bloc.state.goldPricePerGram, 0.0);
    });

    test('loadGoldPrice emits loading then success on repository success', () async {
      final bloc = ZakatBloc(repository: FakeZakatRepositorySuccess());

      unawaited(
        expectLater(
          bloc.stream,
          emitsInOrder([
            const ZakatState(status: ZakatRequestStatus.loading),
            const ZakatState(status: ZakatRequestStatus.success, goldPricePerGram: 3500.0),
          ]),
        ),
      );

      await bloc.loadGoldPrice();
    });

    test('loadGoldPrice emits loading then error on repository failure', () async {
      final bloc = ZakatBloc(repository: FakeZakatRepositoryFailure());

      unawaited(
        expectLater(
          bloc.stream,
          emitsInOrder([
            const ZakatState(status: ZakatRequestStatus.loading),
            const ZakatState(status: ZakatRequestStatus.error, errorMessage: 'Network error'),
          ]),
        ),
      );

      await bloc.loadGoldPrice();
    });

    test('setManualGoldPrice emits success with custom gold price', () async {
      final bloc = ZakatBloc(repository: FakeZakatRepositorySuccess());

      unawaited(
        expectLater(
          bloc.stream,
          emits(const ZakatState(status: ZakatRequestStatus.success, goldPricePerGram: 4000.0)),
        ),
      );

      bloc.setManualGoldPrice(4000.0);
    });
  });
}
