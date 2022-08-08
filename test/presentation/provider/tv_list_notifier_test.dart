import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvs.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTVs, GetPopularTVs, GetTopRatedTVs])
void main() {
  late TVListNotifier provider;
  late MockGetNowPlayingTVs mockGetNowPlayingTVs;
  late MockGetPopularTVs mockGetPopularTVs;
  late MockGetTopRatedTVs mockGetTopRatedTVs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTVs = MockGetNowPlayingTVs();
    mockGetPopularTVs = MockGetPopularTVs();
    mockGetTopRatedTVs = MockGetTopRatedTVs();
    provider = TVListNotifier(
      getNowPlayingTVs: mockGetNowPlayingTVs,
      getPopularTVs: mockGetPopularTVs,
      getTopRatedTVs: mockGetTopRatedTVs,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tTV = TV(
    backdropPath: 'backdropPath',
    firstAirDate: "2019-07-25",
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "originalName",
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    type: 'tv',
  );
  final tTVList = <TV>[tTV];

  group('now playing tvs', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchNowPlayingTVs();
      // assert
      verify(mockGetNowPlayingTVs.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchNowPlayingTVs();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchNowPlayingTVs();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingTVs, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingTVs();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tvs', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchPopularTVs();
      // assert
      expect(provider.popularTVState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change movies data when data is gotten successfully',
            () async {
          // arrange
          when(mockGetPopularTVs.execute())
              .thenAnswer((_) async => Right(tTVList));
          // act
          await provider.fetchPopularTVs();
          // assert
          expect(provider.popularTVState, RequestState.Loaded);
          expect(provider.popularTVs, tTVList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTVs();
      // assert
      expect(provider.popularTVState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tvs', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchTopRatedTVs();
      // assert
      expect(provider.topRatedTVsState, RequestState.Loading);
    });

    test('should change tvs data when data is gotten successfully',
            () async {
          // arrange
          when(mockGetTopRatedTVs.execute())
              .thenAnswer((_) async => Right(tTVList));
          // act
          await provider.fetchTopRatedTVs();
          // assert
          expect(provider.topRatedTVsState, RequestState.Loaded);
          expect(provider.topRatedTVs, tTVList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTVs();
      // assert
      expect(provider.topRatedTVsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
