import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bloc.dart';
import '../Widget/bottomSheet_widget.dart';
import '../globals.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  @override
  Widget build(BuildContext context) {
  Global global = Global.getInstance();
    var myCurrentVar =global.myCurrentVar;
    bool isnull = global.isnull();


    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if(state.getExtent.isSuccess()){
          double extant = state.getExtent.data;
          double percent = (extant - 0.4) * 100 / 42;
          bool percentBool = percent > 0.6 ? true : false;
          return Scaffold(
              backgroundColor: const Color.fromRGBO(69, 39, 139, 1),
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        gradient: backGroundGrad,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: percent * MediaQuery.of(context).size.height,
                      child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage("assets/images/background.jpg"),
                              opacity: 1 - percent,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: null),
                    ),
                    SizedBox(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            AnimatedPositioned(
                              duration: const Duration(seconds: 1),
                              top: percentBool ? 80 : 92,
                              child: isnull
                                  ? const CircularProgressIndicator()
                                  : Text(myCurrentVar.temp_c.toString(),
                                  style: font34),
                            ),
                            AnimatedPositioned(
                              duration: const Duration(seconds: 1),
                              left: percentBool
                                  ? MediaQuery.of(context).size.width / 2 - 70
                                  : null,
                              top: 125,
                              child: Row(
                                children: [
                                  AnimatedDefaultTextStyle(
                                    duration: const Duration(seconds: 1),
                                    style: percentBool ? font20l : fontBig,
                                    child: const Text("19°"),
                                  ),
                                  AnimatedOpacity(
                                    opacity: percentBool ? 1 : 0,
                                    duration: const Duration(seconds: 1),
                                    child: const Text(
                                      " |",
                                      style: font20l,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            AnimatedPositioned(
                              duration: const Duration(seconds: 1),
                              top: percentBool ? 125 : 230,
                              left: percentBool
                                  ? MediaQuery.of(context).size.width / 2 - 25
                                  : null,
                              child: const Text("Mostly Clear", style: font20l),
                            ),
                            AnimatedPositioned(
                              duration: const Duration(seconds: 1),
                              top: percentBool ? 140 : 240,
                              child: AnimatedOpacity(
                                opacity: percentBool ? 0 : 1,
                                duration: const Duration(seconds: 1),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text("H:24°", style: font20b),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("L:18°", style: font20b)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                    Positioned(
                      bottom: 50 + percent * MediaQuery.of(context).size.height,
                      left: 0,
                      child: Container(
                          width: (MediaQuery.of(context).size.width),
                          height: (MediaQuery.of(context).size.height - 312),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage("assets/images/house.png"),
                              fit: BoxFit.fitWidth,
                              opacity: 1 - percent,
                            ),
                          ),
                          child: null),
                    ),
                    const BottomSheetWidget(),
                    Positioned(
                      bottom: (-percent) * MediaQuery.of(context).size.height,
                      left: 0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        child: CustomPaint(
                          painter: CustomPaint1(),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: (-percent * 3) * MediaQuery.of(context).size.height,
                      left: 0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        child: CustomPaint(
                          painter: CustomPaint2(),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          bottom:
                          8 + (-percent * 3) * MediaQuery.of(context).size.height,
                          left: MediaQuery.of(context).size.width / 2 - 31,
                          child: Container(
                            height: 64,
                            width: 64,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(0, 0, 0, 0.4),
                                      Color.fromRGBO(255, 255, 255, 0.4)
                                    ],
                                    stops: [
                                      0.2,
                                      1
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.2),
                                    blurRadius: 10,
                                    offset: Offset(4, 4),
                                  ),
                                  BoxShadow(
                                    color: Color.fromRGBO(255, 255, 255, 0.2),
                                    blurRadius: 10,
                                    offset: Offset(-4, -4),
                                  )
                                ]),
                          ),
                        ),
                        Positioned(
                          bottom: 11 +
                              (-percent * 8) * MediaQuery.of(context).size.height,
                          left: MediaQuery.of(context).size.width / 2 - 28,
                          child: Container(
                            height: 58,
                            width: 58,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(255, 255, 255, 0),
                                    Color.fromRGBO(187, 191, 199, 1)
                                  ],
                                  stops: [
                                    0,
                                    1
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                            ),
                            child: IconButton(
                              iconSize: 44,
                              onPressed: () {},
                              icon: const Icon(Icons.add_rounded),
                              color: const Color.fromRGBO(72, 49, 159, 1),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ));
        }
        return Container(child: null,);
      },
    );
  }
}

class CustomPaint1 extends CustomPainter {
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

class CustomPaint2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromRGBO(69, 39, 139, 1)
      ..style = PaintingStyle.fill;
    Paint paint2 = Paint()
      ..color = const Color.fromRGBO(255, 255, 255, 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    Path path = Path()..moveTo(size.width/2 -120, size.height);
    path.quadraticBezierTo(size.width /2 -60, size.height,
        size.width /2-50, size.height /3);
    path.quadraticBezierTo(
        size.width /2 -45, -3, size.width /2, 0);
    path.quadraticBezierTo(size.width /2 + 45, -3,
        size.width /2 + 50, size.height / 3);
    path.quadraticBezierTo(size.width /2 +60, size.height,
        size.width/2 +120, size.height);
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
