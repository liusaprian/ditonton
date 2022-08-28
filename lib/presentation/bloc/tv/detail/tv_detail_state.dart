part of 'tv_detail_bloc.dart';

abstract class TVDetailState extends Equatable {
  const TVDetailState();

  @override
  List<Object> get props => [];
}

class MDEmpty extends TVDetailState {}

class MDLoading extends TVDetailState {}

class MDError extends TVDetailState {
  final String message;

  MDError(this.message);

  @override
  List<Object> get props => [message];
}

class MDHasData extends TVDetailState {
  final TVDetail result;

  MDHasData(this.result);

  @override
  List<Object> get props => [result];
}