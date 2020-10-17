
import 'package:atamnirbharapp/fancyfab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privacy",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green[200],
      ),
      backgroundColor: Colors.orange[200],
      floatingActionButton: FancyFab()
    );
      }
      }