import 'package:rextor/domain/repositories/series_repository.dart';

class GetWatchlistStatusSeries{
  final RepositorySeries repository;

  GetWatchlistStatusSeries(this.repository);
  Future<bool> execute(int id)async{
    return repository.isAddedToWatchlistSeries(id);
  }
}