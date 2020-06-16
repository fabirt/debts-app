import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:debts_app/core/data/models/debt_model.dart';
import 'package:debts_app/core/data/models/person_model.dart';

abstract class DbDataSource {
  /// Create a new debtor.
  Future<int> addDebtor(PersonModel debtor);

  /// Create a new debt.
  Future<int> addDebt(DebtModel debt);

  /// Create a new lender.
  Future<int> addLender(PersonModel lender);

  /// Create a new loan.
  Future<int> addLoan(DebtModel loan);

  /// Read all debtors.
  Future<List<PersonModel>> getDebtors();

  /// Read all debts.
  Future<List<DebtModel>> getDebts();

  /// Read all debts for a debtor.
  Future<List<DebtModel>> getDebtsByDebtor(PersonModel debtor);

  /// Read all lenders.
  Future<List<PersonModel>> getLenders();

  /// Read all loans for a lender.
  Future<List<DebtModel>> getLoansByLender(PersonModel lender);

  /// Update a debtor.
  Future<int> updateDebtor(PersonModel debtor);

  /// Update a lender.
  Future<int> updateLender(PersonModel lender);

  /// Update a debt.
  Future<int> updateDebt(DebtModel debt);

  /// Update a loan.
  Future<int> updateLoan(DebtModel loan);

  /// Delete a debtor.
  Future<int> deleteDebtor(PersonModel debtor);

  /// Delete a debt.
  Future<int> deleteDebt(DebtModel debt);

  /// Delete a lender.
  Future<int> deleteLender(PersonModel lender);

  /// Delete a loan.
  Future<int> deleteLoan(DebtModel loan);

  /// Delete all the debts of a deptor.
  Future<int> deleteAllDebtsByDebtor(PersonModel debtor);

  /// Delete all the loans of a lender.
  Future<int> deleteAllLoansByLender(PersonModel lender);
}

class DbDataSourceImpl implements DbDataSource {
  static Database _database;

  static const debts = 'debts';
  static const debtors = 'debtors';
  static const loans = 'loans';
  static const lenders = 'lenders';

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
          'CREATE TABLE $debtors ('
          ' id INTEGER PRIMARY KEY,'
          ' name TEXT,'
          ' total DOUBLE'
          ')',
        );
        await db.execute(
          'CREATE TABLE $lenders ('
          ' id INTEGER PRIMARY KEY,'
          ' name TEXT,'
          ' total DOUBLE'
          ')',
        );
        await db.execute(
          'CREATE TABLE $debts ('
          ' id INTEGER PRIMARY KEY,'
          ' parent_id INTEGER,'
          ' description TEXT,'
          ' date TEXT,'
          ' value DOUBLE'
          ')',
        );
        await db.execute(
          'CREATE TABLE $loans ('
          ' id INTEGER PRIMARY KEY,'
          ' parent_id INTEGER,'
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
  Future<int> addDebtor(PersonModel debtor) async {
    final db = await database;
    final res = await db.insert(debtors, debtor.toJson());
    return res;
  }

  @override
  Future<int> addDebt(DebtModel debt) async {
    final db = await database;
    final res = await db.insert(debts, debt.toJson());
    return res;
  }

  @override
  Future<int> addLender(PersonModel lender) async {
    final db = await database;
    final res = await db.insert(lenders, lender.toJson());
    return res;
  }

  @override
  Future<int> addLoan(DebtModel loan) async {
    final db = await database;
    final res = await db.insert(loans, loan.toJson());
    return res;
  }

  // SELECT  ====================================
  @override
  Future<List<PersonModel>> getDebtors() async {
    final db = await database;
    final res = await db.query(debtors);
    final List<PersonModel> list =
        res.isNotEmpty ? res.map((c) => PersonModel.fromJson(c)).toList() : [];
    return list;
  }

  @override
  Future<List<DebtModel>> getDebts() async {
    final db = await database;
    final res = await db.query(debts);
    final List<DebtModel> list =
        res.isNotEmpty ? res.map((c) => DebtModel.fromJson(c)).toList() : [];
    return list;
  }

  @override
  Future<List<DebtModel>> getDebtsByDebtor(PersonModel debtor) async {
    final db = await database;
    final res =
        await db.rawQuery("SELECT * FROM Debts WHERE parent_id='${debtor.id}'");
    final List<DebtModel> list =
        res.isNotEmpty ? res.map((c) => DebtModel.fromJson(c)).toList() : [];
    return list;
  }

  @override
  Future<List<PersonModel>> getLenders() async {
    final db = await database;
    final res = await db.query(lenders);
    final List<PersonModel> list =
        res.isNotEmpty ? res.map((c) => PersonModel.fromJson(c)).toList() : [];
    return list;
  }

  @override
  Future<List<DebtModel>> getLoansByLender(PersonModel lender) async {
    final db = await database;
    final res =
        await db.rawQuery("SELECT * FROM Loans WHERE parent_id='${lender.id}'");
    final List<DebtModel> list =
        res.isNotEmpty ? res.map((c) => DebtModel.fromJson(c)).toList() : [];
    return list;
  }

  // UPDATE ====================================
  @override
  Future<int> updateDebtor(PersonModel debtor) async {
    final db = await database;
    final res = await db.update(debtors, debtor.toJson(),
        where: 'id = ?', whereArgs: [debtor.id]);
    return res;
  }

  @override
  Future<int> updateLender(PersonModel lender) async {
    final db = await database;
    final res = await db.update(lenders, lender.toJson(),
        where: 'id = ?', whereArgs: [lender.id]);
    return res;
  }

  @override
  Future<int> updateDebt(DebtModel debt) async {
    final db = await database;
    final res = await db
        .update(debts, debt.toJson(), where: 'id = ?', whereArgs: [debt.id]);
    return res;
  }

  @override
  Future<int> updateLoan(DebtModel loan) async {
    final db = await database;
    final res = await db
        .update(loans, loan.toJson(), where: 'id = ?', whereArgs: [loan.id]);
    return res;
  }

  // DELETE  ====================================
  @override
  Future<int> deleteDebtor(PersonModel debtor) async {
    final db = await database;
    final res =
        await db.delete(debtors, where: 'id = ?', whereArgs: [debtor.id]);
    return res;
  }

  @override
  Future<int> deleteDebt(DebtModel debt) async {
    final db = await database;
    final res = await db.delete(debts, where: 'id = ?', whereArgs: [debt.id]);
    return res;
  }

  @override
  Future<int> deleteLender(PersonModel lender) async {
    final db = await database;
    final res =
        await db.delete(lenders, where: 'id = ?', whereArgs: [lender.id]);
    return res;
  }

  @override
  Future<int> deleteLoan(DebtModel loan) async {
    final db = await database;
    final res = await db.delete(loans, where: 'id = ?', whereArgs: [loan.id]);
    return res;
  }

  @override
  Future<int> deleteAllDebtsByDebtor(PersonModel debtor) async {
    final db = await database;
    final res =
        await db.delete(debts, where: 'parent_id = ?', whereArgs: [debtor.id]);
    return res;
  }

  @override
  Future<int> deleteAllLoansByLender(PersonModel lender) async {
    final db = await database;
    final res =
        await db.delete(loans, where: 'parent_id = ?', whereArgs: [lender.id]);
    return res;
  }
}
