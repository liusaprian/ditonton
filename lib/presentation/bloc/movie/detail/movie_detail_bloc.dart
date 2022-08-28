import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _movieDetail;

  MovieDetailBloc(this._movieDetail) : super(MDEmpty()) {
    on<FetchMovieDetail>((event, emit) async {
      final id = event.id;

      emit(MDLoading());
      final result = await _movieDetail.execute(id);

      result.fold(
            (failure) {
          emit(MDError(failure.message));
        },
            (data) {
          emit(MDHasData(data));
        },
      );
    });
  }
}