import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated/top_rated_tvs_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTVsPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTVsPageState createState() => _TopRatedTVsPageState();
}

class _TopRatedTVsPageState extends State<TopRatedTVsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<TopRatedTVsBloc>(context).add(TopRatedTVsEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTVsBloc, TopRatedTVsState>(
          builder: (context, state) {
            if (state is TRLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TRHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
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
                itemCount: state.result.length,
              );
            } else if (state is TRError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
