import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:flutter/foundation.dart';

class MovieSearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;
  final SearchTVs searchTVs;

  MovieSearchNotifier({required this.searchMovies, required this.searchTVs});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _searchResult = [];
  List<Movie> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  RequestState _tvState = RequestState.Empty;
  RequestState get tvState => _tvState;

  List<TV> _tvSearchResult = [];
  List<TV> get tvSearchResult => _tvSearchResult;

  String _tvMessage = '';
  String get tvMessage => _tvMessage;

  Future<void> fetchMovieSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTVSearch(String query) async {
    _tvState = RequestState.Loading;
    notifyListeners();

    final result = await searchTVs.execute(query);
    result.fold(
      (failure) {
        _tvMessage = failure.message;
        _tvState = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _tvSearchResult = data;
        _tvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
