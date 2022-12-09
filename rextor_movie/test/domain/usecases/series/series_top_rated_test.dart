import 'package:dartz/dartz.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/usecases/series/get_series_top_rated.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetTopRatedSeries(mockSeriesRepository);
  });

  final series = <Series>[];

  test('should get list of Series Series from repository', () async {
    // arrange
    when(mockSeriesRepository.getTopRatedSeries())
        .thenAnswer((_) async => Right(series));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(series));
  });
}