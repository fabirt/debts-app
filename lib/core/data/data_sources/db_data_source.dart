import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:debts_app/core/data/models/index.dart';

abstract class DbDataSource {
  /// Create a new debtor.
  Future<int> addDebtor(DebtorModel debtor);

  /// Create a new debt.
  Future<int> addDebt(DebtModel debt);

  /// Create a new lender.
  Future<int> addLender(LenderModel lender);

  /// Create a new loan.
  Future<int> addLoan(LoanModel loan);

  /// Read all debtors.
  Future<List<DebtorModel>> getDebtors();

  /// Read all debts.
  Future<List<DebtModel>> getDebts();

  /// Read all debts for a debtor.
  Future<List<DebtModel>> getDebtsByDebtor(DebtorModel debtor);

  /// Read all lenders.
  Future<List<LenderModel>> getLenders();

  /// Read all loans for a lender.
  Future<List<LoanModel>> getLoansByLender(LenderModel lender);

  /// Update a debtor.
  Future<int> updateDebtor(DebtorModel debtor);

  /// Update a lender.
  Future<int> updateLender(LenderModel lender);

  /// Update a debt.
  Future<int> updateDebt(DebtModel debt);

  /// Update a loan.
  Future<int> updateLoan(LoanModel loan);

  /// Delete a debtor.
  Future<int> deleteDebtor(DebtorModel debtor);

  /// Delete a debt.
  Future<int> deleteDebt(DebtModel debt);

  /// Delete a lender.
  Future<int> deleteLender(LenderModel lender);

  /// Delete a loan.
  Future<int> deleteLoan(LoanModel loan);

  /// Delete all the debts of a deptor.
  Future<int> deleteAllDebtsByDebtor(DebtorModel debtor);

  /// Delete all the loans of a lender.
  Future<int> deleteAllLoansByLender(LenderModel lender);
}

class DbDataSourceImpl implements DbDataSource {
  static Database _database;

  static final DbDataSourceImpl _instance = DbDataSourceImpl._private();

  factory DbDataSourceImpl() => _instance;

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
  Future<int> addDebtor(DebtorModel debtor) async {
    final db = await database;
    final res = await db.insert('Debtors', debtor.toJson());
    return res;
  }

  @override
  Future<int> addDebt(DebtModel debt) async {
    final db = await database;
    final res = await db.insert('Debts', debt.toJson());
    return res;
  }

  @override
  Future<int> addLender(LenderModel lender) async {
    final db = await database;
    final res = await db.insert('Lenders', lender.toJson());
    return res;
  }

  @override
  Future<int> addLoan(LoanModel loan) async {
    final db = await database;
    final res = await db.insert('Loans', loan.toJson());
    return res;
  }

  // SELECT  ====================================
  @override
  Future<List<DebtorModel>> getDebtors() async {
    final db = await database;
    final res = await db.query('Debtors');
    final List<DebtorModel> list =
        res.isNotEmpty ? res.map((c) => DebtorModel.fromJson(c)).toList() : [];
    return list;
  }

  @override
  Future<List<DebtModel>> getDebts() async {
    final db = await database;
    final res = await db.query('Debts');
    final List<DebtModel> list =
        res.isNotEmpty ? res.map((c) => DebtModel.fromJson(c)).toList() : [];
    return list;
  }

  @override
  Future<List<DebtModel>> getDebtsByDebtor(DebtorModel debtor) async {
    final db = await database;
    final res =
        await db.rawQuery("SELECT * FROM Debts WHERE debtor_id='${debtor.id}'");
    final List<DebtModel> list =
        res.isNotEmpty ? res.map((c) => DebtModel.fromJson(c)).toList() : [];
    return list;
  }

  @override
  Future<List<LenderModel>> getLenders() async {
    final db = await database;
    final res = await db.query('Lenders');
    final List<LenderModel> list =
        res.isNotEmpty ? res.map((c) => LenderModel.fromJson(c)).toList() : [];
    return list;
  }

  @override
  Future<List<LoanModel>> getLoansByLender(LenderModel lender) async {
    final db = await database;
    final res =
        await db.rawQuery("SELECT * FROM Loans WHERE lender_id='${lender.id}'");
    final List<LoanModel> list =
        res.isNotEmpty ? res.map((c) => LoanModel.fromJson(c)).toList() : [];
    return list;
  }

  // UPDATE ====================================
  @override
  Future<int> updateDebtor(DebtorModel debtor) async {
    final db = await database;
    final res = await db.update('Debtors', debtor.toJson(),
        where: 'id = ?', whereArgs: [debtor.id]);
    return res;
  }

  @override
  Future<int> updateLender(LenderModel lender) async {
    final db = await database;
    final res = await db.update('Lenders', lender.toJson(),
        where: 'id = ?', whereArgs: [lender.id]);
    return res;
  }

  @override
  Future<int> updateDebt(DebtModel debt) async {
    final db = await database;
    final res = await db
        .update('Debts', debt.toJson(), where: 'id = ?', whereArgs: [debt.id]);
    return res;
  }

  @override
  Future<int> updateLoan(LoanModel loan) async {
    final db = await database;
    final res = await db
        .update('Loans', loan.toJson(), where: 'id = ?', whereArgs: [loan.id]);
    return res;
  }

  // DELETE  ====================================
  @override
  Future<int> deleteDebtor(DebtorModel debtor) async {
    final db = await database;
    final res =
        await db.delete('Debtors', where: 'id = ?', whereArgs: [debtor.id]);
    return res;
  }

  @override
  Future<int> deleteDebt(DebtModel debt) async {
    final db = await database;
    final res = await db.delete('Debts', where: 'id = ?', whereArgs: [debt.id]);
    return res;
  }

  @override
  Future<int> deleteLender(LenderModel lender) async {
    final db = await database;
    final res =
        await db.delete('Lenders', where: 'id = ?', whereArgs: [lender.id]);
    return res;
  }

  @override
  Future<int> deleteLoan(LoanModel loan) async {
    final db = await database;
    final res = await db.delete('Loans', where: 'id = ?', whereArgs: [loan.id]);
    return res;
  }

  @override
  Future<int> deleteAllDebtsByDebtor(DebtorModel debtor) async {
    final db = await database;
    final res = await db
        .delete('Debts', where: 'debtor_id = ?', whereArgs: [debtor.id]);
    return res;
  }

  @override
  Future<int> deleteAllLoansByLender(LenderModel lender) async {
    final db = await database;
    final res = await db
        .delete('Loans', where: 'lender_id = ?', whereArgs: [lender.id]);
    return res;
  }
}
