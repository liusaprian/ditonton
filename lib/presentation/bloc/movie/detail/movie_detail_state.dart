part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MDEmpty extends MovieDetailState {}

class MDLoading extends MovieDetailState {}

class MDError extends MovieDetailState {
  final String message;

  MDError(this.message);

  @override
  List<Object> get props => [message];
}

class MDHasData extends MovieDetailState {
  final MovieDetail result;

  MDHasData(this.result);

  @override
  List<Object> get props => [result];
}