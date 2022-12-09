import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:rextor/common/failure.dart';
import 'package:rextor/domain/usecases/series/get_series_top_rated.dart';
import 'package:rextor/presentation/bloc/series/series_even.dart';
import 'package:rextor/presentation/bloc/series/series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rextor/presentation/bloc/series/series_state_management.dart';

import '../../dummy_data/dummy_objects.dart';
import 'series_list_bloc.mocks.dart';

@GenerateMocks([GetTopRatedSeries])
void main() {
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late TopratedSeriesBloc topRatedBloc;

  setUp(() {
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    topRatedBloc = TopratedSeriesBloc(mockGetTopRatedSeries);
  });

  test('initial state should be empty', () {
    expect(topRatedBloc.state, EmptyDataSeries());
  });


    blocTest<TopratedSeriesBloc, SeriesStateManagement>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingDataSeries(),
      LoadedDataSeries(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedSeries.execute());
    },
  );

  blocTest<TopratedSeriesBloc, SeriesStateManagement>(
    'Should emit [Loading, Error] when get popular is unsuccessful',
    build: () {
      when(mockGetTopRatedSeries.execute()).thenAnswer(
          (_) async => Left(DatabaseFailure('Database Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingDataSeries(),
      const ErrorDataSeries('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedSeries.execute());
    },
  );
}
