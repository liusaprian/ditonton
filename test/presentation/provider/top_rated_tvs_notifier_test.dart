import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:ditonton/presentation/provider/top_rated_tvs_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTVs])
void main() {
  late MockGetTopRatedTVs mockGetTopRatedTVs;
  late TopRatedTVsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTVs = MockGetTopRatedTVs();
    notifier = TopRatedTVsNotifier(getTopRatedTVs: mockGetTopRatedTVs)
      ..addListener(() {
        listenerCallCount++;
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

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedTVs.execute())
        .thenAnswer((_) async => Right(tTVList));
    // act
    notifier.fetchTopRatedTVs();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tvs data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedTVs.execute())
        .thenAnswer((_) async => Right(tTVList));
    // act
    await notifier.fetchTopRatedTVs();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvs, tTVList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTVs.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTVs();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
