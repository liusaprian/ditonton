import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetTopRatedTVs {
  final MovieRepository repository;

  GetTopRatedTVs(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getTopRatedTVs();
  }
}
