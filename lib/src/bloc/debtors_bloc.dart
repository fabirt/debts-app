import 'package:rxdart/rxdart.dart';
import 'package:debts_app/src/models/index.dart';
import 'package:debts_app/src/providers/index.dart';

class DebtorsBloc {

  List<Debtor> _debtors = new List();
  List<Debt> _debts = new List();
  final _debtorsController = new BehaviorSubject<List<Debtor>>();
  final _debtsController = new BehaviorSubject<List<Debt>>();

  Stream<List<Debtor>> get debtorsStream => _debtorsController.stream;
  Stream<List<Debt>> get debtsStream => _debtsController.stream;

  void getDebtors() async {
    _debtors = await DBProvider.db.getDebtors();
    _debtorsController.sink.add(_debtors);
  }
  
  void getDebts() async {
    _debts = await DBProvider.db.getDebts();
    _debtsController.sink.add(_debts);
  }
  
  void getDebtsByDebtor(Debtor debtor) async {
    _debts = await DBProvider.db.getDebtsByDebtor(debtor);
    _debtsController.sink.add(_debts);
  }

  Future<void> addDebtor(Debtor debtor) async {
    final res = await DBProvider.db.addDeptor(debtor);
    getDebtors();
  }
  
  Future<void> addDebt(Debt debt) async {
    final res = await DBProvider.db.addDept(debt);
  }

  dispose() {
    _debtorsController?.close();
    _debtsController?.close();
  } 
  
}