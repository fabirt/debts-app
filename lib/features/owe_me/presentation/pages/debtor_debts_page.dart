import 'package:flutter/material.dart';

import 'package:debts_app/core/domain/entities/debt.dart';
import 'package:debts_app/core/domain/entities/person.dart';
import 'package:debts_app/core/locale/app_localizations.dart';
import 'package:debts_app/core/presentation/bloc/inherited_bloc.dart';
import 'package:debts_app/core/presentation/widgets/widgets.dart';
import 'package:debts_app/core/router/router.dart';
import 'package:debts_app/features/owe_me/presentation/widgets/debt_card.dart';

class DebtorDebtsPage extends StatefulWidget {
  final Person debtor;

  const DebtorDebtsPage({@required this.debtor});

  @override
  _DebtorDebtsPageState createState() => _DebtorDebtsPageState();
}

class _DebtorDebtsPageState extends State<DebtorDebtsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bloc = InheritedBloc.of(context);
    bloc.debtorsBloc.getDebtsByDebtor(widget.debtor);
  }

  void _addDebt(BuildContext context) {
    Router.navigator.pushNamed(
      Routes.addDebt,
      arguments: AddDebtArguments(person: widget.debtor),
    );
  }

  void _updateDebt(BuildContext context, Debt debt) {
    Router.navigator.pushNamed(
      Routes.addDebt,
      arguments: AddDebtArguments(
        person: widget.debtor,
        debt: debt,
      ),
    );
  }

  Future<void> _deleteDebt(Debt debt, InheritedBloc bloc) async {
    await bloc.debtorsBloc.deleteDebt(debt, widget.debtor);
    await bloc.debtorsBloc.getDebtsByDebtor(widget.debtor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GreenHeaderContainer(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              titleText: widget.debtor.name,
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
          onPressed: () => _addDebt(context),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildContent(BuildContext context) {
    final bloc = InheritedBloc.of(context);
    return StreamBuilder(
      stream: bloc.debtorsBloc.debtsStream,
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
                onTap: (Debt d) => _updateDebt(context, d),
                onDismissed: (Debt d) => _deleteDebt(d, bloc),
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
      message: AppLocalizations.of(context).translate('no_debts'),
    );
  }
}
