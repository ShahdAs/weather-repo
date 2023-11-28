import 'package:flutter/material.dart';
import '../globals.dart';

enum Warn{black, green ,orange}

class WarningWidget extends StatefulWidget {
  Warn error;
  String content;
  bool start = false;


  WarningWidget({required this.start, required this.error, required this.content, Key? key})
      : super(key: key);

  @override
  State<WarningWidget> createState() => _WarningWidgetState();
}

class _WarningWidgetState extends State<WarningWidget> {
  bool visible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void show() {
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        visible = true;
        widget.start = false;
      });
    });
    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        visible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if(widget.start == true){
      show();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedOpacity(
          duration: const Duration(seconds: 1),
          opacity: visible ? 1 : 0,
          child: SizedBox(
            width: size.width,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: visible ? 35 : 1,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(0)),
                  color: widget.error == Warn.black
                      ? const Color.fromRGBO(1, 1, 1, 0.5)
                      : widget.error == Warn.green ? const Color.fromRGBO(
                      42, 211, 24, 0.5019607843137255):
                  const Color.fromRGBO(143, 78, 11, 0.5019607843137255),
                ),
                child: Center(
                  child: Text(
                    widget.content,
                    style: font15l,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
