import 'package:dartz/dartz.dart';
import 'package:rextor_movie/common/failure.dart';
import 'package:rextor_movie/domain/entities/movie/movie.dart';
import 'package:rextor_movie/domain/repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
