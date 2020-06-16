import 'package:flutter/material.dart';
import 'package:debts_app/core/utils/utils.dart' as utils;

enum DebtCardTheme { light, dark }

class _DebtCardTheme {
  Color valueColor;
  Color labelColor;
  Color iconColor;
  BoxDecoration decoration;

  _DebtCardTheme(DebtCardTheme debtCardTheme) {
    if (debtCardTheme == DebtCardTheme.light) {
      valueColor = utils.Colors.apple;
      labelColor = const Color(0xFF71768C);
      iconColor = utils.Colors.towerGray;
      decoration = BoxDecoration(
        color: utils.Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0.0, 10.0),
            blurRadius: 6.0,
            spreadRadius: 4.0,
            color: Color.fromRGBO(0, 0, 0, 0.07),
          ),
        ],
      );
    } else {
      valueColor = Colors.white;
      labelColor = const Color.fromRGBO(255, 255, 255, 0.5);
      iconColor = const Color.fromRGBO(255, 255, 255, 0.5);
      decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0.0, 10.0),
            blurRadius: 6.0,
            spreadRadius: 4.0,
            color: Color.fromRGBO(0, 0, 0, 0.07),
          ),
        ],
        gradient: const LinearGradient(
          colors: [Color(0xFF7568E5), Color(0xFF5273DE)],
        ),
      );
    }
  }
}

class DebtResumeCard extends StatelessWidget {
  final DebtCardTheme theme;
  final String title;
  final String value;
  final String label;
  final Function onTap;

  const DebtResumeCard({
    this.theme,
    this.title,
    this.value,
    this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = _DebtCardTheme(this.theme);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: <Widget>[
            _buildHeader(),
            const SizedBox(height: 14.0),
            _buildCard(theme)
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: <Widget>[
        const SizedBox(width: 10.0),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 6.0),
        Icon(
          Icons.chevron_right,
          color: Colors.white,
          size: 23.0,
        )
      ],
    );
  }

  Widget _buildCard(_DebtCardTheme theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 26.0),
      decoration: theme.decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: _buildDeptColumn(theme)),
          const SizedBox(width: 10.0),
          _buildIcon(theme),
        ],
      ),
    );
  }

  Widget _buildDeptColumn(_DebtCardTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FittedBox(
          child: Text(
            value,
            style: TextStyle(
              color: theme.valueColor,
              fontSize: 26.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            Icon(
              Icons.person_outline,
              color: theme.labelColor,
              size: 16.0,
            ),
            const SizedBox(width: 7.0),
            Text(
              label,
              style: TextStyle(
                color: theme.labelColor,
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIcon(_DebtCardTheme theme) {
    return Icon(
      Icons.fingerprint,
      color: theme.iconColor,
      size: 50.0,
    );
  }
}
