part of 'search_tv_bloc.dart';

abstract class SearchTVState extends Equatable {
  const SearchTVState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchTVState {}

class SearchLoading extends SearchTVState {}

class SearchError extends SearchTVState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends SearchTVState {
  final List<TV> result;

  SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}