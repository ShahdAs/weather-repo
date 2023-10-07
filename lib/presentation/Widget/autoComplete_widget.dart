import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/presentation/globals.dart';
import 'package:shimmer/shimmer.dart';
import '../../bloc/bloc.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showOverlay(null, true);
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

  void showOverlay(List<String>? list, bool isCircle) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return Positioned(
          width: size.width - 12,
          height: isCircle
              ? 200
              : list!.length <= 3
                  ? list.length * 60
                  : 200,
          child: CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 8),
              child: isCircle
                  ? buildOverlay(null, true)
                  : buildOverlay(list, false)));
    });

    overlay.insert(overlayEntry!);
  }

  void hideOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Material(
          color: Colors.transparent,
          child: BlocConsumer<HomeBloc, HomeState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
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
                          if (s != null) {
                            context
                                .read<HomeBloc>()
                                .add(AutoCom(data: s.toLowerCase()));
                            if (state.autoComplete.isSuccess()) {
                              context.read<HomeBloc>()
                                ..add(GetMyCurrentLocation(data: s))
                                ..add(GetForecast(data: s));
                            }
                          }
                          setState(() {});
                        },
                        onSubmitted: null
                        //     (String x) {
                        //   // Provider.of<MyProvider>(context, listen: false)
                        //   //     .autoCompleteValueA = x;
                        //   focusNode.unfocus();
                        //   hideOverlay();
                        // }
                        ,
                        decoration: const InputDecoration(
                            helperStyle: font20,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.5,
                                  color: Color.fromRGBO(62, 63, 106, 1),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
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
              if (state.autoComplete.isSuccess()) {
                print("iscalled");
                hideOverlay();
                showOverlay(state.autoComplete.data, false);
              } else if(state.autoComplete.isLoading()){
                hideOverlay();
                showOverlay(null, true);
              } else{hideOverlay();}
            },
          )),
    );
  }

  Widget buildOverlay(List<String>? list, bool isCircle) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: isCircle
              ? 200
              : list!.length <= 3
                  ? list.length * 60
                  : 200,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                  color: const Color.fromRGBO(72, 49, 157, 0.5), width: 1.5),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: isCircle ? 3 : list!.length,
              itemBuilder: (BuildContext context, int index) {
                final String element =
                    isCircle ? "j" : list!.elementAt(index).toLowerCase();
                return Container(
                  height: 60,
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                  gradient: navGrad1,
                  border:
                      Border(bottom: BorderSide(color: Colors.white38))),
                  child: ListTile(
                title: isCircle
                    ? SizedBox(
                        height: 20,
                        width: 200,
                        child: Shimmer.fromColors(
                          baseColor: Colors.white12,
                          highlightColor: Colors.white60,
                          child: Container(
                            height: 10,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ))
                    : Text(
                        element,
                        style: font20,
                      ),
                onTap: () {
                  textEditingController.text = isCircle ? "" : element;
                  hideOverlay();
                },
                  ),
                );
              }),
        ),
      ),
    );
  }
}
