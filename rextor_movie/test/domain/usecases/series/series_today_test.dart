import 'package:dartz/dartz.dart';
import 'package:rextor/domain/entities/series/series.dart';
import 'package:rextor/domain/usecases/series/get_series_today.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main(){
  late GetAiringTodaySeries getSeriesAiringToday;
  late MockSeriesRepository mockSeriesRepository;
  setUp((){
    mockSeriesRepository = MockSeriesRepository();
    getSeriesAiringToday = GetAiringTodaySeries(mockSeriesRepository);
  });

  final series = <Series>[];
  group('Get Airing Today Series Series', (){
    test('should get list of Series Series from the repository', () async{
      ///arrange
      when(mockSeriesRepository.getAiringTodaySeries()).thenAnswer((_) async=> Right(series));
      ///act
      final result = await getSeriesAiringToday.execute();
      ///assert
      expect(result, Right(series));
    });
  });
}