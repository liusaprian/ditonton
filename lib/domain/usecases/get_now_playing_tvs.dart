import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetNowPlayingTVs {
  final MovieRepository repository;

  GetNowPlayingTVs(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getNowPlayingTVs();
  }
}
