import 'package:rextor_movie/data/datasources/db/movie_database_helper.dart';
import 'package:rextor_movie/data/datasources/db/series_database_helper.dart';
import 'package:rextor_movie/data/datasources/series_local_data_source.dart';
import 'package:rextor_movie/data/datasources/movie_local_data_source.dart';
import 'package:rextor_movie/data/datasources/remote_data_source.dart';
import 'package:rextor_movie/domain/repositories/movie_repository.dart';
import 'package:rextor_movie/domain/repositories/series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  RemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  RepositorySeries,
  SeriesLocalDataSource,
  DatabaseSeriesHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
