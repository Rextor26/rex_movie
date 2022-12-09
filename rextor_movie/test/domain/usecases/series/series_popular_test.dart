import 'package:dartz/dartz.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/usecases/series/get_series_popular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularSeries usecase;
  late MockSeriesRepository mockSeriesRpository;

  setUp(() {
    mockSeriesRpository = MockSeriesRepository();
    usecase = GetPopularSeries(mockSeriesRpository);
  });

  final series = <Series>[];

  group('Get Series Series Popular Tests', () {
    group('execute', () {
      test(
          'should get list of Series Series from the repository when execute function is called',
          () async {
        // arrange
        when(mockSeriesRpository.getPopularSeries())
            .thenAnswer((_) async => Right(series));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(series));
      });
    });
  });
}
