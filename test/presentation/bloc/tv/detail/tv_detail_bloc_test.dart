import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/presentation/bloc/tv/detail/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTVDetail])
void main() {
  late TVDetailBloc tvDetail;
  late MockGetTVDetail mockGetTVDetail;

  setUp(() {
    mockGetTVDetail = MockGetTVDetail();
    tvDetail = TVDetailBloc(mockGetTVDetail);
  });

  test('initial state should be empty', () {
    expect(tvDetail.state, MDEmpty());
  });

  final tId = 1;

  final tTVDetailModel = TVDetail(
      adult: false,
      backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
      id: 557,
      overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
      posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
      voteAverage: 7.2,
      voteCount: 13507,
      genres: [],
      name: 'spiderman',
      numberOfEpisodes: 1,
      numberOfSeasons: 1
  );

  blocTest<TVDetailBloc, TVDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => Right(tTVDetailModel));
      return tvDetail;
    },
    act: (bloc) => bloc.add(FetchTVDetail(tId)),
    expect: () => [
      MDLoading(),
      MDHasData(tTVDetailModel),
    ],
    verify: (bloc) {
      verify(mockGetTVDetail.execute(tId));
    },
  );

  blocTest<TVDetailBloc, TVDetailState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvDetail;
    },
    act: (bloc) => bloc.add(FetchTVDetail(tId)),
    expect: () => [
      MDLoading(),
      MDError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTVDetail.execute(tId));
    },
  );
}