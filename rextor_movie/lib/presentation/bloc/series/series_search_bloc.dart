import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rextor/domain/usecases/series/get_series_search.dart';
import 'package:rextor/presentation/bloc/series/series_search_event.dart';
import 'package:rextor/presentation/bloc/series/series_search_state_management.dart';
import 'package:rxdart/rxdart.dart';

class SearchSeriesBloc extends Bloc<SearchEventSeries, SearchStateSeries> {
  final SearchSeries _searchSeries;

  SearchSeriesBloc(this._searchSeries) : super(SearchEmptySeries()) {
    on<OnQueryChangedSeries>((event, emit) async {
      final query = event.query;

      emit(SearchLoadingSeries());
      final result = await _searchSeries.execute(query);

      result.fold(
        (failure) {
          emit(SearchErrorSeries(failure.message));
        },
        (data) {
          emit(SearchHasDataSeries(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
