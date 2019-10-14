import 'package:flutter/material.dart';
import 'package:debts_app/src/models/index.dart';
import 'package:debts_app/src/utils/index.dart' as utils;

class LoanCard extends StatelessWidget {
  final Loan loan;
  final Function(Loan loan) onDismissed;

  LoanCard({this.loan, this.onDismissed});

  void _onTap() {
  }

  void _onDismissed(DismissDirection direction) {
    onDismissed(loan);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: _onDismissed,
        direction: DismissDirection.endToStart,
        dismissThresholds: {DismissDirection.startToEnd: 200.0},
        background: _buildDismissibleBackground(),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0.0, 6.0),
                blurRadius: 6.0,
                spreadRadius: 4.0,
                color: Color.fromRGBO(0, 0, 0, 0.03),
              ),
            ],
          ),
          child: Material(
            color: utils.Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: null,
              child: _buildContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDismissibleBackground() {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.symmetric(horizontal: 26.0, vertical: 5.0),
      child: Icon(Icons.delete, color: utils.Colors.towerGray,),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildRow(),
          SizedBox(height: 10.0,),
          Text(
            loan.description,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildRow() {
    final value = utils.formatCurrency(loan.value);
    return Row(
      children: <Widget>[
        _buildDate(),
        Expanded(
          child: SizedBox(),
        ),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _buildDate() {
    final formattedDate = utils.formatDate(DateTime.parse(loan.date));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Color(0x0F154FC2),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        formattedDate,
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
          color: utils.Colors.denim,
        ),
      ),
    );
  }
}
