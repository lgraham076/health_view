import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  static final DatabaseHandler _handler = DatabaseHandler._internal();
  static final _databaseName = 'healthview.db';

  static Database _database;

  factory DatabaseHandler() => _handler;

  DatabaseHandler._internal();

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }

    return _database;
  }

  _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
    );
  }
}
