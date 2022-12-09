import 'package:dartz/dartz.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/usecases/series/get_series_search.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = SearchSeries(mockSeriesRepository);
  });

  final series = <Series>[];
  final tQuery = 'Game Of Throne';

  test('should get list of Series Series from the repository', () async {
    // arrange
    when(mockSeriesRepository.searchSeries(tQuery))
        .thenAnswer((_) async => Right(series));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(series));
  });
}