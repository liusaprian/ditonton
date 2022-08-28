part of 'top_rated_tvs_bloc.dart';

abstract class TopRatedTVsState extends Equatable {
  const TopRatedTVsState();

  @override
  List<Object> get props => [];
}

class TREmpty extends TopRatedTVsState {}

class TRLoading extends TopRatedTVsState {}

class TRError extends TopRatedTVsState {
  final String message;

  TRError(this.message);

  @override
  List<Object> get props => [message];
}

class TRHasData extends TopRatedTVsState {
  final List<TV> result;

  TRHasData(this.result);

  @override
  List<Object> get props => [result];
}