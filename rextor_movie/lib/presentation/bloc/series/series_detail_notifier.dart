import 'package:rextor/common/state_enum.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/entities/series/series_detail.dart';
import 'package:rextor/domain/usecases/series/get_series_recommendation.dart';
import 'package:rextor/domain/usecases/series/get_series_detail.dart';
import 'package:rextor/domain/usecases/series/get_series_watchlist_status.dart';
import 'package:rextor/domain/usecases/series/get_series_remove_series_watchlist.dart';
import 'package:rextor/domain/usecases/series/get_series_save_watchlist.dart';
import 'package:flutter/cupertino.dart';

class DetailSeriesNotifier extends ChangeNotifier{
  static const  successAddWatchlist = 'Added to watchlist';
  static const  successRemovedWatchlist = 'Remove from watchlist';


  final GetSeriesRecommendations getSeriesRecommendations;
  final GetSeriesDetail getSeriesDetail;
  final SaveWatchlistSeries saveWatchlistSeries;
  final GetWatchlistStatusSeries getWatchlistStatusSeries;
  final RemoveWatchlistSeries removeWatchlistSeries;

  DetailSeriesNotifier({
    required this.getSeriesDetail,
    required this.getWatchlistStatusSeries,
    required this.removeWatchlistSeries,
    required this.saveWatchlistSeries,
    required this.getSeriesRecommendations,
  });

  String _message = '';
  String get message => _message;

  RequestState _SeriesDetailState = RequestState.Empty;
  RequestState get SeriesDetailState => _SeriesDetailState;

  late SeriesDetail _SeriesDetail;
  SeriesDetail get seriesDetail => _SeriesDetail;

  bool _isAddedToWatchListSeries = false;
  bool get isAddedToWatchListSeries => _isAddedToWatchListSeries;
  String _watchlistMessageSeries = '';
  String get watchlistMessageSeries => _watchlistMessageSeries;

  List<Series> _SeriesRecommendation = [];
  List<Series> get seriesRecommendation => _SeriesRecommendation;

  RequestState _SeriesRecommendationState = RequestState.Empty;
  RequestState get seriesRecommendationState => _SeriesRecommendationState;


  Future<void> fetchSeriesDetail(int id) async{
    _SeriesDetailState = RequestState.Loading;
    notifyListeners();

    final detailSeriesResult = await getSeriesDetail.execute(id);
    final seriesRecommendationResult = await getSeriesRecommendations.execute(id);

    detailSeriesResult.fold((failure) {
      _SeriesDetailState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _SeriesRecommendationState = RequestState.Loading;
      _SeriesDetail = data;
      notifyListeners();
      _SeriesDetailState = RequestState.Loaded;
      notifyListeners();
      seriesRecommendationResult.fold((failure) {
        _SeriesRecommendationState = RequestState.Error;
        _message = failure.message;
      }, (message) {
        _SeriesRecommendationState = RequestState.Loaded;
        _SeriesRecommendation = message;
      });
    });
  }

  Future<void> addWatchlist(SeriesDetail seriesDetail)async{
    final result = await saveWatchlistSeries.execute(seriesDetail);
    await result.fold((failure) {
      _watchlistMessageSeries = failure.message;
    }, (success) {
      _watchlistMessageSeries = success;
    });
    await loadWatchlistStatusSeries(seriesDetail.id);
  }

  Future<void> loadWatchlistStatusSeries(int id) async{
    final result = await getWatchlistStatusSeries.execute(id);
    _isAddedToWatchListSeries = result;
    notifyListeners();
  }

  Future<void> removeFromWatchlistSeries(SeriesDetail seriesDetail)async{
    final result = await removeWatchlistSeries.execute(seriesDetail);
    await result.fold((failure) {
      _watchlistMessageSeries = failure.message;
    }, (success) {
      _watchlistMessageSeries = success;
    });
    await loadWatchlistStatusSeries(seriesDetail.id);
  }
}