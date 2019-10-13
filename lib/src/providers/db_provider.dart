import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider {

  static Database _database;

  static final DBProvider db = DBProvider._private();

  DBProvider._private();

  Future<Database> get database async {
    if (_database != null) {
        return _database;
    } else {
      _database = await initDB();
      return _database;
    }
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, 'debty.db' );
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: ( Database db, int version ) async {
        await db.execute(
          'CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' type TEXT,'
          ' value TEXT'
          ')'
        );
      }
    );
  }

  // CREAR registros ====================================
  
  // newScanRaw( ScanModel scan ) async {
  //   final db  = await database;
  //   final res = await db.rawInsert(
  //     "INSERT Into Scans (id, type, value) "
  //     "VALUES ( ${scan.id}, '${scan.type}', '${scan.value}' )"
  //   );
  //   return res;
  // }

  // newScan( ScanModel scan ) async {
  //   final db  = await database;
  //   final res = await db.insert('Scans', scan.toJson());
  //   return res;
  // }

  // SELECT - Obtener información ====================================
  
  // Future<ScanModel> getScanById( int id ) async {
  //   final db  = await database;
  //   final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
  //   return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  // }

  // Future<List<ScanModel>> getAllScans() async {
  //   final db  = await database;
  //   final res = await db.query('Scans');
  //   List<ScanModel> list = res.isNotEmpty 
  //                             ? res.map((c) => ScanModel.fromJson(c) ).toList()
  //                             : [];
  //   return list;
  // }

  // Future<List<ScanModel>> getScansByType( String type ) async {
  //   final db  = await database;
  //   final res = await db.rawQuery("SELECT * FROM Scans WHERE type='$type'");
  //   List<ScanModel> list = res.isNotEmpty 
  //                             ? res.map((c) => ScanModel.fromJson(c) ).toList()
  //                             : [];
  //   return list;
  // }

  // UPDATE - Actualizar ====================================

  // Future<int> updateScan( ScanModel scan ) async {
  //   final db  = await database;
  //   final res = await db.update('Scans', scan.toJson(), where: 'id = ?', whereArgs: [scan.id] );
  //   return res;
  // }

  // DELETE - Eliminar ====================================

  Future<int> deleteScan( int id ) async {
    final db  = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll() async {
    final db  = await database;
    final res = await db.rawDelete('DELETE FROM Scans');
    return res;
  }

}