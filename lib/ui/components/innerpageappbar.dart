import 'package:atamnirbharapp/ui/components/searchbarwidget.dart';
import 'package:flutter/material.dart';

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
        icon: Icon(
          Icons.menu,
          color: Colors.red,
        ),
        onPressed: () {
          print("your menu action here");
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      pinned: true,
      floating: true,
      title: SearchBarWidget(),
      actions: [
        IconButton(
          icon: Image.asset("assets/images/MakeInIndiaLogo.png"),
          iconSize: 50,
          onPressed: () {},
        ),
      ],
    );
  }
}
