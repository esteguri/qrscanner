import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qrscanner/src/models/scan.model.dart';
export 'package:qrscanner/src/models/scan.model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database == null) _database = await _initDB();

    return _database;
  }

  _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "ScansDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Scans ('
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'valor TEXT'
          ')',
        );
      },
    );
  }

  // CREAR Registros
  newScanRaw(Scan newScan) async {
    final db = await database;
    final res = await db.rawInsert(
      "INSERT INTO Scans (id, tipo, valor) "
      "VALUES (${newScan.id}, '${newScan.tipo}', '${newScan.valor}')",
    );
    return res;
  }

  newScan(Scan newScan) async {
    final db = await database;
    final res = await db.insert("Scans", newScan.toJson());
    return res;
  }

  // OBTENER INFO
  Future<Scan> getScanById(int id) async {
    final db = await database;
    final res = await db.query("Scans", where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Scan.fromJson(res.first) : null;
  }

  Future<List<Scan>> getScans() async {
    final db = await database;
    final res = await db.query("Scans");
    List<Scan> list = [];
    if (res.isNotEmpty) list = res.map((e) => Scan.fromJson(e)).toList();
    return list;
  }

  Future<List<Scan>> getScansByType(String type) async {
    final db = await database;
    final res = await db.query("Scans", where: "tipo = ?", whereArgs: [type]);
    List<Scan> list = [];
    if (res.isNotEmpty) list = res.map((e) => Scan.fromJson(e)).toList();
    return list;
  }

  Future<int> updateScan(Scan scan) async {
    final db = await database;
    final res = await db.update(
      "Scans",
      scan.toJson(),
      where: 'id = ?',
      whereArgs: [scan.id],
    );
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete(
      "Scans",
      where: 'id = ?',
      whereArgs: [id],
    );
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.delete(
      "Scans",
    );
    return res;
  }
}
