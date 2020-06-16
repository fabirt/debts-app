import 'package:flutter/material.dart';

import 'package:debts_app/core/domain/entities/debt.dart';
import 'package:debts_app/core/domain/entities/person.dart';
import 'package:debts_app/core/locale/app_localizations.dart';
import 'package:debts_app/core/presentation/bloc/inherited_bloc.dart';
import 'package:debts_app/core/presentation/widgets/widgets.dart';
import 'package:debts_app/core/router/router.dart';

class DebtorDebtsPage extends StatefulWidget {
  final Person debtor;

  const DebtorDebtsPage({@required this.debtor});

  @override
  _DebtorDebtsPageState createState() => _DebtorDebtsPageState();
}

class _DebtorDebtsPageState extends State<DebtorDebtsPage> {
  Person _debtor;

  @override
  void initState() {
    super.initState();
    _debtor = widget.debtor.copyWith();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bloc = InheritedBloc.of(context);
    bloc.debtorsBloc.getDebtsByDebtor(_debtor);
  }

  Future<void> _addDebt(BuildContext context) async {
    await Router.navigator.pushNamed(
      Routes.addDebt,
      arguments: AddDebtArguments(person: _debtor),
    );
    _debtor = InheritedBloc.of(context).debtorsBloc.getCurrentDebtor(_debtor);
  }

  Future<void> _updateDebt(BuildContext context, Debt debt) async {
    await Router.navigator.pushNamed(
      Routes.addDebt,
      arguments: AddDebtArguments(
        person: _debtor,
        debt: debt,
      ),
    );
    _debtor = InheritedBloc.of(context).debtorsBloc.getCurrentDebtor(_debtor);
  }

  Future<void> _deleteDebt(Debt debt, InheritedBloc bloc) async {
    await bloc.debtorsBloc.deleteDebt(debt, _debtor);
    await bloc.debtorsBloc.getDebtsByDebtor(_debtor);
    _debtor = InheritedBloc.of(context).debtorsBloc.getCurrentDebtor(_debtor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GreenHeaderContainer(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              titleText: _debtor.name,
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
