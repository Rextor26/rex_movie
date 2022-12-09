import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:rextor/common/failure.dart';
import 'package:rextor/common/state_enum.dart';
import 'package:rextor/domain/entities/movie/movie.dart';
import 'package:rextor/domain/usecases/movie/get_movie_top_rated.dart';
import 'package:rextor/presentation/bloc/movie_page_bloc.dart';
import 'package:rextor/presentation/bloc/movie_page_event.dart';
import 'package:rextor/presentation/bloc/movie_page_state_management.dart';
import 'package:rextor/presentation/bloc/movie_top_rated_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_top_rated_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovie;
  late TopRatedMovieBloc topRatedBloc;

  setUp(() {
    mockGetTopRatedMovie = MockGetTopRatedMovies();
    topRatedBloc = TopRatedMovieBloc(mockGetTopRatedMovie);
  });

  test('initial state should be empty', () {
    expect(topRatedBloc.state, EmptyData());
  });

  blocTest<TopRatedMovieBloc, MovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedMovie.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const FetchMoviesData()),
    expect: () => [
      LoadingData(),
      LoadedData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovie.execute());
    },
  );

  blocTest<TopRatedMovieBloc, MovieState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedMovie.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const FetchMoviesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovie.execute());
    },
  );

  blocTest<TopRatedMovieBloc, MovieState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedMovie.execute()).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const FetchMoviesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovie.execute());
    },
  );

  blocTest<TopRatedMovieBloc, MovieState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedMovie.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const FetchMoviesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovie.execute());
    },
  );
}
