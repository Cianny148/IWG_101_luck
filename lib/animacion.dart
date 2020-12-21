import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:flutter/widgets.dart';

class Circle_prog extends StatefulWidget {
  const Circle_prog(
    Map map, {
    Key key,
    CircleAvatar child,
  }) : super(key: key);
  @override
  _Circle_progState createState() => _Circle_progState();
}

class _Circle_progState extends State<Circle_prog>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 6000));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 6.28).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(300, 300),
          painter: CustomCircle(Colors.blue, 1.1 + _animation.value),
        ),
        CustomPaint(
          size: Size(300, 300),
          painter: CustomCircle(Colors.yellow[600], 1.5 * _animation.value),
        ),
        CustomPaint(
          size: Size(300, 300),
          painter: CustomCircle(Colors.pink, 2 * _animation.value),
        ),
        CustomPaint(
          size: Size(300, 300),
          painter: CustomCircle(Colors.green[600], 2.5 * _animation.value),
        )
      ],
    );
  }
}

class CustomCircle extends CustomPainter {
  double right = 200;
  double bottom = 200;
  Color color;
  double rad;

  CustomCircle(Color color, double rad) {
    this.color = color;
    this.rad = rad;
  }
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, right, bottom);
    final startAngle = math.pi * rad;
    final sweepAngle = math.pi / 3;
    final useCenter = false;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 15;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
