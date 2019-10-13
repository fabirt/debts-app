import 'dart:math';

import 'package:flutter/material.dart';
import 'package:debts_app/src/utils/index.dart' as utils;


class Background extends StatelessWidget {
  final Animation<double> scaleAnimation;

  Background({
    this.scaleAnimation
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomPaint(
          painter: _GreenPainter(),
          child: FractionallySizedBox(
            widthFactor: 1.0,
            heightFactor: 1.0,
          ),
        ),
        Transform.scale(
          scale: scaleAnimation.value,
          child: CustomPaint(
            painter: _BluePainter(),
            child: FractionallySizedBox(
              widthFactor: 1.0,
              heightFactor: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}


class _GreenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.lineTo(0.0, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width, 0.0);

    paint.style = PaintingStyle.fill;
    paint.shader = LinearGradient(
      begin: FractionalOffset(0.3, 0.5),
          end: FractionalOffset(1.0, 1.0),
      colors: [ Color(0xFF51F27D), Color(0xFF00D3A5) ]
    ).createShader(Rect.fromCenter(width: size.width, height: size.height, center: Offset(0.0, 0.0)));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
  
}

class _BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.moveTo(0.0, size.height * 0.28);

    path.quadraticBezierTo(size.width/2, size.height * 0.16, size.width, size.height * 0.28);
    path.lineTo(size.width, size.height * 0.64);
    path.quadraticBezierTo(size.width/2, size.height * 0.76, 0.0, size.height * 0.64);

    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 20.0;
    paint.shader = LinearGradient(
      begin: FractionalOffset(0.6, 0.5),
          end: FractionalOffset(-0.2, 1.0),
      colors: [ Color(0xFF3C8BD9), Color(0xFF3E2E92) ]
    ).createShader(Rect.fromCenter(width: size.width, height: size.height, center: Offset(0.0, 0.0)));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
  
}