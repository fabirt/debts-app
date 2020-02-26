import 'package:flutter/foundation.dart';
import 'package:debts_app/core/data/models/index.dart';

class AddDebtArguments {
  final DebtModel debt;
  final DebtorModel debtor;

  AddDebtArguments({
    this.debt,
    @required this.debtor,
  });
}

class AddLoanArguments {
  final LoanModel loan;
  final LenderModel lender;

  AddLoanArguments({
    this.loan,
    @required this.lender,
  });
}
