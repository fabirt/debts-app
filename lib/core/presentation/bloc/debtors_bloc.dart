import 'package:rxdart/rxdart.dart';

import 'package:debts_app/core/domain/entities/debt.dart';
import 'package:debts_app/core/domain/entities/person.dart';
import 'package:debts_app/core/domain/entities/resume.dart';
import 'package:debts_app/core/data/repositories/debtors_repository_impl.dart';
import 'package:debts_app/core/domain/repositories/debtors_repository.dart';

class DebtorsBloc {
  // Properties
  List<Person> _debtors = [];
  List<Debt> _debts = [];
  final _debtorsController = BehaviorSubject<List<Person>>();
  final _debtsController = BehaviorSubject<List<Debt>>();
  final _resumeController = BehaviorSubject<Resume>();
  final DebtorsRepository _repository = DebtorsRepositoryImpl();

  // Getters
  Stream<List<Person>> get debtorsStream => _debtorsController.stream;
  Stream<List<Debt>> get debtsStream => _debtsController.stream;
  Stream<Resume> get resumeStream => _resumeController.stream;

  /// Get all debtors
  Future<void> getDebtors() async {
    _debtors = await _repository.getDebtors();
    _debtors.sort((a, b) => b.total.compareTo(a.total));
    _debtorsController.sink.add(_debtors);
  }

  /// Get all debts
  Future<void> getDebts() async {
    _debts = await _repository.getDebts();
    _debtsController.sink.add(_debts);
  }

  /// Get debts for corresponding debtor
  Future<void> getDebtsByDebtor(Person debtor) async {
    _debts = await _repository.getDebtsForDebtor(debtor);
    _debts.sort((a, b) => b.date.compareTo(a.date));
    _debtsController.sink.add(_debts);
  }

  /// Add debtor
  Future<void> addDebtor(Person debtor) async {
    await _repository.addDebtor(debtor);
    await getDebtors();
  }

  /// Add debt
  Future<void> addDebt(Debt debt, Person debtor) async {
    await _repository.addDebt(debt);
    debtor.total += debt.value;
    await _repository.updateDebtor(debtor);
    await getDebtsByDebtor(debtor);
    await getDebtors();
  }

  /// Update debt
  Future<void> updateDebt(Debt debt, Person debtor) async {
    await _repository.updateDebt(debt);
    final debts = await _repository.getDebtsForDebtor(debtor);
    double totalDebt = 0.0;
    for (final d in debts) {
      totalDebt += d.value;
    }
    debtor.total = totalDebt;
    await _repository.updateDebtor(debtor);
    await getDebtsByDebtor(debtor);
    await getDebtors();
  }

  Future<void> updateDebtor(Person debtor) async {
    await _repository.updateDebtor(debtor);
    await getDebtors();
  }

  /// Update debtor's total debt
  Future<void> updateResume() async {
    final resume = Resume();
    final debtors = await _repository.getDebtors();
    for (final d in debtors) {
      if (d.total > 0) resume.people++;
      resume.value += d.total;
    }
    _resumeController.sink.add(resume);
  }

  /// Delete debt
  Future<void> deleteDebt(Debt debt, Person debtor) async {
    await _repository.deleteDebt(debt);
    debtor.total -= debt.value;
    await _repository.updateDebtor(debtor);
    await getDebtors();
  }

  /// Delete debtor and corresponding debts
  Future<void> deleteDebtor(Person debtor) async {
    await _repository.deleteDebtor(debtor);
    await _repository.deleteAllDebtsForDebtor(debtor);
    getDebtors();
    updateResume();
  }

  /// Dispose
  void dispose() {
    _debtorsController?.close();
    _debtsController?.close();
    _resumeController?.close();
  }
}
