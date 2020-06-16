import 'package:debts_app/core/domain/entities/debt.dart';
import 'package:debts_app/core/domain/entities/person.dart';

abstract class LendersRepository {
  /// Get all lenders.
  Future<List<Person>> getLenders();

  /// Get all loans.
  Future<List<Debt>> getLoans();

  /// Get loans for corresponding lender.
  Future<List<Debt>> getLoansForLender(Person lender);

  /// Add lender.
  Future<void> addLender(Person lender);

  /// Add loan.
  Future<void> addLoan(Debt loan);

  /// Update lender.
  Future<void> updateLender(Person lender);

  /// Update loan.
  Future<void> updateLoan(Debt loan);

  /// Delete loan.
  Future<void> deleteLoan(Debt loan);

  /// Delete lender.
  Future<void> deleteLender(Person lender);

  /// Delete all loans for corresponding lender.
  Future<void> deleteAllLoansForLender(Person lender);
}
