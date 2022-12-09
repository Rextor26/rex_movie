import 'package:flutter_test/flutter_test.dart';
import 'package:rextor/presentation/bloc/movie_page_event.dart';

void main() {
  test('Cek if props same with the input', () {
    expect([], const FetchMoviesData().props);
    expect([1], const FetchMovieDataWithId(1).props);
  });
}
