import 'package:rextor/data/models/series/series_table.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseSeriesHelper{
  static DatabaseSeriesHelper? _databaseHelperSeries;
  DatabaseSeriesHelper._instance(){
    _databaseHelperSeries = this;
  }

  factory DatabaseSeriesHelper() => _databaseHelperSeries ?? DatabaseSeriesHelper._instance();

  static Database? _database;
  Future<Database?> get database async{
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlistSeries';  

  Future<Database> _initDb() async{
    final path = await getDatabasesPath();
    final databasePath = '$path/rex_series.db';
    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }
  void _onCreate(Database db, int version) async{
    await db.execute('''
        CREATE TABLE $_tblWatchlist(
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
        );
    ''');
  }

  Future<int> insertSeriesWatchlist(SeriesTable seriesTable) async{
    final db = await database;
    return await db!.insert(_tblWatchlist, seriesTable.toJson());
  }

  Future<int> removeWatchList(SeriesTable seriesTable) async{
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [seriesTable.id],
    );
  }

  Future<Map<String, dynamic>?> getSeriesById(int id) async{
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );
    if(results.isNotEmpty){
      return results.first;
    }else{
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistSeries() async{
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }
}