import 'package:debts_app/core/data/data_sources/db_data_source.dart';
import 'package:debts_app/core/data/models/debt_model.dart';
import 'package:debts_app/core/data/models/person_model.dart';
import 'package:debts_app/core/domain/entities/debt.dart';
import 'package:debts_app/core/domain/entities/person.dart';
import 'package:debts_app/core/domain/repositories/lenders_repository.dart';

class LendersRepositoryImpl implements LendersRepository {
  final DbDataSource dbDataSource = DbDataSourceImpl();

  static final _instance = LendersRepositoryImpl._internal();
  factory LendersRepositoryImpl() => _instance;
  LendersRepositoryImpl._internal();

  @override
  Future<void> addLender(Person lender) async {
    await dbDataSource.addLender(PersonModel.fromEntity(lender));
  }

  @override
  Future<void> addLoan(Debt loan) async {
    await dbDataSource.addLoan(DebtModel.fromEntity(loan));
  }

  @override
  Future<void> deleteAllLoansForLender(Person lender) async {
    await dbDataSource.deleteAllLoansByLender(PersonModel.fromEntity(lender));
  }

  @override
  Future<void> deleteLender(Person lender) async {
    await dbDataSource.deleteLender(PersonModel.fromEntity(lender));
  }

  @override
  Future<void> deleteLoan(Debt loan) async {
    await dbDataSource.deleteLoan(DebtModel.fromEntity(loan));
  }

  @override
  Future<List<Person>> getLenders() async {
    return dbDataSource.getLenders();
  }

  @override
  Future<List<DebtModel>> getLoans() async {
    return null;
  }

  @override
  Future<List<Debt>> getLoansForLender(Person lender) async {
    return dbDataSource.getLoansByLender(PersonModel.fromEntity(lender));
  }

  @override
  Future<void> updateLender(Person lender) async {
    await dbDataSource.updateLender(PersonModel.fromEntity(lender));
  }

  @override
  Future<void> updateLoan(Debt loan) async {
    await dbDataSource.updateLoan(DebtModel.fromEntity(loan));
  }
}
