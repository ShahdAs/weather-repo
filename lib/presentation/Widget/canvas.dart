import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../globals.dart';

class TabBarPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromRGBO(72, 49, 157, 0.2)
      ..style = PaintingStyle.fill;
    Paint paint2 = Paint()
      ..color = const Color.fromRGBO(255, 255, 255, 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    Path path = Path()..moveTo(0, 0);
    path.arcToPoint(Offset(size.width, 0),
        radius: const Radius.circular(650), clockwise: false);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: 0,
    );
    paint.shader = navGrad1.createShader(rect);
    canvas.drawPath(path, paint);
    canvas.drawPath(path, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SubtractPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromRGBO(69, 39, 139, 1)
      ..style = PaintingStyle.fill;
    Paint paint2 = Paint()
      ..color = const Color.fromRGBO(255, 255, 255, 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    Path path = Path()..moveTo(size.width / 2 - 120, size.height);
    path.quadraticBezierTo(
        size.width / 2 - 60, size.height, size.width / 2 - 50, size.height / 3);
    path.quadraticBezierTo(size.width / 2 - 45, -3, size.width / 2, 0);
    path.quadraticBezierTo(
        size.width / 2 + 45, -3, size.width / 2 + 50, size.height / 3);
    path.quadraticBezierTo(
        size.width / 2 + 60, size.height, size.width / 2 + 120, size.height);
    path.close();
    Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: 0,
    );
    paint.shader = navGrad2.createShader(rect);
    canvas.drawPath(path, paint);
    canvas.drawPath(path, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


class RegionContainerPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromRGBO(69, 39, 139, 1)
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
          const Offset(0, 0), Offset(size.width, size.height), [
        const Color.fromRGBO(89, 54, 180, 1),
        const Color.fromRGBO(54, 32, 132, 1),
      ], [
        0.1,
        0.9
      ]);
    Path path = Path()..moveTo(0, 0 + size.width / 7);
    double x = size.width / 13;
    var r = const Radius.circular(30);
    path
      ..lineTo(0, size.height - x)
      ..arcToPoint(Offset(0 + x, size.height), radius: r, clockwise: false)
      ..lineTo(size.width - x, size.height)
      ..arcToPoint(Offset(size.width, size.height - x),
          radius: r, clockwise: false)
      ..lineTo(size.width, size.height * 3 / 8 + x)
      ..arcToPoint(Offset(size.width - x, size.height * 3 / 8),
          radius: const Radius.circular(35), clockwise: false)
      ..lineTo(0 + x, 0)
      ..arcToPoint(Offset(0, 0 + x), radius: r, clockwise: false);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


class SunrisePaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint2 = Paint()
      ..shader = ui.Gradient.linear(
          const Offset(0, 0), Offset(size.width, size.height), [
        const Color.fromRGBO(46, 51, 90, 1),
        Colors.white54,
        const Color.fromRGBO(46, 51, 90, 1),
      ], [
        0.2,
        0.5,
        0.8
      ])
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    Path path = Path()..moveTo(0, size.height);
    path.quadraticBezierTo(size.width * 1 / 9, size.height, size.width * 2 / 9,
        size.height * 3 / 7);
    path.quadraticBezierTo(size.width * 3 / 9, -3, size.width / 2, -2.5);
    path.quadraticBezierTo(
        size.width * 6 / 9, -3, size.width * 7 / 9, size.height * 3 / 7);
    path.quadraticBezierTo(
        size.width * 8 / 9, size.height, size.width, size.height);
    // path.close();
    canvas.drawPath(path, paint2);

    Paint paintC = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 3;
    Paint paintCShadow = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 3
      ..shader = ui.Gradient.radial(
          Offset(size.width * 2 / 9, size.height * 3 / 7),
          10,
          [Colors.white54, Colors.transparent],
          [0.5, 1]);
    canvas.drawCircle(
        Offset(size.width * 2 / 9, size.height * 3 / 7), 20, paintCShadow);
    canvas.drawCircle(
        Offset(size.width * 2 / 9, size.height * 3 / 7), 5, paintC);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
