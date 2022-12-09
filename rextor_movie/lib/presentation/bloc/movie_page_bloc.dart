import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rextor/domain/usecases/movie/get_movie_now_playing.dart';
import 'package:rextor/domain/usecases/movie/get_movie_popular.dart';
import 'package:rextor/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:rextor/domain/usecases/movie/get_movie_top_rated.dart';
import 'package:rextor/domain/usecases/movie/get_movie_watchlist.dart';
import 'package:rextor/presentation/bloc/movie_page_event.dart';
import 'package:rextor/presentation/bloc/movie_page_state_management.dart';


class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieBloc(this._getNowPlayingMovies) : super(EmptyData()) {
    on<FetchMoviesData>((event, emit) async {
      emit(LoadingData());
      final result = await _getNowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (data) {
          emit(LoadedData(data));
        },
      );
    });
  }
}

class PopularMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies _getPopularMovies;
  PopularMovieBloc(this._getPopularMovies) : super(EmptyData()) {
    on<FetchMoviesData>((event, emit) async {
      emit(LoadingData());
      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (data) {
          emit(LoadedData(data));
        },
      );
    });
  }
}

class TopRatedMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies _getTopRatedMovies;
  TopRatedMovieBloc(this._getTopRatedMovies) : super(EmptyData()) {
    on<FetchMoviesData>((event, emit) async {
      emit(LoadingData());
      final result = await _getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (data) {
          emit(LoadedData(data));
        },
      );
    });
  }
}

class WatchlistMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  WatchlistMovieBloc(this._getWatchlistMovies) : super(EmptyData()) {
    on<FetchMoviesData>((event, emit) async {
      emit(LoadingData());
      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (data) {
          emit(LoadedData(data));
        },
      );
    });
  }
}

class RecommendationMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieRecommendations _getMovieRecommendations;

  RecommendationMoviesBloc(
    this._getMovieRecommendations,
  ) : super(EmptyData()) {
    on<FetchMovieDataWithId>((event, emit) async {
      final id = event.id;
      emit(LoadingData());
      final result = await _getMovieRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (data) {
          emit(LoadedData(data));
        },
      );
    });
  }
}
