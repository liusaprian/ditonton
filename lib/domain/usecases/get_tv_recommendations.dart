import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetTVRecommendations {
  final MovieRepository repository;

  GetTVRecommendations(this.repository);

  Future<Either<Failure, List<TV>>> execute(id) {
    return repository.getTVRecommendations(id);
  }
}
