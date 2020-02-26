import 'package:debts_app/core/data/data_sources/db_data_source.dart';
import 'package:debts_app/core/data/models/index.dart';
import 'package:debts_app/core/domain/repositories/debtors_repository.dart';

class DebtorsRepositoryImpl implements DebtorsRepository {
  final DbDataSource dbDataSource = DbDataSourceImpl();

  static final _instance = DebtorsRepositoryImpl._internal();
  factory DebtorsRepositoryImpl() => _instance;
  DebtorsRepositoryImpl._internal();

  @override
  Future<void> addDebt(DebtModel debt) async {
    await dbDataSource.addDebt(debt);
  }

  @override
  Future<void> addDebtor(DebtorModel debtor) async {
    await dbDataSource.addDebtor(debtor);
  }

  @override
  Future<void> deleteAllDebtsForDebtor(DebtorModel debtor) async {
    await dbDataSource.deleteAllDebtsByDebtor(debtor);
  }

  @override
  Future<void> deleteDebt(DebtModel debt) async {
    await dbDataSource.deleteDebt(debt);
  }

  @override
  Future<void> deleteDebtor(DebtorModel debtor) async {
    await dbDataSource.deleteDebtor(debtor);
  }

  @override
  Future<List<DebtorModel>> getDebtors() async {
    return dbDataSource.getDebtors();
  }

  @override
  Future<List<DebtModel>> getDebts() async {
    return dbDataSource.getDebts();
  }

  @override
  Future<List<DebtModel>> getDebtsForDebtor(DebtorModel debtor) {
    return dbDataSource.getDebtsByDebtor(debtor);
  }

  @override
  Future<void> updateDebt(DebtModel debt) async {
    await dbDataSource.updateDebt(debt);
  }

  @override
  Future<void> updateDebtor(DebtorModel debtor) async {
    await dbDataSource.updateDebtor(debtor);
  }
}
