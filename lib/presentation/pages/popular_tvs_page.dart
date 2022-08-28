import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/tv/popular/popular_tvs_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        BlocProvider.of<PopularTVsBloc>(context).add(PopularTVsEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTVsBloc, PopularTVsState>(
          builder: (context, state) {
            if (state is PLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PHasData) {
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
            } else if (state is PError) {
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
