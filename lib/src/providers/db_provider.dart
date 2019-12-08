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
          'CREATE TABLE Lenders ('
          ' id INTEGER PRIMARY KEY,'
          ' name TEXT,'
          ' loan DOUBLE'
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
        await db.execute(
          'CREATE TABLE Loans ('
          ' id INTEGER PRIMARY KEY,'
          ' lender_id INTEGER,'
          ' description TEXT,'
          ' date TEXT,'
          ' value DOUBLE'
          ')',
        );
    });
  }

  // CREAR registros ====================================

  Future<int> addDebtor(Debtor debtor) async {
    final db = await database;
    final res = await db.insert('Debtors', debtor.toJson());
    return res;
  }
  
  Future<int> addDebt(Debt debt) async {
    final db = await database;
    final res = await db.insert('Debts', debt.toJson());
    return res;
  }
  
  Future<int> addLender(Lender lender) async {
    final db = await database;
    final res = await db.insert('Lenders', lender.toJson());
    return res;
  }
  
  Future<int> addLoan(Loan loan) async {
    final db = await database;
    final res = await db.insert('Loans', loan.toJson());
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


  Future<List<Lender>> getLenders() async {
    final db = await database;
    final res = await db.query('Lenders');
    List<Lender> list =
        res.isNotEmpty ? res.map((c) => Lender.fromJson(c)).toList() : [];
    return list;
  }
  
  Future<List<Loan>> getLoansByLender(Lender lender) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Loans WHERE lender_id='${lender.id}'");
    List<Loan> list =
        res.isNotEmpty ? res.map((c) => Loan.fromJson(c)).toList() : [];
    return list;
  }


  // UPDATE - Actualizar ====================================

  Future<int> updateDebtor(Debtor debtor) async {
    final db  = await database;
    final res = await db.update('Debtors', debtor.toJson(), where: 'id = ?', whereArgs: [debtor.id] );
    return res;
  }
  
  Future<int> updateLender(Lender lender) async {
    final db  = await database;
    final res = await db.update('Lenders', lender.toJson(), where: 'id = ?', whereArgs: [lender.id] );
    return res;
  }
  
  Future<int> updateDebt(Debt debt) async {
    final db  = await database;
    final res = await db.update('Debts', debt.toJson(), where: 'id = ?', whereArgs: [debt.id] );
    return res;
  }
  
  Future<int> updateLoan(Loan loan) async {
    final db  = await database;
    final res = await db.update('Loans', loan.toJson(), where: 'id = ?', whereArgs: [loan.id] );
    return res;
  }

  // DELETE - Eliminar ====================================

  Future<int> deleteDebtor(Debtor debtor) async {
    final db  = await database;
    final res = await db.delete('Debtors', where: 'id = ?', whereArgs: [debtor.id]);
    return res;
  }
  
  Future<int> deleteDebt(Debt debt) async {
    final db  = await database;
    final res = await db.delete('Debts', where: 'id = ?', whereArgs: [debt.id]);
    return res;
  }

  Future<int> deleteLender(Lender lender) async {
    final db  = await database;
    final res = await db.delete('Lenders', where: 'id = ?', whereArgs: [lender.id]);
    return res;
  }
  
  Future<int> deleteLoan(Loan loan) async {
    final db  = await database;
    final res = await db.delete('Loans', where: 'id = ?', whereArgs: [loan.id]);
    return res;
  }

  Future<int> deleteAllDebtsByDebtor(Debtor debtor) async {
    final db  = await database;
    final res = await db.delete('Debts', where: 'debtor_id = ?', whereArgs: [debtor.id]);
    return res;
  }

  Future<int> deleteAllLoansByLender(Lender lender) async {
    final db  = await database;
    final res = await db.delete('Loans', where: 'lender_id = ?', whereArgs: [lender.id]);
    return res;
  }

}
