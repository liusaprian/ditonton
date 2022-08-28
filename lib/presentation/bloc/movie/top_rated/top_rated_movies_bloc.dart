import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/movie.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies _topRatedMovies;

  TopRatedMoviesBloc(this._topRatedMovies) : super(TREmpty()) {
    on<TopRatedMoviesEvent>((event, emit) async {
      emit(TRLoading());
      final result = await _topRatedMovies.execute();

      result.fold(
        (failure) {
          emit(TRError(failure.message));
        },
        (data) {
          emit(TRHasData(data));
        },
      );
    });
  }
}
