import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetPopularTVs {
  final MovieRepository repository;

  GetPopularTVs(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getPopularTVs();
  }
}
