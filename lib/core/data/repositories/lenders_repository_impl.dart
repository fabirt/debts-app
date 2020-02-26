import 'package:debts_app/core/data/data_sources/db_data_source.dart';
import 'package:debts_app/core/data/models/index.dart';
import 'package:debts_app/core/domain/repositories/lenders_repository.dart';

class LendersRepositoryImpl implements LendersRepository {
  final DbDataSource dbDataSource = DbDataSourceImpl();

  @override
  Future<void> addLender(LenderModel lender) async {
    await dbDataSource.addLender(lender);
  }

  @override
  Future<void> addLoan(LoanModel loan) async {
    await dbDataSource.addLoan(loan);
  }

  @override
  Future<void> deleteAllLoansForLender(LenderModel lender) async {
    await dbDataSource.deleteAllLoansByLender(lender);
  }

  @override
  Future<void> deleteLender(LenderModel lender) async {
    await dbDataSource.deleteLender(lender);
  }

  @override
  Future<void> deleteLoan(LoanModel loan) async {
    await dbDataSource.deleteLoan(loan);
  }

  @override
  Future<List<LenderModel>> getLenders() async {
    return dbDataSource.getLenders();
  }

  @override
  Future<List<DebtModel>> getLoans() async {
    return null;
  }

  @override
  Future<List<LoanModel>> getLoansForLender(LenderModel lender) async {
    return dbDataSource.getLoansByLender(lender);
  }

  @override
  Future<void> updateLender(LenderModel lender) async {
    await dbDataSource.updateLender(lender);
  }

  @override
  Future<void> updateLoan(LoanModel loan) async {
    await dbDataSource.updateLoan(loan);
  }
}
