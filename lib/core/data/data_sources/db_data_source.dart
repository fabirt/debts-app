import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:debts_app/core/data/models/index.dart';

abstract class DbDataSource {
  /// Create a new debtor.
  Future<int> addDebtor(Debtor debtor);

  /// Create a new debt.
  Future<int> addDebt(Debt debt);

  /// Create a new lender.
  Future<int> addLender(Lender lender);

  /// Create a new loan.
  Future<int> addLoan(Loan loan);

  /// Read all debtors.
  Future<List<Debtor>> getDebtors();

  /// Read all debts.
  Future<List<Debt>> getDebts();

  /// Read all debts for a debtor.
  Future<List<Debt>> getDebtsByDebtor(Debtor debtor);

  /// Read all lenders.
  Future<List<Lender>> getLenders();

  /// Read all loans for a lender.
  Future<List<Loan>> getLoansByLender(Lender lender);

  /// Update a debtor.
  Future<int> updateDebtor(Debtor debtor);

  /// Update a lender.
  Future<int> updateLender(Lender lender);

  /// Update a debt.
  Future<int> updateDebt(Debt debt);

  /// Update a loan.
  Future<int> updateLoan(Loan loan);

  /// Delete a debtor.
  Future<int> deleteDebtor(Debtor debtor);

  /// Delete a debt.
  Future<int> deleteDebt(Debt debt);

  /// Delete a lender.
  Future<int> deleteLender(Lender lender);

  /// Delete a loan.
  Future<int> deleteLoan(Loan loan);

  /// Delete all the debts of a deptor.
  Future<int> deleteAllDebtsByDebtor(Debtor debtor);

  /// Delete all the loans of a lender.
  Future<int> deleteAllLoansByLender(Lender lender);
}

class DbDataSourceImpl implements DbDataSource {
  static Database _database;

  static final DbDataSourceImpl _instance = DbDataSourceImpl._private();

  factory DbDataSourceImpl() {
    return _instance;
  }

  DbDataSourceImpl._private();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      return _database = await initDB();
    }
  }

  Future<Database> initDB() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'debty.db');
    return openDatabase(
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
      },
    );
  }

  // CREATE ====================================
  @override
  Future<int> addDebtor(Debtor debtor) async {
    final db = await database;
    final res = await db.insert('Debtors', debtor.toJson());
    return res;
  }

  @override
  Future<int> addDebt(Debt debt) async {
    final db = await database;
    final res = await db.insert('Debts', debt.toJson());
    return res;
  }

  @override
  Future<int> addLender(Lender lender) async {
    final db = await database;
    final res = await db.insert('Lenders', lender.toJson());
    return res;
  }

  @override
  Future<int> addLoan(Loan loan) async {
    final db = await database;
    final res = await db.insert('Loans', loan.toJson());
    return res;
  }

  // SELECT  ====================================
  @override
  Future<List<Debtor>> getDebtors() async {
    final db = await database;
    final res = await db.query('Debtors');
    final List<Debtor> list =
        res.isNotEmpty ? res.map((c) => Debtor.fromJson(c)).toList() : [];
    return list;
  }

  @override
  Future<List<Debt>> getDebts() async {
    final db = await database;
    final res = await db.query('Debts');
    final List<Debt> list =
        res.isNotEmpty ? res.map((c) => Debt.fromJson(c)).toList() : [];
    return list;
  }

  @override
  Future<List<Debt>> getDebtsByDebtor(Debtor debtor) async {
    final db = await database;
    final res =
        await db.rawQuery("SELECT * FROM Debts WHERE debtor_id='${debtor.id}'");
    final List<Debt> list =
        res.isNotEmpty ? res.map((c) => Debt.fromJson(c)).toList() : [];
    return list;
  }

  @override
  Future<List<Lender>> getLenders() async {
    final db = await database;
    final res = await db.query('Lenders');
    final List<Lender> list =
        res.isNotEmpty ? res.map((c) => Lender.fromJson(c)).toList() : [];
    return list;
  }

  @override
  Future<List<Loan>> getLoansByLender(Lender lender) async {
    final db = await database;
    final res =
        await db.rawQuery("SELECT * FROM Loans WHERE lender_id='${lender.id}'");
    final List<Loan> list =
        res.isNotEmpty ? res.map((c) => Loan.fromJson(c)).toList() : [];
    return list;
  }

  // UPDATE ====================================
  @override
  Future<int> updateDebtor(Debtor debtor) async {
    final db = await database;
    final res = await db.update('Debtors', debtor.toJson(),
        where: 'id = ?', whereArgs: [debtor.id]);
    return res;
  }

  @override
  Future<int> updateLender(Lender lender) async {
    final db = await database;
    final res = await db.update('Lenders', lender.toJson(),
        where: 'id = ?', whereArgs: [lender.id]);
    return res;
  }

  @override
  Future<int> updateDebt(Debt debt) async {
    final db = await database;
    final res = await db
        .update('Debts', debt.toJson(), where: 'id = ?', whereArgs: [debt.id]);
    return res;
  }

  @override
  Future<int> updateLoan(Loan loan) async {
    final db = await database;
    final res = await db
        .update('Loans', loan.toJson(), where: 'id = ?', whereArgs: [loan.id]);
    return res;
  }

  // DELETE  ====================================
  @override
  Future<int> deleteDebtor(Debtor debtor) async {
    final db = await database;
    final res =
        await db.delete('Debtors', where: 'id = ?', whereArgs: [debtor.id]);
    return res;
  }

  @override
  Future<int> deleteDebt(Debt debt) async {
    final db = await database;
    final res = await db.delete('Debts', where: 'id = ?', whereArgs: [debt.id]);
    return res;
  }

  @override
  Future<int> deleteLender(Lender lender) async {
    final db = await database;
    final res =
        await db.delete('Lenders', where: 'id = ?', whereArgs: [lender.id]);
    return res;
  }

  @override
  Future<int> deleteLoan(Loan loan) async {
    final db = await database;
    final res = await db.delete('Loans', where: 'id = ?', whereArgs: [loan.id]);
    return res;
  }

  @override
  Future<int> deleteAllDebtsByDebtor(Debtor debtor) async {
    final db = await database;
    final res = await db
        .delete('Debts', where: 'debtor_id = ?', whereArgs: [debtor.id]);
    return res;
  }

  @override
  Future<int> deleteAllLoansByLender(Lender lender) async {
    final db = await database;
    final res = await db
        .delete('Loans', where: 'lender_id = ?', whereArgs: [lender.id]);
    return res;
  }
}
