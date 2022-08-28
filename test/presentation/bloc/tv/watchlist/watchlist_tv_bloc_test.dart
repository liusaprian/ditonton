import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatus, SaveTVWatchlist, RemoveTVWatchlist])
void main() {
  late WatchlistTVBloc watchlistTVBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveTVWatchlist mockSaveWatchlist;
  late MockRemoveTVWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveTVWatchlist();
    mockRemoveWatchlist = MockRemoveTVWatchlist();
    watchlistTVBloc = WatchlistTVBloc(mockGetWatchListStatus, mockSaveWatchlist, mockRemoveWatchlist);
  });

  test('initial state should be empty', () {
    expect(watchlistTVBloc.state, WMEmpty());
  });

  final tId = 1;

  const watchlistAddSuccessMessage = 'Added to Watchlist';
  const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

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

  blocTest<WatchlistTVBloc, WatchlistTVState>(
    'Should emit [Loading, Status] when fetching status successfully',
    build: () {
      when(mockGetWatchListStatus.execute(tId))
          .thenAnswer((_) async => true);
      return watchlistTVBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistStatus(tId)),
    expect: () => [
      WMLoading(),
      WMStatus(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
  );

  blocTest<WatchlistTVBloc, WatchlistTVState>(
    'Should emit [Loading, Error] when fetching status is unsuccessful',
    build: () {
      when(mockGetWatchListStatus.execute(tId))
          .thenAnswer((_) async => false);
      return watchlistTVBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistStatus(tId)),
    expect: () => [
      WMLoading(),
      WMStatus(false),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
  );

  blocTest<WatchlistTVBloc, WatchlistTVState>(
    'Should emit [Loading, Status] when adding to watchlist successfully',
    build: () {
      when(mockSaveWatchlist.execute(tTVDetailModel))
          .thenAnswer((_) async => Right(watchlistAddSuccessMessage));
      return watchlistTVBloc;
    },
    act: (bloc) => bloc.add(AddToWatchlist(tTVDetailModel)),
    expect: () => [
      WMLoading(),
      WMStatus(true),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(tTVDetailModel));
    },
  );

  blocTest<WatchlistTVBloc, WatchlistTVState>(
    'Should emit [Loading, Error] when adding to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlist.execute(tTVDetailModel))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTVBloc;
    },
    act: (bloc) => bloc.add(AddToWatchlist(tTVDetailModel)),
    expect: () => [
      WMLoading(),
      WMError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(tTVDetailModel));
    },
  );

  blocTest<WatchlistTVBloc, WatchlistTVState>(
    'Should emit [Loading, Status] when removing from watchlist successfully',
    build: () {
      when(mockRemoveWatchlist.execute(tTVDetailModel))
          .thenAnswer((_) async => Right(watchlistRemoveSuccessMessage));
      return watchlistTVBloc;
    },
    act: (bloc) => bloc.add(DeleteFromWatchlist(tTVDetailModel)),
    expect: () => [
      WMLoading(),
      WMStatus(false),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(tTVDetailModel));
    },
  );

  blocTest<WatchlistTVBloc, WatchlistTVState>(
    'Should emit [Loading, Error] when removing from watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute(tTVDetailModel))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTVBloc;
    },
    act: (bloc) => bloc.add(DeleteFromWatchlist(tTVDetailModel)),
    expect: () => [
      WMLoading(),
      WMError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(tTVDetailModel));
    },
  );
}