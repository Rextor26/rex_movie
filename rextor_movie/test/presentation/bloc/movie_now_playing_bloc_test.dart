import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rextor/common/failure.dart';
import 'package:rextor/domain/usecases/movie/get_movie_now_playing.dart';
import 'package:rextor/presentation/bloc/movie_page_bloc.dart';
import 'package:rextor/presentation/bloc/movie_page_event.dart';
import 'package:rextor/presentation/bloc/movie_page_state_management.dart';
import '../../dummy_data/dummy_objects.dart';
import 'movie_now_playing_bloc_mock.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MovieBloc moviesBloc;
  setUp(
    () {
      mockGetNowPlayingMovies = MockGetNowPlayingMovies();
      moviesBloc = MovieBloc(mockGetNowPlayingMovies);
    },
  );

  test('initial state should be empty', () {
    expect(moviesBloc.state, EmptyData());
  });

  blocTest<MovieBloc, MovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return moviesBloc;
    },
    act: (bloc) => bloc.add(const FetchMoviesData()),
    expect: () => [
      LoadingData(),
      LoadedData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MovieBloc, MovieState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return moviesBloc;
    },
    act: (bloc) => bloc.add(const FetchMoviesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MovieBloc, MovieState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return moviesBloc;
    },
    act: (bloc) => bloc.add(const FetchMoviesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MovieBloc, MovieState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return moviesBloc;
    },
    act: (bloc) => bloc.add(const FetchMoviesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}
