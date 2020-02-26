import 'package:rxdart/rxdart.dart';
import 'package:debts_app/core/data/data_sources/db_data_source.dart';
import 'package:debts_app/core/data/models/index.dart';

class DebtorsBloc {
  // Properties
  List<DebtorModel> _debtors = [];
  List<DebtModel> _debts = [];
  final _debtorsController = BehaviorSubject<List<DebtorModel>>();
  final _debtsController = BehaviorSubject<List<DebtModel>>();
  final _resumeController = BehaviorSubject<DebtorsResumeModel>();
  final DbDataSource _dbDataSource = DbDataSourceImpl();

  // Getters
  Stream<List<DebtorModel>> get debtorsStream => _debtorsController.stream;
  Stream<List<DebtModel>> get debtsStream => _debtsController.stream;
  Stream<DebtorsResumeModel> get resumeStream => _resumeController.stream;

  /// Get all debtors
  Future<void> getDebtors() async {
    _debtors = await _dbDataSource.getDebtors();
    _debtors.sort((a, b) => b.debt.compareTo(a.debt));
    _debtorsController.sink.add(_debtors);
  }
  
  /// Get all debts
  Future<void> getDebts() async {
    _debts = await _dbDataSource.getDebts();
    _debtsController.sink.add(_debts);
  }
  
  /// Get debts for corresponding debtor
  Future<void> getDebtsByDebtor(DebtorModel debtor) async {
    _debts = await _dbDataSource.getDebtsByDebtor(debtor);
    _debts.sort((a, b) => b.date.compareTo(a.date));
    _debtsController.sink.add(_debts);
  }

  /// Add debtor
  Future<void> addDebtor(DebtorModel debtor) async {
    await _dbDataSource.addDebtor(debtor);
    await getDebtors();
  }
  
  /// Add debt
  Future<void> addDebt(DebtModel debt, DebtorModel debtor) async {
    await _dbDataSource.addDebt(debt);
    debtor.debt += debt.value;
    await _dbDataSource.updateDebtor(debtor);
    await getDebtors();
  }
  
  /// Update debt
  Future<void> updateDebt(DebtModel debt, DebtorModel debtor) async {
    await _dbDataSource.updateDebt(debt);
    final debts = await _dbDataSource.getDebtsByDebtor(debtor);
    double totalDebt = 0.0;
    for (final d in debts) {
      totalDebt += d.value;
    }
    debtor.debt = totalDebt;
    await _dbDataSource.updateDebtor(debtor);
    await getDebtors();
  }

  /// Update debtor's total debt
  Future<void> updateResume() async {
    final resume = DebtorsResumeModel();
    final debtors = await _dbDataSource.getDebtors();
    for (final d in debtors) {
      if (d.debt > 0) resume.people++;
      resume.value += d.debt;
    }
    _resumeController.sink.add(resume);
  }

  /// Delete debt
  Future<void> deleteDebt(DebtModel debt, DebtorModel debtor) async {
    await _dbDataSource.deleteDebt(debt);
    debtor.debt -= debt.value;
    await _dbDataSource.updateDebtor(debtor);
    await getDebtors();
  }

  /// Delete debtor and corresponding debts
  Future<void> deleteDebtor(DebtorModel debtor) async {
    await _dbDataSource.deleteDebtor(debtor);
    await _dbDataSource.deleteAllDebtsByDebtor(debtor);
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