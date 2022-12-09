import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:rextor/common/failure.dart';
import 'package:rextor/domain/usecases/movie/get_movie_watchlist.dart';
import 'package:rextor/presentation/bloc/movie_page_bloc.dart';
import 'package:rextor/presentation/bloc/movie_page_event.dart';
import 'package:rextor/presentation/bloc/movie_page_state_management.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovie;
  late WatchlistMovieBloc watchlistBloc;

  setUp(() {
    mockGetWatchlistMovie = MockGetWatchlistMovies();
    watchlistBloc = WatchlistMovieBloc(mockGetWatchlistMovie);
  });

  test('initial state should be empty', () {
    expect(watchlistBloc.state, EmptyData());
  });

  blocTest<WatchlistMovieBloc, MovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovie.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const FetchMoviesData()),
    expect: () => [
      LoadingData(),
      LoadedData([testWatchlistMovie]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovie.execute());
    },
  );

  blocTest<WatchlistMovieBloc, MovieState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistMovie.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const FetchMoviesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovie.execute());
    },
  );

  blocTest<WatchlistMovieBloc, MovieState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistMovie.execute()).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const FetchMoviesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovie.execute());
    },
  );

  blocTest<WatchlistMovieBloc, MovieState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistMovie.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const FetchMoviesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovie.execute());
    },
  );
}
