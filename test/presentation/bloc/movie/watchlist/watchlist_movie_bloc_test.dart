import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies, GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late WatchlistMovieBloc watchlistMoviesBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistMoviesBloc = WatchlistMovieBloc(mockGetWatchListStatus, mockSaveWatchlist, mockRemoveWatchlist, mockGetWatchlistMovies);
  });

  test('initial state should be empty', () {
    expect(watchlistMoviesBloc.state, WMEmpty());
  });

  final tId = 1;

  const watchlistAddSuccessMessage = 'Added to Watchlist';
  const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final tMovieModel = Movie(
      adult: false,
      backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
      genreIds: [14, 28],
      id: 557,
      originalTitle: 'Spider-Man',
      overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
      popularity: 60.441,
      posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
      releaseDate: '2002-05-01',
      title: 'Spider-Man',
      video: false,
      voteAverage: 7.2,
      voteCount: 13507,
      type: "Movie"
  );

  final tMovieDetailModel = MovieDetail(
      adult: false,
      backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
      id: 557,
      originalTitle: 'Spider-Man',
      overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
      posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
      releaseDate: '2002-05-01',
      title: 'Spider-Man',
      voteAverage: 7.2,
      voteCount: 13507,
      genres: [],
      runtime: 0
  );

  final tMovieList = <Movie>[tMovieModel];

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Status] when fetching status successfully',
    build: () {
      when(mockGetWatchListStatus.execute(tId))
          .thenAnswer((_) async => true);
      return watchlistMoviesBloc;
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

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Error] when fetching status is unsuccessful',
    build: () {
      when(mockGetWatchListStatus.execute(tId))
          .thenAnswer((_) async => false);
      return watchlistMoviesBloc;
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

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Status] when adding to watchlist successfully',
    build: () {
      when(mockSaveWatchlist.execute(tMovieDetailModel))
          .thenAnswer((_) async => Right(watchlistAddSuccessMessage));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(AddToWatchlist(tMovieDetailModel)),
    expect: () => [
      WMLoading(),
      WMStatus(true),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(tMovieDetailModel));
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Error] when adding to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlist.execute(tMovieDetailModel))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(AddToWatchlist(tMovieDetailModel)),
    expect: () => [
      WMLoading(),
      WMError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(tMovieDetailModel));
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Status] when removing from watchlist successfully',
    build: () {
      when(mockRemoveWatchlist.execute(tMovieDetailModel))
          .thenAnswer((_) async => Right(watchlistRemoveSuccessMessage));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(DeleteFromWatchlist(tMovieDetailModel)),
    expect: () => [
      WMLoading(),
      WMStatus(false),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(tMovieDetailModel));
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Error] when removing from watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute(tMovieDetailModel))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(DeleteFromWatchlist(tMovieDetailModel)),
    expect: () => [
      WMLoading(),
      WMError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(tMovieDetailModel));
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    expect: () => [
      WMLoading(),
      WMHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    expect: () => [
      WMLoading(),
      WMError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}