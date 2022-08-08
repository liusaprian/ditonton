import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTVWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = RemoveTVWatchlist(mockMovieRepository);
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    when(mockMovieRepository.removeTVWatchlist(testTVDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    verify(mockMovieRepository.removeTVWatchlist(testTVDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
