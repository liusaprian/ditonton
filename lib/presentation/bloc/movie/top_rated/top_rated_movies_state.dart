part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class TREmpty extends TopRatedMoviesState {}

class TRLoading extends TopRatedMoviesState {}

class TRError extends TopRatedMoviesState {
  final String message;

  TRError(this.message);

  @override
  List<Object> get props => [message];
}

class TRHasData extends TopRatedMoviesState {
  final List<Movie> result;

  TRHasData(this.result);

  @override
  List<Object> get props => [result];
}