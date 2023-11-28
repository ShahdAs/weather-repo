import 'package:country_picker/country_picker.dart';import 'package:flag/flag_widget.dart';import 'package:flutter/material.dart';import 'package:flutter_bloc/flutter_bloc.dart';import 'package:project/presentation/Widget/canvas.dart';import 'package:project/presentation/Widget/popupDialog.dart';import 'package:project/presentation/Widget/searchedRegion.dart';import 'package:project/sharedPreference/sharedPreference_save.dart';import '../../bloc/bloc.dart';import '../../sharedPreference/sharedPreference_get.dart';import '../globals.dart';class RegionWidget extends StatelessWidget {  final SearchedRegion region;  const RegionWidget({Key? key, required this.region}) : super(key: key);  @override  Widget build(BuildContext context) {    void update () {      GetPrefs.get().then((List<SearchedRegion> data) {        context.read<HomeBloc>().add(GetSearchedRegion(data: data));        print(data);      });      print('updated;');    }    var size = MediaQuery.of(context).size;    return Container(      color: Colors.transparent,      width: size.width,      height: size.width / 2,      child: Stack(        children: [          Center(              child: Container(            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),            height: size.width / 2,            width: size.width,            color: Colors.transparent,            child: CustomPaint(              painter: RegionContainerPaint(),            ),          )),          Positioned(              left: 30,              top: 60,              child: Column(                mainAxisAlignment: MainAxisAlignment.start,                crossAxisAlignment: CrossAxisAlignment.start,                children: [                  Text(                    region.name,                    style: font34b,                  ),                  const SizedBox(                    height: 20,                  ),                  Row(                    children: [                      Text(                        "lat: ${region.lat.toString()}",                        style: font15l,                      ),                      const SizedBox(                        width: 7,                      ),                      Text(                        "lon: ${region.lon.toString()}",                        style: font15l,                      )                    ],                  ),                  Text(                    "${region.region}, ${region.country}",                    style: font15,                  )                ],              )),          Positioned(              bottom: 20,              right: 20,              child: IconButton(                  onPressed: () {                    showDialog(                      context: context,                      barrierDismissible: true,                      builder: (BuildContext context) => PopupDialog(                        actionName: 'Delete',                        action: () {                          SavePrefs(givedData: region, save: Save.delete);                          Future.delayed(const Duration(seconds: 1),(){                          update();                          Navigator.of(context).pop();                          });                        },                        mainWidget: Column(                          children: [                            const Row(                              mainAxisAlignment: MainAxisAlignment.start,                              children: [                                Padding(                                  padding: EdgeInsets.only(left: 14.0),                                  child: Text(                                    "Do you want to delete this item?",                                    style: font20b,                                  ),                                ),                              ],                            ),                            const SizedBox(                              height: 10,                            ),                            Row(                              mainAxisAlignment: MainAxisAlignment.start,                              children: [                                Padding(                                  padding: const EdgeInsets.only(left: 14.0),                                  child: Text(                                    "${region.name}, ${region.region}, ${region.country}",                                    style: font20,                                  ),                                ),                              ],                            )                          ],                        ),                      ),                    );                  },                  icon: const Icon(                    Icons.delete,                    color: Colors.white54,                    size: 30,                  ))),          Positioned(              right: 50,              top: 20,              child: Container(                decoration: const BoxDecoration(boxShadow: [                  BoxShadow(                    color: Color.fromRGBO(0, 0, 0, 0.4),                    blurRadius: 20,                    spreadRadius: 0,                    offset: Offset(10, 10),                  ),                ]),                child: ClipRRect(                    borderRadius: const BorderRadius.all(Radius.circular(25)),                    child: Country.tryParse(region.country) != null                        ? Flag.fromString(                            Country.tryParse(region.country)!.countryCode,                            height: 90,                            width: 120,                          )                        : Container(child: null)),              ))        ],      ),    );  }}