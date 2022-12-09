import 'package:dartz/dartz.dart';
import 'package:rextor/domain/entities/movie/movie.dart';
import 'package:rextor/domain/repositories/movie_repository.dart';
import 'package:rextor/common/failure.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
