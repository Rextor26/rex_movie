import 'package:dartz/dartz.dart';
import 'package:rextor_movie/common/failure.dart';
import 'package:rextor_movie/domain/entities/movie/movie.dart';
import 'package:rextor_movie/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
