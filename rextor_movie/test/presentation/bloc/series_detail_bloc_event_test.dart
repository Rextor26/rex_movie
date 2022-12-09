import 'package:rextor/presentation/bloc/series/series_detail_event.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  test('Cek if props same with the input', () {
    expect([1], const FetchSeriesDetailById(1).props);
    expect([testSeriesDetail],  AddWatchlistSeries(testSeriesDetail).props);
    expect(
        [testSeriesDetail],  RemoveSeriesWatchlist(testSeriesDetail).props);
    expect([1], const LoadWatchlistStatus(1).props);
  });
}

