import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:flutter/foundation.dart';

class PopularTVsNotifier extends ChangeNotifier {
  final GetPopularTVs getPopularTvs;

  PopularTVsNotifier(this.getPopularTvs);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TV> _tvs = [];
  List<TV> get tvs => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTVs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvs.execute();

    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (moviesData) {
        _tvs = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
