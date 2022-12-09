import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:rextor/common/failure.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/presentation/bloc/series/series_search_bloc.dart';
import 'package:rextor/presentation/bloc/series/series_search_event.dart';
import 'package:rextor/presentation/bloc/series/series_search_state_management.dart';
import 'package:rextor/presentation/pages/series/series_search_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'series_search_bloc_mocks.dart';

@GenerateMocks([SearchSeriesPage])
void main() {
  late SearchSeriesBloc searchBloc;
  late MockSearchSeries mockSearchSeries;


  setUp(() {
    mockSearchSeries = MockSearchSeries();
    searchBloc = SearchSeriesBloc(mockSearchSeries);

  });
  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmptySeries());
  });

  final seriesModel = Series(
    backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
    genreIds: [18],
    id: 11250,
    name: "Pasión de gavilanes",
    originCountry: ["CO"],
    originalLanguage: "es",
    originalName: "Pasión de gavilanes",
    overview: "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
    popularity: 3645.173,
    posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
    voteAverage: 7.6,
    voteCount: 1765
  );
  final seriesList = <Series>[seriesModel];
  const tQuery = 'spiderman';

 blocTest<SearchSeriesBloc, SearchStateSeries>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Right(seriesList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedSeries(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoadingSeries(),
      SearchHasDataSeries(seriesList),
    ],
    verify: (bloc) {
      verify(mockSearchSeries.execute(tQuery));
    },
  );

  blocTest<SearchSeriesBloc, SearchStateSeries>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedSeries(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoadingSeries(),
      const SearchErrorSeries('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchSeries.execute(tQuery));
    },
  );
}
