import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/tv.dart';

part 'top_rated_tvs_event.dart';
part 'top_rated_tvs_state.dart';

class TopRatedTVsBloc extends Bloc<TopRatedTVsEvent, TopRatedTVsState> {
  final GetTopRatedTVs _topRatedTVs;

  TopRatedTVsBloc(this._topRatedTVs) : super(TREmpty()) {
    on<TopRatedTVsEvent>((event, emit) async {
      emit(TRLoading());
      final result = await _topRatedTVs.execute();

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
