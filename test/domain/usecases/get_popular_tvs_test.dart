import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTVs usecase;
  late MockMovieRepository mockMovieRpository;

  setUp(() {
    mockMovieRpository = MockMovieRepository();
    usecase = GetPopularTVs(mockMovieRpository);
  });

  final tTVs = <TV>[];

  group('GetPopularTVs Tests', () {
    group('execute', () {
      test(
          'should get list of tvs from the repository when execute function is called',
              () async {
            // arrange
            when(mockMovieRpository.getPopularTVs())
                .thenAnswer((_) async => Right(tTVs));
            // act
            final result = await usecase.execute();
            // assert
            expect(result, Right(tTVs));
          });
    });
  });
}
