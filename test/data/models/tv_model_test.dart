import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTVModel = TVModel(
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
  );

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

  test('should be a subclass of TV entity', () async {
    final result = tTVModel.toEntity();
    expect(result, tTV);
  });
}
