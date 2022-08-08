import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTVs usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchTVs(mockMovieRepository);
  });

  final tTVs = <TV>[];
  final tQuery = 'Spiderman';

  test('should get list of tvs from the repository', () async {
    // arrange
    when(mockMovieRepository.searchTVs(tQuery))
        .thenAnswer((_) async => Right(tTVs));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTVs));
  });
}
