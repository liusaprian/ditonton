import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTVBloc extends Bloc<SearchTVEvent, SearchTVState> {
  final SearchTVs _searchTVs;

  SearchTVBloc(this._searchTVs) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchTVs.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}