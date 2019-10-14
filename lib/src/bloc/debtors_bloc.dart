import 'package:rxdart/rxdart.dart';
import 'package:debts_app/src/models/index.dart';
import 'package:debts_app/src/providers/index.dart';

class DebtorsBloc {

  // Properties
  List<Debtor> _debtors = new List();
  List<Debt> _debts = new List();
  final _debtorsController = new BehaviorSubject<List<Debtor>>();
  final _debtsController = new BehaviorSubject<List<Debt>>();
  final _resumeController = new BehaviorSubject<DebtorsResume>();

  // Getters
  Stream<List<Debtor>> get debtorsStream => _debtorsController.stream;
  Stream<List<Debt>> get debtsStream => _debtsController.stream;
  Stream<DebtorsResume> get resumeStream => _resumeController.stream;

  // Get all debtors
  Future<void> getDebtors() async {
    _debtors = await DBProvider.db.getDebtors();
    _debtors.sort((a, b) => b.debt.compareTo(a.debt));
    _debtorsController.sink.add(_debtors);
  }
  
  // Get all debts
  Future<void> getDebts() async {
    _debts = await DBProvider.db.getDebts();
    _debtsController.sink.add(_debts);
  }
  
  // Get debts for corresponding debtor
  Future<void> getDebtsByDebtor(Debtor debtor) async {
    _debts = await DBProvider.db.getDebtsByDebtor(debtor);
    _debts.sort((a, b) => b.date.compareTo(a.date));
    _debtsController.sink.add(_debts);
  }

  // Add debtor
  Future<void> addDebtor(Debtor debtor) async {
    final res = await DBProvider.db.addDebtor(debtor);
    await getDebtors();
  }
  
  // Add debt
  Future<void> addDebt(Debt debt, Debtor debtor) async {
    final res = await DBProvider.db.addDebt(debt);
    debtor.debt += debt.value;
    await DBProvider.db.updateDebtor(debtor);
    await getDebtors();
  }

  // Update debtors total debt
  Future<void> updateResume() async {
    final resume = DebtorsResume();
    final debtors = await DBProvider.db.getDebtors();
    debtors.forEach((d) {
      if (d.debt > 0) resume.people++;
      resume.value += d.debt;
    });
    _resumeController.sink.add(resume);
  }

  // Delete debt
  Future<void> deleteDebt(Debt debt, Debtor debtor) async {
    final res = await DBProvider.db.deleteDebt(debt);
    debtor.debt -= debt.value;
    await DBProvider.db.updateDebtor(debtor);
    await getDebtors();
  }


  // Dispose
  dispose() {
    _debtorsController?.close();
    _debtsController?.close();
    _resumeController?.close();
  } 
  
}