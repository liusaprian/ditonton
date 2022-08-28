part of 'popular_tvs_bloc.dart';

abstract class PopularTVsState extends Equatable {
  const PopularTVsState();

  @override
  List<Object> get props => [];
}

class PEmpty extends PopularTVsState {}

class PLoading extends PopularTVsState {}

class PError extends PopularTVsState {
  final String message;

  PError(this.message);

  @override
  List<Object> get props => [message];
}

class PHasData extends PopularTVsState {
  final List<TV> result;

  PHasData(this.result);

  @override
  List<Object> get props => [result];
}