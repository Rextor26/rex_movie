
import 'package:rextor/common/state_enum.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/usecases/series/get_series_on_air.dart';
import 'package:flutter/cupertino.dart';

class SeriesOnTheAirNotifier extends ChangeNotifier{
  final GetOnTheAirSeries getSeriesOnTheAir;

  SeriesOnTheAirNotifier({required this.getSeriesOnTheAir});

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Series> _Series = [];
  List<Series> get series => _Series;

  Future<void> fetchSeriesOnTheAir()async{
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getSeriesOnTheAir.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (seriesData) {
      _Series = seriesData;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }

}