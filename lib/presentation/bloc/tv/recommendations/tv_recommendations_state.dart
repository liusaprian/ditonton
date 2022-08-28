part of 'tv_recommendations_bloc.dart';

abstract class TVRecommendationsState extends Equatable {
  const TVRecommendationsState();

  @override
  List<Object> get props => [];
}

class MREmpty extends TVRecommendationsState {}

class MRLoading extends TVRecommendationsState {}

class MRError extends TVRecommendationsState {
  final String message;

  MRError(this.message);

  @override
  List<Object> get props => [message];
}

class MRHasData extends TVRecommendationsState {
  final List<TV> result;

  MRHasData(this.result);

  @override
  List<Object> get props => [result];
}