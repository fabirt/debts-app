import 'package:rxdart/rxdart.dart';
import 'package:debts_app/src/models/index.dart';
import 'package:debts_app/src/providers/index.dart';

class DebtorsBloc {

  // Properties
  List<Debtor> _debtors = new List();
  List<Debt> _debts = new List();
  final _debtorsController = new BehaviorSubject<List<Debtor>>();
  final _debtsController = new BehaviorSubject<List<Debt>>();

  // Getters
  Stream<List<Debtor>> get debtorsStream => _debtorsController.stream;
  Stream<List<Debt>> get debtsStream => _debtsController.stream;

  // Get all debtors
  void getDebtors() async {
    _debtors = await DBProvider.db.getDebtors();
    _debtorsController.sink.add(_debtors);
  }
  
  // Get all debts
  void getDebts() async {
    _debts = await DBProvider.db.getDebts();
    _debtsController.sink.add(_debts);
  }
  
  // Get debts for corresponding debtor
  void getDebtsByDebtor(Debtor debtor) async {
    _debts = await DBProvider.db.getDebtsByDebtor(debtor);
    _debtsController.sink.add(_debts);
  }

  // Add debtor
  Future<void> addDebtor(Debtor debtor) async {
    final res = await DBProvider.db.addDeptor(debtor);
    getDebtors();
  }
  
  // Add debt
  Future<void> addDebt(Debt debt, Debtor debtor) async {
    final res = await DBProvider.db.addDept(debt);
    debtor.debt += debt.value;
    await DBProvider.db.updateDebtor(debtor);
    getDebtors();
  }


  // Dispose
  dispose() {
    _debtorsController?.close();
    _debtsController?.close();
  } 
  
}