import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class RemoveTVWatchlist {
  final MovieRepository repository;

  RemoveTVWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TVDetail tv) {
    return repository.removeTVWatchlist(tv);
  }
}
