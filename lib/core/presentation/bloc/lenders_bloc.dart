import 'package:rxdart/rxdart.dart';

import 'package:debts_app/core/domain/entities/debt.dart';
import 'package:debts_app/core/domain/entities/person.dart';
import 'package:debts_app/core/domain/entities/resume.dart';
import 'package:debts_app/core/data/repositories/lenders_repository_impl.dart';
import 'package:debts_app/core/domain/repositories/lenders_repository.dart';

class LendersBloc {
  // Properties
  List<Person> _lenders = [];
  List<Debt> _loans = [];
  final _lendersController = BehaviorSubject<List<Person>>();
  final _loansController = BehaviorSubject<List<Debt>>();
  final _resumeController = BehaviorSubject<Resume>();
  final LendersRepository _repository = LendersRepositoryImpl();

  // Getters
  Stream<List<Person>> get lendersStream => _lendersController.stream;
  Stream<List<Debt>> get loansStream => _loansController.stream;
  Stream<Resume> get resumeStream => _resumeController.stream;

  /// Get all lenders
  Future<void> getLenders() async {
    _lenders = await _repository.getLenders();
    _lenders.sort((a, b) => b.total.compareTo(a.total));
    _lendersController.sink.add(_lenders);
  }

  /// Get loans for corresponding lender
  Future<void> getLoansByLender(Person lender) async {
    _loans = await _repository.getLoansForLender(lender);
    _loans.sort((a, b) => b.date.compareTo(a.date));
    _loansController.sink.add(_loans);
  }

  /// Add lender
  Future<void> addLender(Person lender) async {
    await _repository.addLender(lender);
    await getLenders();
  }

  /// Add loan
  Future<void> addLoan(Debt loan, Person lender) async {
    await _repository.addLoan(loan);
    final newPerson = lender.copyWith(
      total: lender.total + loan.value,
    );
    await _repository.updateLender(newPerson);
    await getLoansByLender(lender);
    await getLenders();
  }

  /// Update loan
  Future<void> updateLoan(Debt loan, Person lender) async {
    await _repository.updateLoan(loan);
    final loans = await _repository.getLoansForLender(lender);
    double totalLoan = 0.0;
    for (final l in loans) {
      totalLoan += l.value;
    }
    final newPerson = lender.copyWith(total: totalLoan);
    await _repository.updateLender(newPerson);
    await getLoansByLender(lender);
    await getLenders();
  }

  Future<void> updateLender(Person lender) async {
    await _repository.updateLender(lender);
    await getLenders();
  }

  /// Update lenders total loan
  Future<void> updateResume() async {
    final resume = Resume();
    final lenders = await _repository.getLenders();
    for (final d in lenders) {
      if (d.total > 0) resume.people++;
      resume.value += d.total;
    }
    _resumeController.sink.add(resume);
  }

  /// Delete loan
  Future<void> deleteLoan(Debt loan, Person lender) async {
    await _repository.deleteLoan(loan);
    final newPerson = lender.copyWith(
      total: lender.total - loan.value,
    );
    await _repository.updateLender(newPerson);
    await getLenders();
  }

  /// Delete lender and corresponding loans
  Future<void> deleteLender(Person lender) async {
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
