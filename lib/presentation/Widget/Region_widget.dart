import 'package:country_picker/country_picker.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:project/presentation/Widget/searchedRegion.dart';
import 'dart:ui' as ui;

import '../globals.dart';

class RegionWidget extends StatelessWidget {
  final SearchedRegion region;
  const RegionWidget({Key? key, required this.region}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      width: size.width,
      height: size.width / 2,
      child: Stack(
        children: [
          Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: size.width / 2,
                width: size.width ,
                color: Colors.transparent,
                child: CustomPaint(
                  painter: CustomPaint1(),
                ),
              )),
          Positioned(
              left: 30,
              top: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(region.name, style: font34b,),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Text("lat: ${region.lat.toString()}", style: font15l,),
                  const SizedBox(width: 7,),
                  Text("lon: ${region.lon.toString()}", style: font15l,)
                ],
              ),
              Text("${region.region}, ${region.country}", style: font15,)
            ],
          )),
          Positioned(
              right: 50,
              top: 20,
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                      blurRadius: 20,
                      spreadRadius: 0,
                      offset: Offset(10, 10),
                    ),
                  ]
                ),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: Flag.fromString(Country.tryParse(region.country)!.countryCode,height:90, width: 120,)),
              ))
        ],
      ),
    );
  }
}

class CustomPaint1 extends CustomPainter {
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
