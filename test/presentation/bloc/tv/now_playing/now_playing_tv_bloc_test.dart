import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/now_playing/now_playing_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'now_playing_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTVs])
void main() {
  late NowPlayingTVsBloc nowPlayingTVsBloc;
  late MockGetNowPlayingTVs mockGetNowPlayingTVs;

  setUp(() {
    mockGetNowPlayingTVs = MockGetNowPlayingTVs();
    nowPlayingTVsBloc = NowPlayingTVsBloc(mockGetNowPlayingTVs);
  });

  test('initial state should be empty', () {
    expect(nowPlayingTVsBloc.state, NPEmpty());
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

  blocTest<NowPlayingTVsBloc, NowPlayingTVsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      return nowPlayingTVsBloc;
    },
    act: (bloc) => bloc.add(NowPlayingTVsEvent()),
    expect: () => [
      NPLoading(),
      NPHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTVs.execute());
    },
  );

  blocTest<NowPlayingTVsBloc, NowPlayingTVsState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetNowPlayingTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingTVsBloc;
    },
    act: (bloc) => bloc.add(NowPlayingTVsEvent()),
    expect: () => [
      NPLoading(),
      NPError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTVs.execute());
    },
  );
}