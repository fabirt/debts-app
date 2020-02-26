import 'package:flutter/material.dart';

import 'package:debts_app/core/data/models/index.dart';
import 'package:debts_app/core/locale/app_localizations.dart';
import 'package:debts_app/core/presentation/bloc/inherited_bloc.dart';
import 'package:debts_app/core/presentation/widgets/index.dart';
import 'package:debts_app/core/router/index.dart';
import 'package:debts_app/features/i_owe/presentation/widgets/loan_card.dart';

class LoansPage extends StatelessWidget {
  final LenderModel lender;

  const LoansPage({@required this.lender});

  void _addLoan(BuildContext context) {
    Router.navigator.pushNamed(
      Routes.addLoan,
      arguments: AddLoanArguments(lender: lender),
    );
  }

  void _updateLoan(BuildContext context, LoanModel loan) {
    Router.navigator.pushNamed(
      Routes.addLoan,
      arguments: AddLoanArguments(lender: lender, loan: loan),
    );
  }

  Future<void> _deleteLoan(LoanModel loan, InheritedBloc bloc) async {
    await bloc.lendersBloc.deleteLoan(loan, lender);
    await bloc.lendersBloc.getLoansByLender(lender);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = InheritedBloc.of(context);
    bloc.lendersBloc.getLoansByLender(lender);

    return Scaffold(
      body: BlueHeaderContainer(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              titleText: lender.name,
            ),
            Expanded(
              child: RoundedShadowContainer(
                child: _buildContent(context),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 30.0),
        child: AddButton(
          onPressed: () => _addLoan(context),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildContent(BuildContext context) {
    final bloc = InheritedBloc.of(context);
    return StreamBuilder(
      stream: bloc.lendersBloc.loansStream,
      builder: (BuildContext context, AsyncSnapshot<List<LoanModel>> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data.isEmpty) return _buildEmptyState(context);
          return ListView.builder(
            itemCount: data.length,
            padding: const EdgeInsets.only(bottom: 110.0, top: 20.0),
            itemBuilder: (BuildContext context, int i) {
              return LoanCard(
                loan: data[i],
                onTap: (LoanModel l) => _updateLoan(context, l),
                onDismissed: (LoanModel l) => _deleteLoan(l, bloc),
              );
            },
          );
        } else {
          return _buildEmptyState(context);
        }
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return EmptyState(
      icon: Icons.sentiment_satisfied,
      message: AppLocalizations.of(context).translate('no_loans'),
    );
  }
}
