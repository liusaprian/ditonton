part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WMEmpty extends WatchlistMovieState {}

class WMLoading extends WatchlistMovieState {}

class WMError extends WatchlistMovieState {
  final String message;

  WMError(this.message);

  @override
  List<Object> get props => [message];
}
class WMHasData extends WatchlistMovieState {
  final List<Movie> result;

  WMHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WMStatus extends WatchlistMovieState {
  final bool result;

  WMStatus(this.result);

  @override
  List<Object> get props => [result];
}