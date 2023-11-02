import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/presentation/globals.dart';
import 'package:shimmer/shimmer.dart';
import '../../bloc/bloc.dart';
import 'TextFieldStyled_widget.dart';

late TextEditingController textEditingController;

class AutoCompleteWidget extends StatefulWidget {
  const AutoCompleteWidget({Key? key}) : super(key: key);

  @override
  State<AutoCompleteWidget> createState() => _AutoCompleteWidgetState();
}

class _AutoCompleteWidgetState extends State<AutoCompleteWidget> {
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
          width: size.width - 16,
          height: isCircle
              ? 150
              : list!.length <= 3
                  ? list.length * 50
                  : 180,
          child: CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height - 7),
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
                      child: TextFieldStyled(
                        hintText: "Enter your region",
                        focusNode: focusNode,
                        controller: textEditingController,
                        onChanged: (s) {
                          if (s != null) {
                            context
                                .read<HomeBloc>()
                                .add(AutoCom(data: s.toLowerCase()));
                          }
                          setState(() {});
                        },
                        onSubmitted: (String value) {
                        },
                      )
                    ),
                  ],
                ),
              );
            },
            listener: (BuildContext context, HomeState state) {
              if (focusNode.hasFocus) {
                if (state.autoComplete.isSuccess()) {
                  hideOverlay();
                  showOverlay(state.autoComplete.data, false);
                } else if (state.autoComplete.isLoading()) {
                  hideOverlay();
                  showOverlay(null, true);
                } else {
                  hideOverlay();
                }
              } else {
                hideOverlay();
              }
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
          margin:  const EdgeInsets.all(0),
          padding: const EdgeInsets.all(0),
          height: isCircle
              ? 180
              : list!.length <= 3
                  ? list.length * 50
                  : 150,
          decoration: BoxDecoration(
              // color: Colors.transparent,
              gradient: backGroundGrad,
              border: Border.all(color: Colors.black12, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color:const  Color.fromRGBO(0, 0, 0, 0.5),
                      blurRadius: 12,
                      spreadRadius: 0,
                      offset: Offset(0, -constraints.maxHeight),
                    ),
                    BoxShadow(
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                      blurRadius: 12,
                      spreadRadius: 0,
                      offset: Offset(constraints.maxWidth , 0),
                    ),
                     BoxShadow(
                      color: const Color.fromRGBO(0, 0, 0, 0.2),
                      blurRadius: 12,
                      spreadRadius: 0,
                      offset: Offset(0, constraints.maxHeight),
                    ),
                    BoxShadow(
                      color: const Color.fromRGBO(0, 0, 0, 0.2),
                      blurRadius: 12,
                      spreadRadius: 0,
                      offset: Offset(-constraints.maxWidth, 0),
                    ),
                  ]),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: isCircle ? 3 : list!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String element =
                          isCircle ? "j" : list!.elementAt(index).toLowerCase();
                      return GestureDetector(
                          child: Container(
                        height: 50,
                        margin:  const EdgeInsets.all(0),
                        padding: const EdgeInsets.all(0),
                        decoration: const BoxDecoration(
                            border:
                                Border(bottom: BorderSide( width: 0.5, color: Colors.white38))),
                        child: ListTile(
                          title: isCircle
                              ? SizedBox(
                                  height: 18,
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
                            // context.read<HomeBloc>()
                            //   ..add(GetMyCurrentLocationRemove())
                            //   ..add(GetForecastRemove());
                            hideOverlay();
                            focusNode.unfocus();
                          },
                        ),
                      )
                          // onTap: () {
                          //   onSelected(element);
                          // },

                          );
                    }),
              );
            }
          ),
        ),
      ),
    );
  }
}
