import 'package:debts_app/core/data/data_sources/db_data_source.dart';
import 'package:debts_app/core/data/models/debt_model.dart';
import 'package:debts_app/core/data/models/person_model.dart';
import 'package:debts_app/core/domain/entities/debt.dart';
import 'package:debts_app/core/domain/entities/person.dart';
import 'package:debts_app/core/domain/repositories/debtors_repository.dart';

class DebtorsRepositoryImpl implements DebtorsRepository {
  final DbDataSource dbDataSource = DbDataSourceImpl();

  static final _instance = DebtorsRepositoryImpl._internal();
  factory DebtorsRepositoryImpl() => _instance;
  DebtorsRepositoryImpl._internal();

  @override
  Future<void> addDebt(Debt debt) async {
    await dbDataSource.addDebt(DebtModel.fromEntity(debt));
  }

  @override
  Future<void> addDebtor(Person debtor) async {
    await dbDataSource.addDebtor(PersonModel.fromEntity(debtor));
  }

  @override
  Future<void> deleteAllDebtsForDebtor(Person debtor) async {
    await dbDataSource.deleteAllDebtsByDebtor(PersonModel.fromEntity(debtor));
  }

  @override
  Future<void> deleteDebt(Debt debt) async {
    await dbDataSource.deleteDebt(DebtModel.fromEntity(debt));
  }

  @override
  Future<void> deleteDebtor(Person debtor) async {
    await dbDataSource.deleteDebtor(PersonModel.fromEntity(debtor));
  }

  @override
  Future<List<Person>> getDebtors() async {
    return dbDataSource.getDebtors();
  }

  @override
  Future<List<Debt>> getDebts() async {
    return dbDataSource.getDebts();
  }

  @override
  Future<List<Debt>> getDebtsForDebtor(Person debtor) {
    return dbDataSource.getDebtsByDebtor(PersonModel.fromEntity(debtor));
  }

  @override
  Future<void> updateDebt(Debt debt) async {
    await dbDataSource.updateDebt(DebtModel.fromEntity(debt));
  }

  @override
  Future<void> updateDebtor(Person debtor) async {
    await dbDataSource.updateDebtor(PersonModel.fromEntity(debtor));
  }
}
