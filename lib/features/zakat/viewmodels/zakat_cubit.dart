import 'package:flutter_bloc/flutter_bloc.dart';

import 'zakat_state.dart';

class ZakatCubit extends Cubit<ZakatState> {
  ZakatCubit() : super(const ZakatState());

  // API fetching removed by user request.
  // Future<void> fetchGoldPrice() async { ... }

  void setManualGoldPrice(double price) {
    emit(
      state.copyWith(
        status: ZakatRequestStatus.success,
        goldPricePerGram: price,
      ),
    );
  }
}
