import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/presentation/globals.dart';
import 'package:provider/provider.dart';

import '../../bloc/bloc.dart';
import '../../provider/myProvider.dart';

class AutoCompleteWidget extends StatefulWidget {
  const AutoCompleteWidget({Key? key}) : super(key: key);

  @override
  State<AutoCompleteWidget> createState() => _AutoCompleteWidgetState();
}

class _AutoCompleteWidgetState extends State<AutoCompleteWidget> {
  late TextEditingController textEditingController;
  OverlayEntry? overlayEntry;
  final layerLink = LayerLink();
  final focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController = TextEditingController();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // return showOverlay(data);
    });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        // showOverlay(data);
      } else {
        hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  void showOverlay(List<String> list) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return Positioned(
          width: size.width -12,
          height: list.length <=3 ? list.length * 60 : 200 ,
          child: CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 8),
              child: buildOverlay(list)));
    });

    overlay.insert(overlayEntry!);
  }

  void showOverlay_circle() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return Positioned(
          width: size.width -12,
          child: CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 8),
              child: const SizedBox(
                  height: 50, width: 50, child: CircularProgressIndicator())));
    });

    overlay.insert(overlayEntry!);
  }

  void hideOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MyProvider>(context, listen: false).autoCompleteValueA =
        textEditingController.text;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: Material(
          color: Colors.transparent,
          child: BlocProvider(
              create: (context) {
                return HomeBloc()..add(AutoCom(data: ""));
              },
              child: BlocConsumer<HomeBloc, HomeState>(
                builder: (context, state) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Column(
                      children: [
                        CompositedTransformTarget(
                          link: layerLink,
                          child: TextField(
                            focusNode: focusNode,
                            controller: textEditingController,
                            onChanged: (s) {
                              context
                                  .read<HomeBloc>()
                                  .add(AutoCom(data: s.toLowerCase()));
                            },
                            onSubmitted: (String x) {
                              Provider.of<MyProvider>(context, listen: false)
                                  .autoCompleteValue = x;
                              Provider.of<MyProvider>(context, listen: false)
                                  .changeAutoCompleteValue();
                              focusNode.unfocus();
                              hideOverlay();
                            },
                            decoration: const InputDecoration(
                              helperStyle: font20,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: Color.fromRGBO(62, 63, 106, 1),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(15))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                                fillColor: Color.fromRGBO(46, 51, 90, 1),
                                filled: true,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromRGBO(62, 63, 130, 1),
                                ))),
                            style: font20,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                listener: (BuildContext context, HomeState state) {
                  if (state is LoadedStateAutoComplete) {
                    hideOverlay();
                    return showOverlay(state.data);
                  } else {
                    hideOverlay();
                    return showOverlay_circle();
                  }
                },
              ))),
    );
  }

  Widget buildOverlay(List<String> list) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Color.fromRGBO(72, 49, 157, 0.5), width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),

          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  final String element = list.elementAt(index).toLowerCase();
                  return GestureDetector(
                      // create: (_)=> MyProvider(),
                      child: Container(
                        height: 60,

                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          gradient: navGrad1,
                          border: Border(bottom: BorderSide(color: Colors.white38))
                        ),
                        child: ListTile(
                    title: Text(element, style: font20,),
                    onTap: () {
                        textEditingController.text = element;
                    },
                  ),
                      )
                      // onTap: () {
                      //   onSelected(element);
                      // },

                      );
                }),
          ),
        ),
      ),
    );
  }
}
