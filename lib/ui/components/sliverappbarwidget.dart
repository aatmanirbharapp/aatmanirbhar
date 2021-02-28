import 'package:atamnirbharapp/ui/components/searchbarwidget.dart';
import 'package:atamnirbharapp/ui/components/titlewidget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  CustomSliverAppBar({
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
        icon: Image.asset("assets/images/sidebar.png"),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      centerTitle: true,
      pinned: true,
      floating: false,
      title: TitleWidget(),
      bottom: PreferredSize(
          child: SearchBarWidget(), preferredSize: const Size.fromHeight(60)),
      actions: [
        IconButton(
          icon: Image.asset("assets/images/Final_Aatmanirbhar_Logo.png"),
          iconSize: 70,
          onPressed: () {},
        ),
      ],
    );
  }
}
