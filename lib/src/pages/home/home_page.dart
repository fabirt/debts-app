import 'package:flutter/material.dart';
import 'package:debts_app/src/widgets/index.dart';
import 'package:debts_app/src/utils/index.dart' as utils;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(),
          SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.05,
                ),
                DebtResumeCard(
                  theme: DebtCardTheme.light,
                  title: 'Me deben',
                  value: '\$ 200.000',
                  label: '1 persona',
                  onPressed: () {},
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                DebtResumeCard(
                  theme: DebtCardTheme.dark,
                  title: 'Debo',
                  value: '\$ 0.00',
                  label: 'a 0 personas',
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 30.0),
        child: AddButton(
          onPressed: (){},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
