import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project/presentation/globals.dart';
import 'dart:ui' as ui;
import '../../bloc/bloc.dart';

class CurrentDetailWidget extends StatelessWidget {
  const CurrentDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        var size = MediaQuery.of(context).size;
        if (state.myForecast.isSuccess() &&
            state.getExtent.isSuccess() &&
            state.theTimeIndex.isSuccess()) {
          double extant = state.getExtent.data;
          double percent = (extant - 0.4) * 100 / 42;
          bool percentBool = percent > 0.6 ? true : false;
          int dayNow = state.theTimeIndex.data[1];
          return AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: percentBool ? 1 : 0,
            child: SizedBox(
              height: size.height - 386,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _EditedContainer(
                      height: 150,
                      width: size.width - 36,
                      titleIcon: Icons.air,
                      titleText: 'AIR QUALITY',
                      mainChild: LayoutBuilder(builder: (context, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              state.myForecast.data.currentModel.airQuality
                                  .gbdefraindex == null ? 'NOT FOUND!' : airQuality(
                                state.myForecast.data.currentModel.airQuality
                                    .gbdefraindex,
                              ),
                              style: font20b,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            gradientContainer(
                                state.myForecast.data.currentModel.airQuality
                                    .gbdefraindex ?? 0,
                                constraints.maxWidth)
                          ],
                        );
                      }),
                      // commentText: 'see more',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _EditedContainer(
                          titleText: 'UV INDEX',
                          titleIcon: Icons.sunny,
                          bodyText:
                              state.myForecast.data.currentModel.uv.toString(),
                          mainChild:
                              LayoutBuilder(builder: (context, constraints) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  uvString(
                                      state.myForecast.data.currentModel.uv),
                                  style: font20b,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                gradientContainer(
                                    state.myForecast.data.currentModel.uv,
                                    constraints.maxWidth)
                              ],
                            );
                          }),
                        ),
                        _EditedContainer(
                          titleText: 'SUNRISE',
                          titleIcon: Icons.sunny_snowing,
                          bodyText: state
                              .myForecast.data.forecastModel[dayNow].astro.sunrise,
                          mainChild: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 40,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return SizedBox(
                                      height: constraints.maxHeight,
                                      width: constraints.maxWidth,
                                      child: CustomPaint(
                                        painter: CustomPaint2(),
                                      ));
                                }),
                              ),
                            ],
                          ),
                          commentText:
                              'Sunset: ${state.myForecast.data.forecastModel[dayNow].astro.sunset}',
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _EditedContainer(
                          titleText: 'WIND',
                          titleIcon: Icons.wind_power,
                          bodyText:
                              '${state.myForecast.data.currentModel.wind_kph.toString()} Km per Hour',
                          // mainChild:
                          // SizedBox(
                          //   height: 100,
                          //   child: Stack(
                          //     children: [
                          //       LayoutBuilder(builder: (context, constraints) {
                          //         return SizedBox(
                          //             height: constraints.maxHeight,
                          //             width: constraints.maxWidth,
                          //             child: CustomPaint(
                          //               painter: CustomPaint3(),
                          //             )
                          //         );
                          //       }),
                          //       Positioned(
                          //           left: 5,
                          //           bottom: size.height /2,
                          //           child: Text('W' , style: font20l,))
                          //     ],
                          //   ),
                          // ),
                        ),
                        _EditedContainer(
                          titleText: 'RAINFALL',
                          titleIcon: Icons.water_drop,
                          mainChild: Column(
                            children: [
                              Text(
                                "The Chance of Rain this Hour: ${state.myForecast.data.forecastModel[dayNow].hour[int.parse(DateFormat('H').format(DateTime.now()))].chance_of_rain}%",
                                style: font20b,
                              )
                            ],
                          ),
                          commentText:
                              "The Chance of Rain this Day: ${state.myForecast.data.forecastModel[dayNow].day.daily_chance_of_rain}%",
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _EditedContainer(
                          titleText: 'FEELS LIKE',
                          titleIcon: Icons.hot_tub,
                          bodyText:
                              "${state.myForecast.data.currentModel.feelslike_c.toString()}°",
                        ),
                        _EditedContainer(
                          titleText: 'HUMIDITY',
                          titleIcon: Icons.water,
                          bodyText:
                              "${state.myForecast.data.currentModel.humidity.toString()} %",
                          commentText:
                              "The Dew Point is ${state.myForecast.data.forecastModel[dayNow].hour[int.parse(DateFormat('H').format(DateTime.now()))].dewpoint_c} right now",
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _EditedContainer(
                          titleText: 'VISIBILITY',
                          titleIcon: Icons.remove_red_eye,
                          bodyText:
                              '${state.myForecast.data.currentModel.vis_km.toString()} Km',
                        ),
                        _EditedContainer(
                          titleText: 'PRESSURE',
                          titleIcon: Icons.punch_clock,
                          bodyText:
                              "${state.myForecast.data.currentModel.pressure_in.toString()} inch",
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator(color: Colors.white54,);
        }
      },
    );
  }
}

class _EditedContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final IconData titleIcon;
  final String titleText;
  final String? bodyText;
  final Widget? mainChild;
  final String? commentText;

  const _EditedContainer(
      {this.width,
      this.height,
      required this.titleIcon,
      required this.titleText,
      this.bodyText,
      this.mainChild,
      this.commentText});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(6),
      height: height ?? (size.width - 48) / 2,
      width: width ?? (size.width - 48) / 2,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(37, 36, 76, 4),
          border: Border.all(color: Colors.white24),
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                titleIcon,
                color: Colors.white54,
                size: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                titleText,
                style: font15l,
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          bodyText == null
              ? const SizedBox(
                  height: 0,
                  child: null,
                )
              : Text(
                  bodyText!,
                  style: font30,
                ),
          mainChild ??
              const SizedBox(
                height: 0,
                child: null,
              ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commentText == null
                    ? const SizedBox(
                        height: 0,
                        child: null,
                      )
                    : Text(
                        commentText!,
                        style: font15,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}

String airQuality(int data) {
  if (data >= 0 && data < 4) {
    return '$data-Low Health Risk';
  } else if (data >= 4 && data < 7) {
    return '$data-Moderate Health Risk';
  } else if (data >= 7 && data < 11) {
    return '$data-Height Health Risk';
  } else {
    return '$data-Very Height Health Risk';
  }
}

String uvString(double data) {
  if (data >= 0 && data < 3) {
    return 'Low';
  } else if (data >= 3 && data < 6) {
    return 'Moderate';
  } else if (data >= 6 && data < 8) {
    return 'Height';
  } else if (data >= 8 && data < 10) {
    return 'Very Height';
  } else {
    return 'Extreme';
  }
}

Widget gradientContainer(var data, double width) {
  return Container(
      height: 5,
      width: width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.indigo, Colors.purpleAccent, Colors.red],
              stops: [0.1, 0.5, 1],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: data / 13 * width,
              child: Container(
                height: 5,
                width: 5,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: null,
              ))
        ],
      ));
}

class CustomPaint2 extends CustomPainter {
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

class CustomPaint3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    Paint paintC = Paint()
      ..color = Colors.white54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 3, paintC);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
