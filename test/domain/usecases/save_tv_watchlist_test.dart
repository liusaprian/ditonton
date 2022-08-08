import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveTVWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SaveTVWatchlist(mockMovieRepository);
  });

  test('should save tv to the repository', () async {
    // arrange
    when(mockMovieRepository.saveTVWatchlist(testTVDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    verify(mockMovieRepository.saveTVWatchlist(testTVDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
