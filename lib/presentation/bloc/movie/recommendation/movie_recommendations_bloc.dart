import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_recommendations_event.dart';
part 'movie_recommendations_state.dart';

class MovieRecommendationsBloc
    extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
  final GetMovieRecommendations _movieRecommendations;

  MovieRecommendationsBloc(this._movieRecommendations) : super(MREmpty()) {
    on<FetchMovieRecommendations>((event, emit) async {
      final id = event.id;

      emit(MRLoading());
      final result = await _movieRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(MRError(failure.message));
        },
        (data) {
          emit(MRHasData(data));
        },
      );
    });
  }
}
