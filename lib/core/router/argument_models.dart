import 'package:flutter/foundation.dart';
import 'package:debts_app/core/data/models/index.dart';

class AddDebtArguments {
  final Debt debt;
  final Debtor debtor;

  AddDebtArguments({
    this.debt,
    @required this.debtor,
  });
}

class AddLoanArguments {
  final Loan loan;
  final Lender lender;

  AddLoanArguments({
    this.loan,
    @required this.lender,
  });
}
