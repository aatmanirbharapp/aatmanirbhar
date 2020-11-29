import 'package:flutter/material.dart';

class CommanWidgets {
  Widget getCircularProgressIndicator() {
    return SizedBox(
        height: 20,
        width: 20,
        child: Center(
          heightFactor: 10,
          widthFactor: 10,
          child: CircularProgressIndicator(
            value: 5,
          ),
        ));
  }
}
