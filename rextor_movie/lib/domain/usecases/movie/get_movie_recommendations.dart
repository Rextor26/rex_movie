import 'package:dartz/dartz.dart';
import 'package:rextor_movie/domain/entities/movie/movie.dart';
import 'package:rextor_movie/domain/repositories/movie_repository.dart';
import 'package:rextor_movie/common/failure.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
