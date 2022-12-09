import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rextor/common/state_enum.dart';
import 'package:rextor/domain/entities/series/series_detail.dart';
import 'package:rextor/domain/usecases/series/get_series_detail.dart';
import 'package:rextor/domain/usecases/series/get_series_remove_series_watchlist.dart';
import 'package:rextor/domain/usecases/series/get_series_save_watchlist.dart';
import 'package:rextor/domain/usecases/series/get_series_watchlist_status.dart';
import 'package:rextor/presentation/bloc/series/series_detail_event.dart';
import 'package:rextor/presentation/bloc/series/series_detail_state_management.dart';



class SeriesDetailBloc
    extends Bloc<SeriesDetailEvent, SeriesDetailState> {
  final GetSeriesDetail getTvseriesDetail;
  final GetWatchlistStatusSeries getWatchListStatus;
  final SaveWatchlistSeries saveWatchlist;
  final RemoveWatchlistSeries removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  SeriesDetailBloc({
    required this.getTvseriesDetail,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(SeriesDetailState.initial()) {
    on<FetchSeriesDetailById>((event, emit) async {
      emit(state.copyWith(state: RequestState.Loading));
      final detailResult = await getTvseriesDetail.execute(event.id);

      detailResult.fold(
        (failure) async {
          emit(state.copyWith(state: RequestState.Error));
        },
        (tvseries) async {
          emit(state.copyWith(
            tvseriesDetail: tvseries,
            state: RequestState.Loaded,
          ));
        },
      );
    });
    on<AddWatchlistSeries>((event, emit) async {
      final result = await saveWatchlist.execute(event.seriesDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(LoadWatchlistStatus(event.seriesDetail.id));
    });
    on<RemoveSeriesWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.seriesDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(LoadWatchlistStatus(event.seriesDetail.id));
    });
    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}
