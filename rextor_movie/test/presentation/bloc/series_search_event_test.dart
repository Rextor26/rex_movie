import 'package:flutter_test/flutter_test.dart';
import 'package:rextor/presentation/bloc/search_page_event.dart';


void main() {
  test('Cek if props same with the input', () {
    expect(['Hail'], const OnQueryChanged('Hail').props);
  });
}
