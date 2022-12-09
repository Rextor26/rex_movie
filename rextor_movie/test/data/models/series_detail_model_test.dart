import 'dart:convert';

import 'package:rextor/data/models/series/series_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/series_detail.json'));
      // act
      final result = SeriesDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, testSeriesDetailResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testSeriesDetailResponse.toJson();

      // assert
      expect(result, testSeriesDetailResponseMap);
    });
  });
}