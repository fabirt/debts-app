import 'package:flutter/material.dart';
import 'package:debts_app/src/locale/app_localizations.dart';
import 'package:debts_app/src/bloc/inherited_bloc.dart';
import 'package:debts_app/src/models/index.dart';
import 'package:debts_app/src/widgets/index.dart';
import 'package:debts_app/src/pages/add_loan/add_loan_page.dart';
import 'package:debts_app/src/pages/loans/widgets/loan_card.dart';
// import 'package:debts_app/src/utils/index.dart' as utils;

class LoansPage extends StatelessWidget {
  final Lender lender;

  const LoansPage({@required this.lender});

  void _addLoan(BuildContext context) {
    Navigator.push(context, FadeRoute(page: AddLoanPage(lender: lender)));
  }

  void _updateLoan(BuildContext context, Loan loan) {
    Navigator.push(
      context,
      FadeRoute(
        page: AddLoanPage(
          loan: loan,
          lender: lender,
        ),
      ),
    );
  }

  Future<void> _deleteLoan(Loan loan, InheritedBloc bloc) async {
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
      builder: (BuildContext context, AsyncSnapshot<List<Loan>> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data.isEmpty) return _buildEmptyState(context);
          return ListView.builder(
            itemCount: data.length,
            padding: const EdgeInsets.only(bottom: 110.0, top: 20.0),
            itemBuilder: (BuildContext context, int i) {
              return LoanCard(
                loan: data[i],
                onTap: (Loan l) => _updateLoan(context, l),
                onDismissed: (Loan l) => _deleteLoan(l, bloc),
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
