import 'package:rxdart/rxdart.dart';
import 'package:debts_app/src/models/index.dart';
import 'package:debts_app/src/providers/index.dart';

class DebtorsBloc {

  List<Debtor> _debtors = new List();
  final _debtorsController = new BehaviorSubject<List<Debtor>>();

  Stream<List<Debtor>> get debtorsStream => _debtorsController.stream;

  void getDebtors() async {
    _debtors = await DBProvider.db.getDebtors();
    _debtorsController.sink.add(_debtors);
  }

  Future<void> addDebtor(Debtor debtor) async {
    final res = await DBProvider.db.addDeptor(debtor);
    getDebtors();
  }

  dispose() {
    _debtorsController?.close();
  } 
  
}