import 'package:atamnirbharapp/fancyfab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
      ),
      body: SafeArea(
        bottom: true,
        top: true,
        child: SingleChildScrollView(

          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.red
            ),
          )
          ))
    ,
      floatingActionButton: FancyFab()
    );
  }
}