import 'package:flutter/material.dart';

import 'package:debts_app/core/data/models/index.dart';
import 'package:debts_app/core/locale/app_localizations.dart';
import 'package:debts_app/core/presentation/bloc/inherited_bloc.dart';
import 'package:debts_app/core/presentation/widgets/index.dart';
import 'package:debts_app/core/router/index.dart';
import 'package:debts_app/features/owe_me/presentation/widgets/debt_card.dart';

class DebtorDebtsPage extends StatefulWidget {
  final DebtorModel debtor;

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
      arguments: AddDebtArguments(debtor: widget.debtor),
    );
  }

  void _updateDebt(BuildContext context, DebtModel debt) {
    Router.navigator.pushNamed(
      Routes.addDebt,
      arguments: AddDebtArguments(
        debtor: widget.debtor,
        debt: debt,
      ),
    );
  }

  Future<void> _deleteDebt(DebtModel debt, InheritedBloc bloc) async {
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
      builder: (BuildContext context, AsyncSnapshot<List<DebtModel>> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data.isEmpty) return _buildEmptyState(context);
          return ListView.builder(
            itemCount: data.length,
            padding: const EdgeInsets.only(bottom: 110.0, top: 20.0),
            itemBuilder: (BuildContext context, int i) {
              return DebtCard(
                debt: data[i],
                onTap: (DebtModel d) => _updateDebt(context, d),
                onDismissed: (DebtModel d) => _deleteDebt(d, bloc),
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
