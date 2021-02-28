import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckInternet {
  StreamSubscription<DataConnectionStatus> listener;
  var InternetStatus = "Unknown";
  var contentmessage = "Unknown";

  void _showSnackbar(String title, String content, BuildContext context) {
    if (title.contains("Disconnected"))
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: new Text("Alert.."),
                content: new Text(content),
                actions: <Widget>[
                  new FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: new Text("Close"))
                ]);
          });
  }

  checkConnection(BuildContext context) async {
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          InternetStatus = "Connected";
          contentmessage = "Connected to the Internet";
          _showSnackbar(InternetStatus, contentmessage, context);
          break;
        case DataConnectionStatus.disconnected:
          InternetStatus = "Disconnected";
          contentmessage = "Please check your internet connection";
          _showSnackbar(InternetStatus, contentmessage, context);
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }
}
