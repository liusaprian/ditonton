import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies _nowPlayingMovies;

  NowPlayingMoviesBloc(this._nowPlayingMovies) : super(NPEmpty()) {
    on<NowPlayingMoviesEvent>((event, emit) async {
      emit(NPLoading());
      final result = await _nowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(NPError(failure.message));
        },
        (data) {
          emit(NPHasData(data));
        },
      );
    });
  }
}
