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
  
  Future<List<Debt>> getDebtsByDebtor(Debtor debtor) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Debts WHERE debtor_id='${debtor.id}'");
    List<Debt> list =
        res.isNotEmpty ? res.map((c) => Debt.fromJson(c)).toList() : [];
    return list;
  }


  // UPDATE - Actualizar ====================================

  Future<int> updateDebtor(Debtor debtor) async {
    final db  = await database;
    final res = await db.update('Debtors', debtor.toJson(), where: 'id = ?', whereArgs: [debtor.id] );
    return res;
  }

  // DELETE - Eliminar ====================================

  Future<int> deleteDebt(Debt debt) async {
    final db  = await database;
    final res = await db.delete('Debts', where: 'id = ?', whereArgs: [debt.id]);
    return res;
  }

  // Future<int> deleteAll() async {
  //   final db  = await database;
  //   final res = await db.rawDelete('DELETE FROM Scans');
  //   return res;
  // }

}
