import 'package:intl/intl.dart';

import 'package:healthview/Data/databasehandler.dart';
import 'package:sqflite/sqflite.dart';



abstract class Entry {
  String _tableName;
  DateTime entryDate = DateTime.now();

  // Helper database functions
  void _createTable();
  void _insertEntry() async {
    Database database = await DatabaseHandler().database;
    await database.insert(_tableName, this.toMap());
  }


  // Convert to map for database entry
  Map<String, dynamic> toMap();

  // Create table if not already made and insert entry
  void save() {
    _createTable();
    _insertEntry();
  }

  // Gather all current entries in database
  Future<List<Entry>> selectAll();

  // Display all entries in console
  void printAll() async {
    List<Entry> entries  = await selectAll();

    int i = 1;
    for(Entry entry in entries) {
      print('$i++ : $entry.entryDate');
    }
  }
}

class BloodPressureEntry extends Entry {
  int systolic;
  int diastolic;

  BloodPressureEntry() {
    _tableName = 'bloodpressure';
  }

  @override
  void _createTable() async {
    Database database = await DatabaseHandler().database;
    await database.execute('CREATE TABLE IF NOT EXISTS $_tableName('
        'id INTEGER PRIMARY KEY, '
        'entryDate INTEGER, '
        'systolic INTEGER, '
        'diastolic INTEGER)');
  }

  @override
  Future<List<BloodPressureEntry>> selectAll() async {
    Database database = await DatabaseHandler().database;
    final List<Map<String, dynamic>> data = await database.query(_tableName);

    return List.generate(data.length, (i) {
      BloodPressureEntry entry = BloodPressureEntry();
      entry.systolic = data[i]['systolic'];
      entry.diastolic = data[i]['diastolic'];
      entry.entryDate = new
        DateTime.fromMillisecondsSinceEpoch(data[i]['entryDate']);
      return entry;
    });
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'entryDate' : entryDate.millisecondsSinceEpoch,
      'systolic' : systolic,
      'diastolic' : diastolic
    };
  }

  @override
  String toString() {
    String formattedDate = new DateFormat('yyyy-MM-dd HH:mm').format(entryDate);
    return '$systolic/$diastolic $formattedDate';
  }

  @override
  void printAll() async{
    List<BloodPressureEntry> entries = await selectAll();
    for(BloodPressureEntry entry in entries) {
      print(entry);
    }
  }
}

class MeasurementEntry extends Entry {
  int height;
  double weight;

  MeasurementEntry() {
    _tableName='measurement';
  }

  @override
  void _createTable() async {
    Database database = await DatabaseHandler().database;
    await database.execute('CREATE TABLE IF NOT EXISTS $_tableName('
        'id INTEGER PRIMARY KEY, '
        'entryDate INTEGER, '
        'height INTEGER, '
        'weight DOUBLE)');
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'entryDate' :  entryDate.millisecondsSinceEpoch,
      'height' : height,
      'weight' : weight
    };
  }

  @override
  Future<List<MeasurementEntry>> selectAll() async {
    Database database = await DatabaseHandler().database;
    final List<Map<String, dynamic>> data = await database.query(_tableName);

    return List.generate(data.length, (i) {
      MeasurementEntry entry = MeasurementEntry();
      entry.height = data[i]['height'];
      entry.weight = data[i]['weight'];
      entry.entryDate = new
        DateTime.fromMillisecondsSinceEpoch(data[i]['entryDate']);
      return entry;
    });
  }

  @override
  String toString() {
    String formattedDate = new DateFormat('yyyy-MM-dd HH:mm').format(entryDate);
    return '$height inches, $weight lbs $formattedDate';
  }

  @override
  void printAll() async {
    List<MeasurementEntry> entries = await selectAll();
    for(MeasurementEntry entry in entries) {
      print(entry);
    }
  }
}