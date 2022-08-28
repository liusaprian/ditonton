import 'package:ditonton/domain/usecases/get_now_playing_tvs.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_tvs_event.dart';

part 'now_playing_tvs_state.dart';

class NowPlayingTVsBloc extends Bloc<NowPlayingTVsEvent, NowPlayingTVsState> {
  final GetNowPlayingTVs _nowPlayingTVs;

  NowPlayingTVsBloc(this._nowPlayingTVs) : super(NPEmpty()) {
    on<NowPlayingTVsEvent>((event, emit) async {
      emit(NPLoading());
      final result = await _nowPlayingTVs.execute();

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
