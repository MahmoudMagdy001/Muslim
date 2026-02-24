import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_names_of_allah_use_case.dart';
import 'names_of_allah_state.dart';

class NamesOfAllahCubit extends Cubit<NamesOfAllahState> {
  NamesOfAllahCubit({required this.getNamesOfAllahUseCase})
    : super(NamesOfAllahInitial());

  final GetNamesOfAllahUseCase getNamesOfAllahUseCase;

  Future<void> getNamesOfAllah() async {
    emit(NamesOfAllahLoading());
    final result = await getNamesOfAllahUseCase(NoParams());
    result.fold(
      (failure) => emit(NamesOfAllahError(failure.message)),
      (names) => emit(NamesOfAllahLoaded(names)),
    );
  }
}
