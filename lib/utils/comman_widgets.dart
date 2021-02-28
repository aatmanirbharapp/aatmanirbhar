import 'package:flutter/material.dart';

class CommanWidgets {
  Widget getCircularProgressIndicator(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          backgroundColor: Colors.orangeAccent,
          strokeWidth: 5,
        ),
      ),
    );
  }
}
