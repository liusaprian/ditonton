part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class PEmpty extends PopularMoviesState {}

class PLoading extends PopularMoviesState {}

class PError extends PopularMoviesState {
  final String message;

  PError(this.message);

  @override
  List<Object> get props => [message];
}

class PHasData extends PopularMoviesState {
  final List<Movie> result;

  PHasData(this.result);

  @override
  List<Object> get props => [result];
}