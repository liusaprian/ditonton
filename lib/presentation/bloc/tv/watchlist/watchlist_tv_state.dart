part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTVState extends Equatable {
  const WatchlistTVState();

  @override
  List<Object> get props => [];
}

class WMEmpty extends WatchlistTVState {}

class WMLoading extends WatchlistTVState {}

class WMError extends WatchlistTVState {
  final String message;

  WMError(this.message);

  @override
  List<Object> get props => [message];
}
class WMHasData extends WatchlistTVState {
  final List<TV> result;

  WMHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WMStatus extends WatchlistTVState {
  final bool result;

  WMStatus(this.result);

  @override
  List<Object> get props => [result];
}