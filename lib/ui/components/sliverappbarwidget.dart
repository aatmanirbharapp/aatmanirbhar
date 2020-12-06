import 'package:atamnirbharapp/ui/components/searchbarwidget.dart';
import 'package:atamnirbharapp/ui/components/titlewidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
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
        icon: Image.asset("assets/images/indian_flag_icon.png"),
        onPressed: () {
          print("your menu action here");
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      pinned: true,
      floating: true,
      title: TitleWidget(),
      bottom: PreferredSize(
          child: SearchBarWidget(), preferredSize: const Size.fromHeight(60)),
      actions: [
        ClipOval(
          child: Image.asset(
            "assets/images/Final_AatmNirbhar_logo.png",
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
