import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/features/names_of_allah/domain/repositories/names_of_allah_repository.dart';
import 'package:muslim/features/names_of_allah/presentation/cubit/names_of_allah_state.dart';

class NamesOfAllahCubit extends Cubit<NamesOfAllahState> {
  NamesOfAllahCubit({required this.repository})
    : super(NamesOfAllahInitial());

  final NamesOfAllahRepository repository;

  Future<void> getNamesOfAllah() async {
    emit(NamesOfAllahLoading());
    final result = await repository.getNamesOfAllah();
    result.fold(
      (failure) => emit(NamesOfAllahError(failure.message)),
      (names) => emit(NamesOfAllahLoaded(names)),
    );
  }
}
