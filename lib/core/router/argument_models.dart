import 'package:flutter/foundation.dart';
import 'package:debts_app/core/domain/entities/debt.dart';
import 'package:debts_app/core/domain/entities/person.dart';

class AddDebtArguments {
  final Debt debt;
  final Person person;

  AddDebtArguments({
    this.debt,
    @required this.person,
  });
}
