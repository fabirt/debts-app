import 'package:flutter/material.dart';
import 'package:debts_app/core/presentation/bloc/debtors_bloc.dart';
import 'package:debts_app/core/presentation/bloc/lenders_bloc.dart';

class InheritedBloc extends InheritedWidget {
  static InheritedBloc _instance;

  final DebtorsBloc debtorsBloc = DebtorsBloc();
  final LendersBloc lendersBloc = LendersBloc();

  factory InheritedBloc({Key key, Widget child}) {
    return _instance ??= InheritedBloc._internal(key: key, child: child);
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
