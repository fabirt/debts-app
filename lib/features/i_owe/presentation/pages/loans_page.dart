import 'package:flutter/material.dart';

import 'package:debts_app/core/domain/entities/debt.dart';
import 'package:debts_app/core/domain/entities/person.dart';
import 'package:debts_app/core/locale/app_localizations.dart';
import 'package:debts_app/core/presentation/bloc/inherited_bloc.dart';
import 'package:debts_app/core/presentation/widgets/widgets.dart';
import 'package:debts_app/core/router/router.dart';

class LoansPage extends StatefulWidget {
  final Person lender;

  const LoansPage({@required this.lender});

  @override
  _LoansPageState createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bloc = InheritedBloc.of(context);
    bloc.lendersBloc.getLoansByLender(widget.lender);
  }

  void _addLoan(BuildContext context) {
    Router.navigator.pushNamed(
      Routes.addLoan,
      arguments: AddDebtArguments(person: widget.lender),
    );
  }

  void _updateLoan(BuildContext context, Debt loan) {
    Router.navigator.pushNamed(
      Routes.addLoan,
      arguments: AddDebtArguments(person: widget.lender, debt: loan),
    );
  }

  Future<void> _deleteLoan(Debt loan, InheritedBloc bloc) async {
    await bloc.lendersBloc.deleteLoan(loan, widget.lender);
    await bloc.lendersBloc.getLoansByLender(widget.lender);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlueHeaderContainer(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              titleText: widget.lender.name,
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
      builder: (BuildContext context, AsyncSnapshot<List<Debt>> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data.isEmpty) return _buildEmptyState(context);
          return ListView.builder(
            itemCount: data.length,
            padding: const EdgeInsets.only(bottom: 110.0, top: 20.0),
            itemBuilder: (BuildContext context, int i) {
              return DebtCard(
                debt: data[i],
                onTap: (Debt l) => _updateLoan(context, l),
                onDismissed: (Debt l) => _deleteLoan(l, bloc),
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
