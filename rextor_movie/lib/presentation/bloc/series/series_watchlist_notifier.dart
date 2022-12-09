
import 'package:rextor/common/state_enum.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/usecases/series/get_series_watchlist.dart';
import 'package:flutter/cupertino.dart';

class SeriesWatchlistNotifier extends ChangeNotifier{
  var _watchlistSeries = <Series>[];
  List<Series> get watchlistSeries => _watchlistSeries;

  var _watchlistStateSeries = RequestState.Empty;
  RequestState get watchlistStateSeries => _watchlistStateSeries;

  String _message = '';
  String get message => _message;

  SeriesWatchlistNotifier({required this.getWatchlistSeries});
  final GetWatchlistSeries getWatchlistSeries;

  Future<void> fetchWatchlistSeries()async{
    _watchlistStateSeries = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistSeries.execute();
    result.fold((failure) {
      _watchlistStateSeries = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _watchlistStateSeries = RequestState.Loaded;
      _watchlistSeries = data;
      notifyListeners();
    });
  }
}