import 'package:dartz/dartz.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/usecases/series/get_series_recommendation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeriesRecommendations usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetSeriesRecommendations(mockSeriesRepository);
  });

  final tId = 1;
  final series = <Series>[];

  test('should get list of Series Series recommendations from the repository',
      () async {
    // arrange
    when(mockSeriesRepository.getSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(series));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(series));
  });
}
