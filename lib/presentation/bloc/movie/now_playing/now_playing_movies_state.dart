part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class NPEmpty extends NowPlayingMoviesState {}

class NPLoading extends NowPlayingMoviesState {}

class NPError extends NowPlayingMoviesState {
  final String message;

  NPError(this.message);

  @override
  List<Object> get props => [message];
}

class NPHasData extends NowPlayingMoviesState {
  final List<Movie> result;

  NPHasData(this.result);

  @override
  List<Object> get props => [result];
}