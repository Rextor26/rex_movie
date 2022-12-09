import 'package:rextor/data/models/series/season_model.dart';
import 'package:rextor/domain/entities/series/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  final seasonModel = SeasonModel(
      episodeCount: 1, 
      id: 1,
      name: 'name',
      overview: 'overview', 
      posterPath: 'posterPath', 
      seasonNumber: 1,  
  );
  final season = Season(
      episodeCount: 1, 
      id: 1, 
      name: 'name',
      overview: 'overview', 
      posterPath: 'posterPath', 
      seasonNumber: 1, 
  );


  test('should be a subclass of season entity', () async {
    final result = seasonModel.toEntity();
    expect(result, season);
  });

}