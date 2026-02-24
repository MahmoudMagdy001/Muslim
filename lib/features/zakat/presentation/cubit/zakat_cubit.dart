import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_gold_price_use_case.dart';
import 'zakat_state.dart';

class ZakatCubit extends Cubit<ZakatState> {
  ZakatCubit({required this.getGoldPriceUseCase}) : super(const ZakatState());

  final GetGoldPriceUseCase getGoldPriceUseCase;

  Future<void> loadGoldPrice() async {
    emit(state.copyWith(status: ZakatRequestStatus.loading));

    final result = await getGoldPriceUseCase(NoParams());

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
