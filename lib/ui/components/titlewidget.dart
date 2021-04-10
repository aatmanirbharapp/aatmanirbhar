import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "home_heading1".tr().toString(),
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
        Text(
          "\n"+ "home_heading2".tr().toString(),
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
      ],
    );
  }
}
