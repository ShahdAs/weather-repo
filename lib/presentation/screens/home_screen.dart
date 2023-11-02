import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/presentation/Widget/autoComplete_widget.dart';
import 'package:project/presentation/Widget/getForecastBottom.dart';
import 'package:project/presentation/screens/searchedRegion_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/bloc.dart';
import '../Widget/bottomSheet_widget.dart';
import '../globals.dart';

var myForecastVar = myForecastVarbloc;

class HomePage extends StatefulWidget {
  HomePage({super.key});

  HomePage._();

  static Page<void> page() => MaterialPage<void>(child: HomePage._());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color color1 = Colors.black26;

  final Color color2 = Colors.white38;

  late Gradient gradient = button1G;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.getExtent.isSuccess()
            // && state.myForecast.isSuccess() &&
            // state.myCurrent.isSuccess()
            ) {
          // var myCurrentVar = state.myCurrent.data;
          // var myForecastVar = state.myForecast.data;

          double extant = state.getExtent.data;
          double percent = (extant - 0.4) * 100 / 42;
          bool percentBool = percent > 0.6 ? true : false;

          List<Widget> cOrR = [
            AnimatedDefaultTextStyle(
              duration: const Duration(seconds: 2),
              style: percentBool ? font20l : fontBig,
              child: Text("${(myForecastVar.currentModel.temp_c.toString())}°"),
            ),
            AnimatedOpacity(
              opacity: percentBool ? 1 : 0,
              duration: const Duration(seconds: 2),
              child: const Text(
                "|",
                style: font20l,
              ),
            ),
            Text(myForecastVar.currentModel.condition.text, style: font20l),
          ];

          List<Widget> topData = [
            Text(myForecastVar.locationModel.name.toString(), style: font34),
            AnimatedSwitcher(
              duration: const Duration(seconds: 2),
              child: percentBool
                  ? Column(
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String? data = prefs.getString('forecast');
                            },
                            child: const Text('get pref')),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: cOrR,
                        )
                      ],
                    )
                  : Column(
                      children: cOrR,
                    ),
            ),
            AnimatedOpacity(
              opacity: percentBool ? 0 : 1,
              duration: const Duration(seconds: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      "H:${myForecastVar.forecastModel[0].day.maxtemp_c.toString()}°",
                      style: font20b),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                      "L:${myForecastVar.forecastModel[0].day.mintemp_c.toString()}°",
                      style: font20b)
                ],
              ),
            ),
          ];

          return Scaffold(
              backgroundColor: const Color.fromRGBO(69, 39, 139, 1),
              body: SizedBox(
                height: size.height,
                width: size.width,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: size.height,
                      width: size.width,
                      decoration: const BoxDecoration(
                        gradient: backGroundGrad,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: percent * size.height,
                      child: Container(
                          height: size.height,
                          width: size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage(
                                  "assets/images/background.jpg"),
                              opacity: 1 - percent,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: null),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(seconds: 2),
                      top: percentBool
                          ? (size.width * 20 / 100) - 10
                          : (size.width * 20 / 100) - 40,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: topData),
                    ),
                    Positioned(
                      bottom: 50 + percent * size.height,
                      left: 0,
                      child: Container(
                          width: (size.width),
                          height: (size.height - 312),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  const AssetImage("assets/images/house.png"),
                              fit: BoxFit.fitWidth,
                              opacity: 1 - percent,
                            ),
                          ),
                          child: null),
                    ),
                    const BottomSheetWidget(),
                    Positioned(
                      bottom: (-percent) * size.height,
                      left: 0,
                      child: SizedBox(
                        width: size.width,
                        height: 80,
                        child: CustomPaint(
                          painter: CustomPaint1(),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: (-percent * 3) * size.height,
                      left: 0,
                      child: SizedBox(
                        width: size.width,
                        height: 80,
                        child: CustomPaint(
                          painter: CustomPaint2(),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          bottom: 8 + (-percent * 3) * size.height,
                          left: size.width / 2 - 31,
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
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
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
                          bottom: 11 + (-percent * 3) * size.height,
                          left: size.width / 2 - 28,
                          child: Container(
                            height: 58,
                            width: 58,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              gradient: gradient,
                            ),
                            child: IconButton(
                              iconSize: 44,
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) =>
                                      _buildPopupDialog(context),
                                );
                                setState(() {
                                  gradient = button2G;
                                });
                                await Future.delayed(
                                  const Duration(seconds: 1),
                                );
                                setState(() {
                                  gradient = button1G;
                                });
                              },
                              icon: const Icon(Icons.add_rounded),
                              color: const Color.fromRGBO(72, 49, 159, 1),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 11 + (-percent * 3) * size.height,
                            left: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              width: size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.settings),
                                    color: Colors.white60,
                                    iconSize: 30,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/searchedRegion_screen');
                                    },
                                    icon: const Icon(Icons.list),
                                    color: Colors.white60,
                                    iconSize: 30,
                                  ),
                                ],
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ));
        }
        return Container(
          child: null,
        );
      },
      listener: (context, state) {
        if (state.myForecast.isSuccess()) {
          myForecastVar = state.myForecast.data;
        }
      },
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return Dialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50))),
    // title: const Text('Add Another Region:', style: font20,),
    // backgroundColor:const  Color.fromRGBO(62, 63, 106, 0.95),
    child: Container(
      decoration: const BoxDecoration(
          gradient: backGroundGrad,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SizedBox(
        height: 223,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Text(
                    "Enter your Region:",
                    style: font20b,
                  ),
                ),
              ],
            ),
            const AutoCompleteWidget(),
            getForecastBottom(true),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close", style: font20l)),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
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
