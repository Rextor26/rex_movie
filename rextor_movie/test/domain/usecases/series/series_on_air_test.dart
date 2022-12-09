import 'package:dartz/dartz.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/usecases/series/get_series_on_air.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnTheAirSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetOnTheAirSeries(mockSeriesRepository);
  });

  final series = <Series>[];

  group('Get On The Air Series Series', (){
    test('should get list of Series Series from the repository', () async {
    // arrange
      when(mockSeriesRepository.getOnTheAirSeries())
          .thenAnswer((_) async => Right(series));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(series));
    });
  });

  
}