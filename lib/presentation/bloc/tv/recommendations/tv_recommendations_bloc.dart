import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_recommendations_event.dart';
part 'tv_recommendations_state.dart';

class TVRecommendationsBloc
    extends Bloc<TVRecommendationsEvent, TVRecommendationsState> {
  final GetTVRecommendations _tvRecommendations;

  TVRecommendationsBloc(this._tvRecommendations) : super(MREmpty()) {
    on<FetchTVRecommendations>((event, emit) async {
      final id = event.id;

      emit(MRLoading());
      final result = await _tvRecommendations.execute(id);

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
