import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_tvs_event.dart';

part 'popular_tvs_state.dart';

class PopularTVsBloc extends Bloc<PopularTVsEvent, PopularTVsState> {
  final GetPopularTVs _popularTVs;

  PopularTVsBloc(this._popularTVs) : super(PEmpty()) {
    on<PopularTVsEvent>((event, emit) async {
      emit(PLoading());
      final result = await _popularTVs.execute();

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
