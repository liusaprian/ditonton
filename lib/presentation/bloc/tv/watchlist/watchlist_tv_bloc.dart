import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTVBloc extends Bloc<WatchlistTVEvent, WatchlistTVState> {
  final GetWatchListStatus _watchlistStatus;
  final SaveTVWatchlist _saveTVWatchlist;
  final RemoveTVWatchlist _removeTVWatchlist;

  WatchlistTVBloc(
      this._watchlistStatus, this._saveTVWatchlist, this._removeTVWatchlist)
      : super(WMEmpty()) {
    on((event, emit) async {
      if (event is FetchWatchlistStatus) {
        final id = event.id;

        emit(WMLoading());
        final result = await _watchlistStatus.execute(id);
        emit(WMStatus(result));
      } else if (event is AddToWatchlist) {
        final movie = event.movie;

        emit(WMLoading());
        final result = await _saveTVWatchlist.execute(movie);

        result.fold(
          (failure) {
            emit(WMError(failure.message));
          },
          (data) {
            emit(WMStatus(true));
          },
        );
      } else if (event is DeleteFromWatchlist) {
        final movie = event.movie;

        emit(WMLoading());
        final result = await _removeTVWatchlist.execute(movie);

        result.fold(
          (failure) {
            emit(WMError(failure.message));
          },
          (data) {
            emit(WMStatus(false));
          },
        );
      }
    });
  }
}
