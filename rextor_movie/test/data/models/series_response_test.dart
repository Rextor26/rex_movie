import 'dart:convert';
import 'package:rextor/data/models/series/series_model.dart';
import 'package:rextor/data/models/series/series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main(){
  final seriesModel = SeriesModel(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    name: "Name",
    voteAverage: 1.0,
    voteCount: 1,
    originalName: '',
    originalLanguage: 'en',
    originCountry: ["US"],
  );
  final responseSeriesModel = ResponseSeries(seriesList: <SeriesModel>[seriesModel]);

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      ///arrange

      ///act
      final result = responseSeriesModel.toJson();
      ///assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "name": "Name",
            "vote_average": 1.0,
            "vote_count": 1,
            "original_name": '',
            "original_language": 'en',
            "origin_country": ["US"],
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      ///arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/series_on_the_air.json'));
      //act
      final result = ResponseSeries.fromJson(jsonMap);
      ///assert
      expect(result, responseSeriesModel);
    });
  });
}