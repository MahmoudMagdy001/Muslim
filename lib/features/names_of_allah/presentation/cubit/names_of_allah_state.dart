import 'package:equatable/equatable.dart';

import '../../domain/entities/name_of_allah_entity.dart';

abstract class NamesOfAllahState extends Equatable {
  const NamesOfAllahState();

  @override
  List<Object?> get props => [];
}

class NamesOfAllahInitial extends NamesOfAllahState {}

class NamesOfAllahLoading extends NamesOfAllahState {}

class NamesOfAllahLoaded extends NamesOfAllahState {
  const NamesOfAllahLoaded(this.names);

  final List<NameOfAllahEntity> names;

  @override
  List<Object?> get props => [names];
}

class NamesOfAllahError extends NamesOfAllahState {
  const NamesOfAllahError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
