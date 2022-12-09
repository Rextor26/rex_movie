import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rextor/domain/usecases/movie/get_movie_remove_watchlist.dart';
import 'package:rextor/presentation/bloc/movie_detail_page_state_management.dart';

import '../../common/state_enum.dart';
import '../../domain/usecases/movie/get_movie_detail.dart';
import '../../domain/usecases/movie/get_movie_save_watchlist.dart';
import '../../domain/usecases/movie/get_movie_watchlist_status.dart';
import 'movie_detail_page_event.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemovedWatchlist removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailState.initial()) {
    on<FetchMovieDetailDataWithId>((event, emit) async {
      emit(state.copyWith(state: RequestState.Loading));
      final detailResult = await getMovieDetail.execute(event.id);

      detailResult.fold(
        (failure) async {
          emit(state.copyWith(state: RequestState.Error));
        },
        (movie) async {
          emit(state.copyWith(
            state: RequestState.Loaded,
            movieDetail: movie,
          ));
        },
      );
    });
    on<AddWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movieDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(LoadWatchlistStatus(event.movieDetail.id));
    });
    on<RemoveWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movieDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(LoadWatchlistStatus(event.movieDetail.id));
    });
    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}
