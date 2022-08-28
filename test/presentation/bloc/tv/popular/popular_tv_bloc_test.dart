import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/popular/popular_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTVs])
void main() {
  late PopularTVsBloc popularTVsBloc;
  late MockGetPopularTVs mockGetPopularTVs;

  setUp(() {
    mockGetPopularTVs = MockGetPopularTVs();
    popularTVsBloc = PopularTVsBloc(mockGetPopularTVs);
  });

  test('initial state should be empty', () {
    expect(popularTVsBloc.state, PEmpty());
  });

  final tTVModel = TV(
      backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
      genreIds: [14, 28],
      id: 557,
      overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
      popularity: 60.441,
      posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
      voteAverage: 7.2,
      voteCount: 13507,
      type: "Movie",
      name: "spiderman",
      originCountry: [],
      originalLanguage: '',
      firstAirDate: '',
      originalName: ''
  );
  final tTVList = <TV>[tTVModel];

  blocTest<PopularTVsBloc, PopularTVsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      return popularTVsBloc;
    },
    act: (bloc) => bloc.add(PopularTVsEvent()),
    expect: () => [
      PLoading(),
      PHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTVs.execute());
    },
  );

  blocTest<PopularTVsBloc, PopularTVsState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetPopularTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTVsBloc;
    },
    act: (bloc) => bloc.add(PopularTVsEvent()),
    expect: () => [
      PLoading(),
      PError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTVs.execute());
    },
  );
}