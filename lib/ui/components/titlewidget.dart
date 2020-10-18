import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Be Desi",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 22,
                foreground: Paint()
                  ..shader = ui.Gradient.linear(
                    const Offset(60, 100),
                    const Offset(50, 35),
                    <Color>[
                      Colors.orange,
                      Colors.green,
                    ],
                  )),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Support Swadesi!",
            textAlign: TextAlign.right,
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 22,
                foreground: Paint()
                  ..shader = ui.Gradient.linear(
                    const Offset(60, 100),
                    const Offset(50, 35),
                    <Color>[
                      Colors.orange,
                      Colors.green,
                    ],
                  )),
          ),
        ),
      ],
    );
  }
}
