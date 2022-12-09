import 'package:bloc_test/bloc_test.dart';
import 'package:rextor/common/failure.dart';
import 'package:rextor/common/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rextor/domain/usecases/movie/get_movie_detail.dart';
import 'package:rextor/domain/usecases/movie/get_movie_watchlist_status.dart';
import 'package:rextor/domain/usecases/movie/get_movie_remove_watchlist.dart';
import 'package:rextor/domain/usecases/movie/get_movie_save_watchlist.dart';
import 'package:rextor/presentation/bloc/movie_detail_page_bloc.dart';
import 'package:rextor/presentation/bloc/movie_detail_page_event.dart';
import 'package:rextor/presentation/bloc/movie_detail_page_state_management.dart';
import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetWatchListStatus,
  SaveWatchlist,
  RemovedWatchlist,
])
void main() {
  late MovieDetailBloc detailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    detailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  group('Get Movie Detail', () {
    test('initial state should be empty', () {
      expect(detailBloc.state.state, RequestState.Empty);
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async =>Right(testMovieDetail));
        return detailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetailDataWithId(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(state: RequestState.Loading),
        MovieDetailState.initial().copyWith(
          state: RequestState.Loaded,
          movieDetail: testMovieDetail,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Error] when get top rated is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return detailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetailDataWithId(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(state: RequestState.Loading),
        MovieDetailState.initial().copyWith(
          state: RequestState.Error,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });

  group('Watchlist Status', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Get Watchlist Status',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchlistStatus(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieDetail: testMovieDetail,
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should execute save watchlist when function called',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return detailBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Success'),
        MovieDetailState.initial().copyWith(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: true,
            watchlistMessage: 'Success'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return detailBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Removed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should update watchlist message when add watchlist failed',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return detailBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Server Failure'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );


  });
}
