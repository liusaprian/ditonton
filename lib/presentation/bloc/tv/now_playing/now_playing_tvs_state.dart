part of 'now_playing_tvs_bloc.dart';

abstract class NowPlayingTVsState extends Equatable {
  const NowPlayingTVsState();

  @override
  List<Object> get props => [];
}

class NPEmpty extends NowPlayingTVsState {}

class NPLoading extends NowPlayingTVsState {}

class NPError extends NowPlayingTVsState {
  final String message;

  NPError(this.message);

  @override
  List<Object> get props => [message];
}

class NPHasData extends NowPlayingTVsState {
  final List<TV> result;

  NPHasData(this.result);

  @override
  List<Object> get props => [result];
}