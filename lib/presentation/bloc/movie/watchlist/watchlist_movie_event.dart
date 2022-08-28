part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistMovie extends WatchlistMovieEvent {}

class AddToWatchlist extends WatchlistMovieEvent {
  final MovieDetail movie;

  AddToWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class DeleteFromWatchlist extends WatchlistMovieEvent {
  final MovieDetail movie;

  DeleteFromWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class FetchWatchlistStatus extends WatchlistMovieEvent {
  final int id;

  FetchWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}