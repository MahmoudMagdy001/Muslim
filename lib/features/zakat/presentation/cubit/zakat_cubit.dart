import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/features/zakat/domain/repositories/zakat_repository.dart';
import 'package:muslim/features/zakat/presentation/cubit/zakat_state.dart';

class ZakatCubit extends Cubit<ZakatState> {
  ZakatCubit({required this.repository}) : super(const ZakatState());

  final ZakatRepository repository;

  Future<void> loadGoldPrice() async {
    emit(state.copyWith(status: ZakatRequestStatus.loading));

    final result = await repository.getGoldPricePerGramInEgp();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ZakatRequestStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (price) => emit(
        state.copyWith(
          status: ZakatRequestStatus.success,
          goldPricePerGram: price,
        ),
      ),
    );
  }

  void setManualGoldPrice(double price) {
    emit(
      state.copyWith(
        status: ZakatRequestStatus.success,
        goldPricePerGram: price,
      ),
    );
  }
}
