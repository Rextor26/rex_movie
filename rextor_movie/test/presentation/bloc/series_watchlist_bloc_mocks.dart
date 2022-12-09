// Mocks generated by Mockito 5.0.8 from annotations
// in rextor/test/presentation/provider/watchlist_movie_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:rextor/common/failure.dart' as _i5;
import 'package:rextor/domain/entities/series/series.dart' as _i6;
import 'package:rextor/domain/usecases/series/get_series_watchlist.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [GetSeriesWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistSeries extends _i1.Mock
    implements _i3.GetWatchlistSeries{
  MockGetWatchlistSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Series>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Series>>>.value(
              _FakeEither<_i5.Failure, List<_i6.Series>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Series>>>);
}
