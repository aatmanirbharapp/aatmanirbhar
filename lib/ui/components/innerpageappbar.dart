import 'dart:ui' as ui;

import 'package:atamnirbharapp/ui/datasearch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InnerSliverAppBar extends StatefulWidget {
  const InnerSliverAppBar({
    Key key,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  _InnerSliverAppBarState createState() => _InnerSliverAppBarState();
}

class _InnerSliverAppBarState extends State<InnerSliverAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.orange[100],
      leading: IconButton(
        iconSize: 10,
        icon: Image.asset("assets/images/sidebar.png"),
        onPressed: () {
          widget._scaffoldKey.currentState.openDrawer();
        },
      ),
      pinned: true,
      floating: true,
      centerTitle: true,
      title: Text(
        "header".tr().toString(),
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
        PopupMenuButton(
          captureInheritedThemes: false,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: "en",
              child: Text('English'),
            ),
            const PopupMenuItem<String>(
              value: "hi",
              child: Text('Hindi'),
            ),
          ],
          onSelected: (String result) {
            print(result);
            this.setState(() {
              context.locale = Locale(result);
            });
          },
          icon: Icon(Icons.language,color: Colors.black,),
        ),
      ],
    );
  }
}
