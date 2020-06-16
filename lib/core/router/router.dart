import 'package:flutter/material.dart';

import 'package:debts_app/core/domain/entities/person.dart';
import 'package:debts_app/core/presentation/widgets/widgets.dart';
import 'package:debts_app/core/router/argument_models.dart';
import 'package:debts_app/core/router/routes.dart';
import 'package:debts_app/features/i_owe/presentation/pages/add_lender_page.dart';
import 'package:debts_app/features/i_owe/presentation/pages/add_loan_page.dart';
import 'package:debts_app/features/i_owe/presentation/pages/lenders_page.dart';
import 'package:debts_app/features/i_owe/presentation/pages/loans_page.dart';
import 'package:debts_app/features/owe_me/presentation/pages/add_debt_page.dart';
import 'package:debts_app/features/owe_me/presentation/pages/add_debtor_page.dart';
import 'package:debts_app/features/owe_me/presentation/pages/debtor_debts_page.dart';
import 'package:debts_app/features/owe_me/presentation/pages/debtors_page.dart';
import 'package:debts_app/features/resume/presentation/pages/resume_page.dart';

export 'package:debts_app/core/router/argument_models.dart';
export 'package:debts_app/core/router/routes.dart';

/// App navigation router.
class Router {
  static final _navigatorKey = GlobalKey<NavigatorState>();

  /// App root Navigator key.
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// Global App Navigator.
  static NavigatorState get navigator => navigatorKey.currentState;

  /// Generate the corresponding route when app is navigated
  /// to a named route.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.resume:
        return FadeRoute(page: ResumePage());

      case Routes.debtors:
        return FadeRoute(page: DebtorsPage());

      case Routes.addDebtor:
        Person person;
        if (args is Person) {
          person = args;
        }
        return FadeRoute(page: AddDebtorPage(person: person));

      case Routes.singleDebtor:
        if (args is Person) {
          return FadeRoute(page: DebtorDebtsPage(debtor: args));
        }
        return _errorRoute(
          settings.name,
          _invalidArgmuents(args.runtimeType, Person),
        );

      case Routes.addDebt:
        if (args is AddDebtArguments) {
          return FadeRoute(
            page: AddDebtPage(
              debt: args.debt,
              debtor: args.person,
            ),
          );
        }
        return _errorRoute(
          settings.name,
          _invalidArgmuents(args.runtimeType, AddDebtArguments),
        );

      case Routes.lenders:
        return FadeRoute(page: LendersPage());

      case Routes.addLender:
        Person person;
        if (args is Person) {
          person = args;
        }
        return FadeRoute(page: AddLenderPage(person: person));

      case Routes.singleLender:
        if (args is Person) {
          return FadeRoute(page: LoansPage(lender: args));
        }
        return _errorRoute(
          settings.name,
          _invalidArgmuents(args.runtimeType, Person),
        );

      case Routes.addLoan:
        if (args is AddDebtArguments) {
          return FadeRoute(
            page: AddLoanPage(loan: args.debt, lender: args.person),
          );
        }
        return _errorRoute(
          settings.name,
          _invalidArgmuents(args.runtimeType, AddDebtArguments),
        );

      default:
        return _errorRoute(
          settings.name,
          'No route defined for ${settings.name}',
        );
    }
  }

  static String _invalidArgmuents(Type received, Type expected) {
    return 'Invalid argument of type $received, expected $expected';
  }

  static Route<dynamic> _errorRoute(String routeName, String message) {
    return MaterialPageRoute<dynamic>(
      builder: (context) => RoutingErrorWidget(
        title: 'Routing error :p',
        subtitle: 'Trying to navigate to $routeName',
        message: message,
      ),
    );
  }
}
