import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
    } else {
      return _databaseHelper;
    }
  }

  DatabaseHelper._internal();

  _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  _initializeDatabase() async {
    var lock = Lock();
    Database _db;

    if (_db == null) {
      await lock.synchronized(() async {
        if (_db == null) {
          var dbPath = await getDatabasesPath();
          var path = join(dbPath, "myDB.db");
          var file = new File(path);

          if (!await file.exists()) {
            ByteData data = await rootBundle.load(join("assets", "notlar.db"));

            List<int> bytes =
                data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
            await new File(path).writeAsBytes(bytes);
          }
          _db = await openDatabase(path);
        }
      });
    }
    return _db;
  }

  kategoriGetir() async {
    var db = await _getDatabase();
    var gelen = await db.query("kategori");
    debugPrint(gelen);
  }
}
