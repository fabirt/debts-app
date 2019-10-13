import 'package:flutter/material.dart';
import 'package:debts_app/src/widgets/index.dart';
import 'package:debts_app/src/utils/index.dart' as utils;

class DebtorCard extends StatelessWidget {
  final String name;
  final String value;
  final Function onTap;

  DebtorCard({this.name, this.value, this.onTap});

  void _onTap() {
    // onTap();
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
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: utils.Colors.athensGray,
            child: Text('FD', style: TextStyle(color: utils.Colors.towerGray, fontWeight: FontWeight.w700),),
          ),
          SizedBox(width: 12.0,),
          Expanded(
            child: Text('Fabian Diartt ', style: TextStyle( fontWeight: FontWeight.w500),),
          ),
          SizedBox(width: 12.0,),
          Text('\$ 200.000', style: TextStyle( fontWeight: FontWeight.w700),),
        ],
      ),
    );
  }
}
