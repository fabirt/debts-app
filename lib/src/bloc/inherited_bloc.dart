import 'package:flutter/material.dart';
import 'package:debts_app/src/bloc/debtors_bloc.dart';
import 'package:debts_app/src/bloc/lenders_bloc.dart';

class InheritedBloc extends InheritedWidget {
  static InheritedBloc _instance;

  final DebtorsBloc debtorsBloc = new DebtorsBloc();
  final LendersBloc lendersBloc = new LendersBloc();

  factory InheritedBloc({Key key, Widget child}) {
    if (_instance == null) {
      _instance = new InheritedBloc._internal(key: key, child: child);
    }
    return _instance;
  }

  InheritedBloc._internal({Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static InheritedBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedBloc>();
  }
}
