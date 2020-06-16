import 'package:rxdart/rxdart.dart';
import 'package:debts_app/core/data/models/index.dart';
import 'package:debts_app/core/data/repositories/lenders_repository_impl.dart';
import 'package:debts_app/core/domain/repositories/lenders_repository.dart';

class LendersBloc {
  // Properties
  List<LenderModel> _lenders = [];
  List<LoanModel> _loans = [];
  final _lendersController = BehaviorSubject<List<LenderModel>>();
  final _loansController = BehaviorSubject<List<LoanModel>>();
  final _resumeController = BehaviorSubject<DebtorsResumeModel>();
  final LendersRepository _repository = LendersRepositoryImpl();

  // Getters
  Stream<List<LenderModel>> get lendersStream => _lendersController.stream;
  Stream<List<LoanModel>> get loansStream => _loansController.stream;
  Stream<DebtorsResumeModel> get resumeStream => _resumeController.stream;

  /// Get all lenders
  Future<void> getLenders() async {
    _lenders = await _repository.getLenders();
    _lenders.sort((a, b) => b.loan.compareTo(a.loan));
    _lendersController.sink.add(_lenders);
  }

  /// Get loans for corresponding lender
  Future<void> getLoansByLender(LenderModel lender) async {
    _loans = await _repository.getLoansForLender(lender);
    _loans.sort((a, b) => b.date.compareTo(a.date));
    _loansController.sink.add(_loans);
  }

  /// Add lender
  Future<void> addLender(LenderModel lender) async {
    await _repository.addLender(lender);
    await getLenders();
  }

  /// Add loan
  Future<void> addLoan(LoanModel loan, LenderModel lender) async {
    await _repository.addLoan(loan);
    lender.loan += loan.value;
    await _repository.updateLender(lender);
    await getLoansByLender(lender);
    await getLenders();
  }

  /// Update loan
  Future<void> updateLoan(LoanModel loan, LenderModel lender) async {
    await _repository.updateLoan(loan);
    final loans = await _repository.getLoansForLender(lender);
    double totalLoan = 0.0;
    for (final l in loans) {
      totalLoan += l.value;
    }
    lender.loan = totalLoan;
    await _repository.updateLender(lender);
    await getLoansByLender(lender);
    await getLenders();
  }

  /// Update lenders total loan
  Future<void> updateResume() async {
    final resume = DebtorsResumeModel();
    final lenders = await _repository.getLenders();
    for (final d in lenders) {
      if (d.loan > 0) resume.people++;
      resume.value += d.loan;
    }
    _resumeController.sink.add(resume);
  }

  /// Delete loan
  Future<void> deleteLoan(LoanModel loan, LenderModel lender) async {
    await _repository.deleteLoan(loan);
    lender.loan -= loan.value;
    await _repository.updateLender(lender);
    await getLenders();
  }

  /// Delete lender and corresponding loans
  Future<void> deleteLender(LenderModel lender) async {
    await _repository.deleteLender(lender);
    await _repository.deleteAllLoansForLender(lender);
    getLenders();
    updateResume();
  }

  /// Dispose
  void dispose() {
    _lendersController?.close();
    _loansController?.close();
    _resumeController?.close();
  }
}
