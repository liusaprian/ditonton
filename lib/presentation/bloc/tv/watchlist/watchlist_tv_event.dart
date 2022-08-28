part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTVEvent extends Equatable {
  const WatchlistTVEvent();

  @override
  List<Object> get props => [];
}

class AddToWatchlist extends WatchlistTVEvent {
  final TVDetail movie;

  AddToWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class DeleteFromWatchlist extends WatchlistTVEvent {
  final TVDetail movie;

  DeleteFromWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class FetchWatchlistStatus extends WatchlistTVEvent {
  final int id;

  FetchWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}