import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TVDetailBloc extends Bloc<TVDetailEvent, TVDetailState> {
  final GetTVDetail _tvDetail;

  TVDetailBloc(this._tvDetail) : super(MDEmpty()) {
    on<FetchTVDetail>((event, emit) async {
      final id = event.id;

      emit(MDLoading());
      final result = await _tvDetail.execute(id);

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
