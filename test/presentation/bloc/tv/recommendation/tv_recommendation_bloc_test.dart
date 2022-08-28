import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/presentation/bloc/tv/recommendations/tv_recommendations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'tv_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTVRecommendations])
void main() {
  late TVRecommendationsBloc tvRecommendations;
  late MockGetTVRecommendations mockGetTVRecommendations;

  setUp(() {
    mockGetTVRecommendations = MockGetTVRecommendations();
    tvRecommendations = TVRecommendationsBloc(mockGetTVRecommendations);
  });

  test('initial state should be empty', () {
    expect(tvRecommendations.state, MREmpty());
  });

  final tId = 1;

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

  blocTest<TVRecommendationsBloc, TVRecommendationsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTVList));
      return tvRecommendations;
    },
    act: (bloc) => bloc.add(FetchTVRecommendations(tId)),
    expect: () => [
      MRLoading(),
      MRHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetTVRecommendations.execute(tId));
    },
  );

  blocTest<TVRecommendationsBloc, TVRecommendationsState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvRecommendations;
    },
    act: (bloc) => bloc.add(FetchTVRecommendations(tId)),
    expect: () => [
      MRLoading(),
      MRError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTVRecommendations.execute(tId));
    },
  );
}