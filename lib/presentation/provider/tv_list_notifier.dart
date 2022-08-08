import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvs.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:flutter/material.dart';

class TVListNotifier extends ChangeNotifier {
  var _nowPlayingTVs = <TV>[];
  List<TV> get nowPlayingTVs => _nowPlayingTVs;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTVs = <TV>[];
  List<TV> get popularTVs => _popularTVs;

  RequestState _popularTVState = RequestState.Empty;
  RequestState get popularTVState => _popularTVState;

  var _topRatedTVs = <TV>[];
  List<TV> get topRatedTVs => _topRatedTVs;

  RequestState _topRatedTVsState = RequestState.Empty;
  RequestState get topRatedTVsState => _topRatedTVsState;

  String _message = '';
  String get message => _message;

  TVListNotifier({
    required this.getNowPlayingTVs,
    required this.getPopularTVs,
    required this.getTopRatedTVs,
  });

  final GetNowPlayingTVs getNowPlayingTVs;
  final GetPopularTVs getPopularTVs;
  final GetTopRatedTVs getTopRatedTVs;

  Future<void> fetchNowPlayingTVs() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTVs.execute();
    result.fold(
          (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (moviesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingTVs = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTVs() async {
    _popularTVState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTVs.execute();
    result.fold(
          (failure) {
        _popularTVState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (moviesData) {
        _popularTVState = RequestState.Loaded;
        _popularTVs = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTVs() async {
    _topRatedTVsState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVs.execute();
    result.fold(
          (failure) {
        _topRatedTVsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (moviesData) {
        _topRatedTVsState = RequestState.Loaded;
        _topRatedTVs = moviesData;
        notifyListeners();
      },
    );
  }
}
