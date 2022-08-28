part of 'movie_recommendations_bloc.dart';

abstract class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();

  @override
  List<Object> get props => [];
}

class MREmpty extends MovieRecommendationsState {}

class MRLoading extends MovieRecommendationsState {}

class MRError extends MovieRecommendationsState {
  final String message;

  MRError(this.message);

  @override
  List<Object> get props => [message];
}

class MRHasData extends MovieRecommendationsState {
  final List<Movie> result;

  MRHasData(this.result);

  @override
  List<Object> get props => [result];
}