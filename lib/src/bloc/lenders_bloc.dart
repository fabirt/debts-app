import 'package:rxdart/rxdart.dart';
import 'package:debts_app/src/models/index.dart';
import 'package:debts_app/src/providers/index.dart';

class LendersBloc {

  // Properties
  List<Lender> _lenders = new List();
  List<Loan> _loans = new List();
  final _lendersController = new BehaviorSubject<List<Lender>>();
  final _loansController = new BehaviorSubject<List<Loan>>();
  final _resumeController = new BehaviorSubject<DebtorsResume>();

  // Getters
  Stream<List<Lender>> get lendersStream => _lendersController.stream;
  Stream<List<Loan>> get loansStream => _loansController.stream;
  Stream<DebtorsResume> get resumeStream => _resumeController.stream;

  // Get all lenders
  Future<void> getLenders() async {
    _lenders = await DBProvider.db.getLenders();
    _lenders.sort((a, b) => b.loan.compareTo(a.loan));
    _lendersController.sink.add(_lenders);
  }
  
  // Get loans for corresponding lender
  Future<void> getLoansByLender(Lender lender) async {
    _loans = await DBProvider.db.getLoansByLender(lender);
    _loans.sort((a, b) => b.date.compareTo(a.date));
    _loansController.sink.add(_loans);
  }

  // Add lender
  Future<void> addLender(Lender lender) async {
    await DBProvider.db.addLender(lender);
    await getLenders();
  }
  
  // Add loan
  Future<void> addLoan(Loan loan, Lender lender) async {
    await DBProvider.db.addLoan(loan);
    lender.loan += loan.value;
    await DBProvider.db.updateLender(lender);
    await getLenders();
  }

  // Update lenders total loan
  Future<void> updateResume() async {
    final resume = DebtorsResume();
    final lenders = await DBProvider.db.getLenders();
    lenders.forEach((d) {
      if (d.loan > 0) resume.people++;
      resume.value += d.loan;
    });
    _resumeController.sink.add(resume);
  }

  // Delete loan
  Future<void> deleteLoan(Loan loan, Lender lender) async {
    await DBProvider.db.deleteLoan(loan);
    lender.loan -= loan.value;
    await DBProvider.db.updateLender(lender);
    await getLenders();
  }

  // Delete lender and corresponding loans
  Future<void> deleteLender(Lender lender) async {
    await DBProvider.db.deleteLender(lender);
    await DBProvider.db.deleteAllLoansByLender(lender);
    getLenders();
    updateResume();
  }


  // Dispose
  dispose() {
    _lendersController?.close();
    _loansController?.close();
    _resumeController?.close();
  } 
  
}