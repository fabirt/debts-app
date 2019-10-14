import 'package:flutter/material.dart';
import 'package:debts_app/src/bloc/inherited_bloc.dart';
import 'package:debts_app/src/models/index.dart';
import 'package:debts_app/src/widgets/index.dart';
import 'package:debts_app/src/pages/add_debt/add_debt_page.dart';
import 'package:debts_app/src/pages/debtor_debts/widgets/debt_card.dart';
import 'package:debts_app/src/utils/index.dart' as utils;


class DebtorDebtsPage extends StatelessWidget {

  final Debtor debtor;

  DebtorDebtsPage({
    @required this.debtor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GreenHeaderContainer(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              titleText: debtor.name,
            ),
            Expanded(
              child: RoundedShadowContainer(
                child: _buildContent(),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 30.0),
        child: AddButton(
          onPressed: () => _addDebt(context),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildContent() {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.only(bottom: 110.0, top: 20.0),
      itemBuilder: (BuildContext context, int i) {
        return DebtCard(
          debt: Debt(date: '10-12-2019', value: 50000, description: 'Tempor do occaecat magna ullamco nostrud incididunt ut proident voluptate.'),
        );
      },
    );
  }

  void _addDebt(BuildContext context) {
    Navigator.push(context, FadeRoute(page: AddDebtPage()));
  }
}