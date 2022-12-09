import 'package:rextor/common/state_enum.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/usecases/series/get_series_today.dart';
import 'package:flutter/cupertino.dart';

class SeriesAiringTodayNotifier extends ChangeNotifier {
  final GetAiringTodaySeries getSeries;
  SeriesAiringTodayNotifier({required this.getSeries});

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Series> _airingToday = [];
  List<Series> get airingToday => _airingToday;

  Future<void> fetchAiringToday() async {
    final result = await getSeries.execute();
    result.fold(
            (failure) {
              _state = RequestState.Error;
              _message = failure.message;
              notifyListeners();
            },
            (dataSeries) {
              _state = RequestState.Loaded;
              _airingToday = dataSeries;
              notifyListeners();
            });
  }
}
