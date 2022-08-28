import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/tv/search/search_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/search-tv';

  @override
  State<SearchTVPage> createState() => _SearchTVPageState();
}

class _SearchTVPageState extends State<SearchTVPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchTVBloc>().add(OnQueryChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search tv title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTVBloc, SearchTVState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tv = result[index];
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
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
