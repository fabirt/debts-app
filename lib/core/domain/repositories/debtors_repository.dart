import 'package:debts_app/core/domain/entities/debt.dart';
import 'package:debts_app/core/domain/entities/person.dart';

abstract class DebtorsRepository {
  /// Get all debtors.
  Future<List<Person>> getDebtors();

  /// Get all debts.
  Future<List<Debt>> getDebts();

  /// Get debts for corresponding debtor
  Future<List<Debt>> getDebtsForDebtor(Person debtor);

  /// Add debtor.
  Future<void> addDebtor(Person debtor);

  /// Add debt.
  Future<void> addDebt(Debt debt);

  /// Update debtor.
  Future<void> updateDebtor(Person debtor);

  /// Update debt.
  Future<void> updateDebt(Debt debt);

  /// Delete debt.
  Future<void> deleteDebt(Debt debt);

  /// Delete debtor.
  Future<void> deleteDebtor(Person debtor);

  /// Delete all debts for corresponding debtor.
  Future<void> deleteAllDebtsForDebtor(Person debtor);
}
