import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_movie_event.dart';

part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchListStatus _watchlistStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMovieBloc(
      this._watchlistStatus, this._saveWatchlist, this._removeWatchlist, this._getWatchlistMovies)
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
        final result = await _saveWatchlist.execute(movie);

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
        final result = await _removeWatchlist.execute(movie);

        result.fold(
          (failure) {
            emit(WMError(failure.message));
          },
          (data) {
            emit(WMStatus(false));
          },
        );
      } else if (event is FetchWatchlistMovie) {
        emit(WMLoading());
        final result = await _getWatchlistMovies.execute();

        result.fold(
          (failure) {
            emit(WMError(failure.message));
          },
          (data) {
            emit(WMHasData(data));
          },
        );
      }
    });
  }
}
