import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rextor/domain/usecases/series/get_series_on_air.dart';
import 'package:rextor/domain/usecases/series/get_series_popular.dart';
import 'package:rextor/domain/usecases/series/get_series_recommendation.dart';
import 'package:rextor/domain/usecases/series/get_series_today.dart';
import 'package:rextor/domain/usecases/series/get_series_top_rated.dart';
import 'package:rextor/domain/usecases/series/get_series_watchlist.dart';
import 'package:rextor/presentation/bloc/series/series_even.dart';
import 'package:rextor/presentation/bloc/series/series_state_management.dart';


class seriesPopularBloc extends Bloc<SeriesEvent, SeriesStateManagement> {
  final GetPopularSeries _getSeriesPopular;

  seriesPopularBloc(this._getSeriesPopular) : super(EmptyDataSeries()) {
    on<FetchTvseriesData>((event, emit) async {
      emit(LoadingDataSeries());
      final result = await _getSeriesPopular.execute();

      result.fold(
        (failure) {
          emit(ErrorDataSeries(failure.message));
        },
        (data) {
          emit(LoadedDataSeries(data));
        },
      );
    });
  }
}

class TopratedSeriesBloc extends Bloc<SeriesEvent, SeriesStateManagement> {
  final GetTopRatedSeries _getSeriesTopRated;
  TopratedSeriesBloc(this._getSeriesTopRated) : super(EmptyDataSeries()) {
    on<FetchTvseriesData>((event, emit) async {
      emit(LoadingDataSeries());
      final result = await _getSeriesTopRated.execute();

      result.fold(
        (failure) {
          emit(ErrorDataSeries(failure.message));
        },
        (data) {
          emit(LoadedDataSeries(data));
        },
      );
    });
  }
}

class SeriesTodayBloc extends Bloc<SeriesEvent, SeriesStateManagement> {
  final GetAiringTodaySeries _getSeriesToday;
  SeriesTodayBloc(this._getSeriesToday) : super(EmptyDataSeries()) {
    on<FetchTvseriesData>((event, emit) async {
      emit(LoadingDataSeries());
      final result = await _getSeriesToday.execute();

      result.fold(
        (failure) {
          emit(ErrorDataSeries(failure.message));
        },
        (data) {
          emit(LoadedDataSeries(data));
        },
      );
    });
  }
}

class SeriesOnAirBloc extends Bloc<SeriesEvent, SeriesStateManagement> {
  final GetOnTheAirSeries _getSeriesOnAir;
  SeriesOnAirBloc(this._getSeriesOnAir) : super(EmptyDataSeries()) {
    on<FetchTvseriesData>((event, emit) async {
      emit(LoadingDataSeries());
      final result = await _getSeriesOnAir.execute();

      result.fold(
        (failure) {
          emit(ErrorDataSeries(failure.message));
        },
        (data) {
          emit(LoadedDataSeries(data));
        },
      );
    });
  }
}

class WatchlistSeriesBloc extends Bloc<SeriesEvent, SeriesStateManagement> {
  final GetWatchlistSeries getWatchlistSeries;
  WatchlistSeriesBloc(this.getWatchlistSeries) : super(EmptyDataSeries()) {
    on<FetchTvseriesData>((event, emit) async {
      emit(LoadingDataSeries());
      final result = await getWatchlistSeries.execute();
      
      result.fold(
        (failure) {
          emit(ErrorDataSeries(failure.message));
        },
        (data) {
          emit(LoadedDataSeries(data));
        },
      );
    });
  }
}

class RecommendationTvseriesBloc extends Bloc<SeriesEvent, SeriesStateManagement> {
  final GetSeriesRecommendations _getTvseriesRecommendations;

  RecommendationTvseriesBloc(
    this._getTvseriesRecommendations,
  ) : super(EmptyDataSeries()) {
    on<FetchTvseriesDataWithId>((event, emit) async {
      final id = event.id;
      emit(LoadingDataSeries());
      final result = await _getTvseriesRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(ErrorDataSeries(failure.message));
        },
        (data) {
          emit(LoadedDataSeries(data));
        },
      );
    });
  }
}
