import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/features/names_of_allah/domain/repositories/names_of_allah_repository.dart';
import 'package:muslim/features/names_of_allah/presentation/bloc/names_of_allah_event.dart';
import 'package:muslim/features/names_of_allah/presentation/bloc/names_of_allah_state.dart';

export 'names_of_allah_event.dart';
export 'names_of_allah_state.dart';

class NamesOfAllahBloc extends Bloc<NamesOfAllahEvent, NamesOfAllahState> {
  NamesOfAllahBloc({required this.repository})
    : super(const NamesOfAllahInitial()) {
    on<NamesOfAllahGetNamesOfAllah>(_onGetNamesOfAllah);
  }

  final NamesOfAllahRepository repository;

  Future<void> _onGetNamesOfAllah(
    NamesOfAllahGetNamesOfAllah event,
    Emitter<NamesOfAllahState> emit,
  ) async {
    emit(const NamesOfAllahLoading());
    final result = await repository.getNamesOfAllah();
    result.fold(
      (failure) => emit(NamesOfAllahError(failure.message)),
      (names) => emit(NamesOfAllahLoaded(names)),
    );
  }

  // Convenience dispatch method
  Future<void> getNamesOfAllah() async {
    add(const NamesOfAllahEvent.getNamesOfAllah());
  }
}
