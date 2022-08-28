import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _popularMovies;

  PopularMoviesBloc(this._popularMovies) : super(PEmpty()) {
    on<PopularMoviesEvent>((event, emit) async {
      emit(PLoading());
      final result = await _popularMovies.execute();

      result.fold(
        (failure) {
          emit(PError(failure.message));
        },
        (data) {
          emit(PHasData(data));
        },
      );
    });
  }
}
