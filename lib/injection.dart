import 'package:ditonton/common/ssl_pinning.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvs.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:ditonton/presentation/bloc/movie/detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/recommendation/movie_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/search/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/now_playing/now_playing_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/popular/popular_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/recommendations/tv_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/search/search_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated/top_rated_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist/watchlist_tv_bloc.dart';
import 'package:get_it/get_it.dart';
import 'domain/usecases/get_popular_tvs.dart';
import 'domain/usecases/get_top_rated_tvs.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
        () => SearchMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => SearchTVBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => NowPlayingMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TopRatedMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => NowPlayingTVsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => PopularTVsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TopRatedTVsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => MovieDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => MovieRecommendationsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistMovieBloc(
      locator(),
      locator(),
      locator(),
      locator()
    ),
  );
  locator.registerFactory(
        () => TVDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TVRecommendationsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistTVBloc(
      locator(),
      locator(),
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTVs(locator()));
  locator.registerLazySingleton(() => GetPopularTVs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVs(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTVs(locator()));
  locator.registerLazySingleton(() => SaveTVWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTVWatchlist(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
          () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => SSLPinning.client);
}
