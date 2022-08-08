import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/provider/popular_tvs_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularTVsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTVsPage createState() => _PopularTVsPage();
}

class _PopularTVsPage extends State<PopularTVsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTVsNotifier>(context, listen: false)
            .fetchPopularTVs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTVsNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tvs[index];
                  final movie = Movie(
                      type: 'tv',
                      title: tv.name,
                      posterPath: tv.posterPath,
                      overview: tv.overview,
                      id: tv.id,
                      adult: false,
                      backdropPath: tv.backdropPath,
                      genreIds: tv.genreIds,
                      originalTitle: tv.originalName,
                      popularity: tv.popularity,
                      releaseDate: tv.firstAirDate,
                      video: false,
                      voteAverage: tv.voteAverage,
                      voteCount: tv.voteCount
                  );
                  return MovieCard(movie);
                },
                itemCount: data.tvs.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
