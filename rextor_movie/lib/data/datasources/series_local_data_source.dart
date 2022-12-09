import 'package:rextor/common/exception.dart';
import 'package:rextor/data/datasources/db/series_database_helper.dart';
import 'package:rextor/data/models/series/series_table.dart';

abstract class SeriesLocalDataSource{
  Future<String> insertSeriesWatchlist(SeriesTable seriesTable);
  Future<String> removeWatchlistSeries(SeriesTable seriesTable);
  Future<SeriesTable?> getSeriesById(int id);
  Future<List<SeriesTable>> getWatchlistSeries();
}


class SeriesLocalDataSourceImpl implements SeriesLocalDataSource{
  final DatabaseSeriesHelper databaseHelperSeries;

  SeriesLocalDataSourceImpl({required this.databaseHelperSeries});

  @override
  Future<String> insertSeriesWatchlist(SeriesTable seriesTable) async {
    try{
      await databaseHelperSeries.insertSeriesWatchlist(seriesTable);
      return 'Added to watchlist';
    }catch (e){
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<SeriesTable?> getSeriesById(int id) async{
    final result = await databaseHelperSeries.getSeriesById(id);
    if(result != null){
      return SeriesTable.fromMap(result);
    }else{
      return null;
    }
  }

  @override
  Future<List<SeriesTable>> getWatchlistSeries() async{
    final result = await databaseHelperSeries.getWatchlistSeries();
    return result.map((e) => SeriesTable.fromMap(e)).toList();
  }


  @override
  Future<String> removeWatchlistSeries(SeriesTable seriesTable) async{
    try{
      await databaseHelperSeries.removeWatchList(seriesTable);
      return 'Remove from watchlist';
    }catch(e){
      throw DatabaseException(e.toString());
    }
  }

}

