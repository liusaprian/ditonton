import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetTVDetail {
  final MovieRepository repository;

  GetTVDetail(this.repository);

  Future<Either<Failure, TVDetail>> execute(int id) {
    return repository.getTVDetail(id);
  }
}
