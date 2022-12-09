import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rextor/presentation/bloc/search_page_event.dart';
import 'package:rextor/presentation/bloc/search_page_state_management.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/usecases/movie/get_movie_search.dart';


class SearchMovieBloc extends Bloc<SearchEvent, SearchStateMovie> {
  final SearchMovies _searchMovies;

  SearchMovieBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
