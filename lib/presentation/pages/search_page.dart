import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  final String type;
  SearchPage({required this.type});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
              onSubmitted: (query) {
                if(widget.type == 'movie') {
                  Provider.of<MovieSearchNotifier>(context, listen: false)
                      .fetchMovieSearch(query);
                } else {
                  Provider.of<MovieSearchNotifier>(context, listen: false)
                      .fetchTVSearch(query);
                }
              },
              decoration: InputDecoration(
                hintText: 'Search title',
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
            Consumer<MovieSearchNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.Loading || data.tvState == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.state == RequestState.Loaded || data.tvState == RequestState.Loaded) {
                  int length = 0;
                  if(widget.type == 'movie') length = data.searchResult.length;
                  else length = data.tvSearchResult.length;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        Movie movie;
                        if(widget.type == 'movie') {
                          movie = data.searchResult[index];
                        } else {
                          final tv = data.tvSearchResult[index];
                          movie = Movie(
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
                        }
                        movie.type = widget.type;
                        return MovieCard(movie);
                      },
                      itemCount: length,
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
