import 'package:debts_app/core/data/models/index.dart';

abstract class LendersRepository {
  /// Get all lenders.
  Future<List<LenderModel>> getLenders();

  /// Get all loans.
  Future<List<DebtModel>> getLoans();

  /// Get debts for corresponding debtor
  Future<List<LoanModel>> getLoansForLender(LenderModel lender);

  /// Add lender.
  Future<void> addLender(LenderModel lender);

  /// Add loan.
  Future<void> addLoan(LoanModel loan);

  /// Update lender.
  Future<void> updateLender(LenderModel lender);

  /// Update loan.
  Future<void> updateLoan(LoanModel loan);

  /// Delete loan.
  Future<void> deleteLoan(LoanModel loan);

  /// Delete lender.
  Future<void> deleteLender(LenderModel lender);

  /// Delete all loans for corresponding lender.
  Future<void> deleteAllLoansForLender(LenderModel lender);
}
