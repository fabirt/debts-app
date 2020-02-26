import 'package:debts_app/core/data/models/index.dart';

abstract class DebtorsRepository {
  /// Get all debtors.
  Future<List<DebtorModel>> getDebtors();

  /// Get all debts.
  Future<List<DebtModel>> getDebts();

  /// Get debts for corresponding debtor
  Future<List<DebtModel>> getDebtsForDebtor(DebtorModel debtor);

  /// Add debtor.
  Future<void> addDebtor(DebtorModel debtor);

  /// Add debt.
  Future<void> addDebt(DebtModel debt);

  /// Update debtor.
  Future<void> updateDebtor(DebtorModel debtor);

  /// Update debt.
  Future<void> updateDebt(DebtModel debt);

  /// Delete debt.
  Future<void> deleteDebt(DebtModel debt);

  /// Delete debtor.
  Future<void> deleteDebtor(DebtorModel debtor);

  /// Delete all debts for corresponding debtor.
  Future<void> deleteAllDebtsForDebtor(DebtorModel debtor);
}
