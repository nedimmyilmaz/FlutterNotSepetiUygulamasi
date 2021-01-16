import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutterNotSepeti/models/kategori.dart';
import 'package:flutterNotSepeti/models/notlar.dart';
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
    Database _db;
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "notlar.db");
    var exists = await databaseExists(path);

    if (!exists) {
      print("Creating new copy from asset");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "notlar.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    return await openDatabase(path, readOnly: false);

  }

  Future<List<Map<String, dynamic>>> kategoriGetir() async {
    var db = await _getDatabase();
    var islem = await db.query("kategori");
    return islem;
  }



  Future<int> kategoriEkle(Kategori kategori) async{
    var db = await _getDatabase();
    var islem = await db.insert("kategori", kategori.toMap());
    return  islem;
  }

  Future<int> kategoriGuncelle(Kategori kategori) async{
    var db = await _getDatabase();
    var islem = await db.update("kategori", kategori.toMap(), where: "kategoriID  = ?", whereArgs: [kategori.kategoriID]);
    return  islem;
  }


  Future<int> kategoriSil(int kategoriID) async{
    var db = await _getDatabase();
    var islem = await db.delete("kategori", where: "kategoriID  = ?", whereArgs: [kategoriID]);
    return  islem;
  }



  Future<List<Map<String, dynamic>>> notlariGetir() async {
    var db = await _getDatabase();
    var islem = await db.query("not", orderBy: "notID DESC");
    return islem;
  }



  Future<int> notEkle(Not not) async{
    var db = await _getDatabase();
    var islem = await db.insert("not", not.toMap());
    return  islem;
  }

  Future<int> notGuncelle(Not not) async{
    var db = await _getDatabase();
    var islem = await db.update("not", not.toMap(), where: "notID  = ?", whereArgs: [not.notID]);
    return  islem;
  }


  Future<int> notSil(int notID) async{
    var db = await _getDatabase();
    var islem = await db.delete("not", where: "notID  = ?", whereArgs: [notID]);
    return  islem;
  }



























}
