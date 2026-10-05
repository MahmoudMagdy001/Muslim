import 'package:muslim/core/bloc/safe_bloc.dart';
import 'package:muslim/features/zakat/domain/repositories/zakat_repository.dart';
import 'package:muslim/features/zakat/presentation/bloc/zakat_event.dart';
import 'package:muslim/features/zakat/presentation/bloc/zakat_state.dart';

export 'zakat_event.dart';
export 'zakat_state.dart';

class ZakatBloc extends SafeBloc<ZakatEvent, ZakatState> {
  ZakatBloc({required this.repository}) : super(const ZakatState()) {
    on<ZakatLoadGoldPrice>(_onLoadGoldPrice);
    on<ZakatSetManualGoldPrice>(_onSetManualGoldPrice);
  }

  final ZakatRepository repository;

  Future<void> _onLoadGoldPrice(
    ZakatLoadGoldPrice event,
    Emitter<ZakatState> emit,
  ) async {
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

  void _onSetManualGoldPrice(
    ZakatSetManualGoldPrice event,
    Emitter<ZakatState> emit,
  ) {
    emit(
      state.copyWith(
        status: ZakatRequestStatus.success,
        goldPricePerGram: event.price,
      ),
    );
  }

  // Convenience dispatch methods
  Future<void> loadGoldPrice() async {
    await safeDispatch(
      const ZakatEvent.loadGoldPrice(),
      until: (s) => s.status != ZakatRequestStatus.loading,
    );
  }

  void setManualGoldPrice(double price) {
    safeAdd(ZakatEvent.setManualGoldPrice(price));
  }
}
