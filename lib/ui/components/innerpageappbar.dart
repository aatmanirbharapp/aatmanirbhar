import 'package:atamnirbharapp/ui/datasearch.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class InnerSliverAppBar extends StatelessWidget {
  const InnerSliverAppBar({
    Key key,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.orange[100],
      leading: IconButton(
        iconSize: 10,
        icon: Image.asset("assets/images/indian_flag_icon.png"),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      pinned: true,
      floating: true,
      centerTitle: true,
      title: Text(
        "Aatmanirbhar",
        textAlign: TextAlign.center,
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
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          color: Colors.black,
          onPressed: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => DataSearch()));
          },
        ),
        IconButton(
          icon: Image.asset("assets/images/MakeInIndiaLogo.png"),
          iconSize: 50,
          onPressed: () {},
        ),
      ],
    );
  }
}
