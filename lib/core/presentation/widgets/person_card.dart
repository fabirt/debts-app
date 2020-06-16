import 'package:flutter/material.dart';

import 'package:debts_app/core/domain/entities/person.dart';
import 'package:debts_app/core/utils/utils.dart' as utils;

class PersonCard extends StatelessWidget {
  final Person person;
  final Function(Person) onTap;
  final Function(Person) onDismissed;

  const PersonCard({
    @required this.person,
    this.onTap,
    this.onDismissed,
  });

  void _onTap() {
    onTap(person);
  }

  void _onDismissed(DismissDirection direction) {
    onDismissed(person);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: _onDismissed,
        direction: DismissDirection.endToStart,
        dismissThresholds: const {DismissDirection.startToEnd: 200.0},
        background: _buildDismissibleBackground(),
        child: Container(
          decoration: const BoxDecoration(
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
        ),
      ),
    );
  }

  Widget _buildDismissibleBackground() {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 5.0),
      child: Icon(
        Icons.delete,
        color: utils.Colors.towerGray,
      ),
    );
  }

  Container _buildContent() {
    final debt = utils.formatCurrency(person.total);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: utils.Colors.athensGray,
            child: Text(
              person.getInitials(),
              style: TextStyle(
                color: utils.Colors.towerGray,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              person.name,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 12.0),
          Text(
            debt,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
