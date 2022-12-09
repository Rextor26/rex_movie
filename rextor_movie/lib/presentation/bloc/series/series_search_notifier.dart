
import 'package:rextor/common/state_enum.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/usecases/series/get_series_search.dart';
import 'package:flutter/cupertino.dart';

class SearchSeriesNotifier extends ChangeNotifier{
  final SearchSeries searchSeries;
  SearchSeriesNotifier({required this.searchSeries});

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Series> _searchResultSeries = [];
  List<Series> get searchResultSeries => _searchResultSeries;

  Future<void> fetchSearchSeries(String query) async{
    _state = RequestState.Loading;
    notifyListeners();
    final result = await searchSeries.execute(query);
    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (data){
      _searchResultSeries = data;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }

}