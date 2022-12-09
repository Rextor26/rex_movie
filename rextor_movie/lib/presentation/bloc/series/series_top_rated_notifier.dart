import 'package:rextor/common/state_enum.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/usecases/series/get_series_top_rated.dart';
import 'package:flutter/material.dart';

class TopRatedSeriesNotifier extends ChangeNotifier {
  final GetTopRatedSeries getTopRatedSeries;

  TopRatedSeriesNotifier({required this.getTopRatedSeries});

  RequestState _SeriesTopRatedState = RequestState.Empty;
  RequestState get state => _SeriesTopRatedState;

  List<Series> _SeriesTopRated = [];
  List<Series> get seriesTopRated => _SeriesTopRated;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedMovies() async {
    _SeriesTopRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _SeriesTopRatedState = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _SeriesTopRated = moviesData;
        _SeriesTopRatedState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
