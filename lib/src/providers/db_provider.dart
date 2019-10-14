import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:debts_app/src/models/index.dart';

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
    final path = join(documentsDirectory.path, 'debty.db');
    return await openDatabase(
      path, 
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Debtors ('
          ' id INTEGER PRIMARY KEY,'
          ' name TEXT,'
          ' debt DOUBLE'
          ')',
        );
        await db.execute(
          'CREATE TABLE Debts ('
          ' id INTEGER PRIMARY KEY,'
          ' debtor_id INTEGER,'
          ' description TEXT,'
          ' date TEXT,'
          ' value DOUBLE'
          ')',
        );
    });
  }

  // CREAR registros ====================================

  addDeptor(Debtor debtor) async {
    final db = await database;
    final res = await db.insert('Debtors', debtor.toJson());
    return res;
  }
  
  addDept(Debt debt) async {
    final db = await database;
    final res = await db.insert('Debts', debt.toJson());
    return res;
  }

  // SELECT - Obtener información ====================================

  // Future<ScanModel> getScanById( int id ) async {
  //   final db  = await database;
  //   final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
  //   return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  // }

  Future<List<Debtor>> getDebtors() async {
    final db = await database;
    final res = await db.query('Debtors');
    List<Debtor> list =
        res.isNotEmpty ? res.map((c) => Debtor.fromJson(c)).toList() : [];
    return list;
  }
  
  Future<List<Debt>> getDebts() async {
    final db = await database;
    final res = await db.query('Debts');
    List<Debt> list =
        res.isNotEmpty ? res.map((c) => Debt.fromJson(c)).toList() : [];
    return list;
  }

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

  // Future<int> deleteScan( int id ) async {
  //   final db  = await database;
  //   final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
  //   return res;
  // }

  // Future<int> deleteAll() async {
  //   final db  = await database;
  //   final res = await db.rawDelete('DELETE FROM Scans');
  //   return res;
  // }

}
