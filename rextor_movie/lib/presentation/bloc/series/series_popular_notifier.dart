import 'package:rextor/common/state_enum.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/usecases/series/get_series_popular.dart';
import 'package:flutter/cupertino.dart';

class SeriesPopularNotifier extends ChangeNotifier{
  final GetPopularSeries getSeriesPopular;
  SeriesPopularNotifier(this.getSeriesPopular);

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Series> _popularSeries =[];
  List<Series> get popularSeries => _popularSeries;

  Future<void> fetchPopularSeries() async{
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getSeriesPopular.execute();
    result.fold((failure) {
      _state = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (message) {
      _state = RequestState.Loaded;
      _popularSeries = message;
      notifyListeners();
    });
  }


}