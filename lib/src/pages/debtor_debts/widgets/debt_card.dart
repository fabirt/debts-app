import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:debts_app/src/models/index.dart';
import 'package:debts_app/src/utils/index.dart' as utils;

class DebtCard extends StatelessWidget {
  

  DebtCard();

  void _onTap() {
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
          onTap: _onTap,
          child: _buildContent(),
        ),
      ),
    );
  }

  Container _buildContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        children: <Widget>[
          _buildRow(),
          SizedBox(height: 10.0,),
          Text(
            'Commodo ipsum dolore dolor ullamco mollit aliquip voluptate in adipisicing magna magna.',
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildRow() {
    return Row(
      children: <Widget>[
        _buildDate(),
        Expanded(
          child: SizedBox(),
        ),
        Text(
          '200.000',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _buildDate() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Color(0x0F154FC2),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        '10-12-2019',
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
          color: utils.Colors.denim,
        ),
      ),
    );
  }
}
