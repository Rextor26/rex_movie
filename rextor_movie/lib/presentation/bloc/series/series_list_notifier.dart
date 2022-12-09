
import 'package:rextor/common/state_enum.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/usecases/series/get_series_today.dart';
import 'package:rextor/domain/usecases/series/get_series_on_air.dart';
import 'package:rextor/domain/usecases/series/get_series_popular.dart';
import 'package:rextor/domain/usecases/series/get_series_top_rated.dart';
import 'package:flutter/cupertino.dart';

class ListSeriesNotifier extends ChangeNotifier{

  final GetAiringTodaySeries getAiringTodaySeries;
  final GetOnTheAirSeries getOnTheAirSeries;
  final GetPopularSeries getPopularSeries;
  final GetTopRatedSeries getTopRatedSeries;

  ListSeriesNotifier({
    required this.getOnTheAirSeries,
    required this.getAiringTodaySeries,
    required this.getPopularSeries,
    required this.getTopRatedSeries,
  });

  String _message = '';
  String get message => _message;

  var _airingTodaySeries = <Series>[];
  List<Series> get airingTodaySeries => _airingTodaySeries;

  RequestState _airingTodayState = RequestState.Empty;
  RequestState get airingTodayState => _airingTodayState;

  var _onTheAirSeries = <Series>[];
  List<Series> get onTheAirSeries => _onTheAirSeries;

  RequestState _onTheAirSeriesState = RequestState.Empty;
  RequestState get onTheAirSeriesState => _onTheAirSeriesState;

  var _popularSeries = <Series>[];
  List<Series> get popularSeries => _popularSeries;

  RequestState _popularSeriesState = RequestState.Empty;
  RequestState get popularSeriesState => _popularSeriesState;

  var _topRatedSeries = <Series>[];
  List<Series> get topRatedSeries => _topRatedSeries;

  RequestState _topRatedSeriesState = RequestState.Empty;
  RequestState get topRatedSeriesState => _topRatedSeriesState;

  Future<void> fetchAiringToday() async{
    _airingTodayState = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodaySeries.execute();
    result.fold((failure) {
      _airingTodayState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (dataSeries) {
        _airingTodayState = RequestState.Loaded;
        _airingTodaySeries = dataSeries;
        notifyListeners();
    });
  }


  Future<void> fetchOnTheAir() async{
    _airingTodayState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirSeries.execute();
    result.fold((failure) {
      _onTheAirSeriesState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _onTheAirSeriesState = RequestState.Loaded;
      _onTheAirSeries = data;
      notifyListeners();
    });
  }

  Future<void> fetchPopularSeries() async{
    _popularSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularSeries.execute();
    result.fold(
            (failure) {
              _popularSeriesState = RequestState.Error;
              _message = failure.message;
              notifyListeners();
            }, (data) {
              _popularSeriesState = RequestState.Loaded;
              _popularSeries = data;
              notifyListeners();
    });
  }

  Future<void> fetchTopRatedSeries() async{
    _topRatedSeriesState = RequestState.Loading;
    notifyListeners();
    final result = await getTopRatedSeries.execute();
    result.fold(
            (failure) {
              _topRatedSeriesState = RequestState.Error;
              _message = failure.message;
              notifyListeners();
            }, (data) {
              _topRatedSeriesState = RequestState.Loaded;
              _topRatedSeries = data;
              notifyListeners();
            });
  }
}