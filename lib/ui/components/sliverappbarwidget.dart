import 'package:atamnirbharapp/ui/components/searchbarwidget.dart';
import 'package:atamnirbharapp/ui/components/titlewidget.dart';
import 'package:atamnirbharapp/ui/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';

class CustomSliverAppBar extends StatelessWidget {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      "loggedIn";


  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CustomSliverAppBar({
    Key key,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch =
        sharedPreferences.getBool(PREFERENCES_IS_FIRST_LAUNCH_STRING) ?? true;

    if (isFirstLaunch)
      sharedPreferences.setBool(PREFERENCES_IS_FIRST_LAUNCH_STRING, false);

    return isFirstLaunch;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirstLaunch().then((result) {
        if (result) ShowCaseWidget.of(context).startShowCase([_one,_two]);
      });
    });
    return SliverAppBar(
      backgroundColor: Colors.orange[100],
      leading: Showcase(
        key: _two,
        title: 'Menu',
        description: 'Use menu for login and many more options',
        child: IconButton(
          icon: Image.asset("assets/images/sidebar.png"),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
      centerTitle: true,
      pinned: true,
      floating: false,
      title: TitleWidget(),
      bottom: PreferredSize(
          child: Showcase(
              key: _one,
              title: 'Search here',
              description: 'Please search companies/products here.',
              child: SearchBarWidget()),
          preferredSize: const Size.fromHeight(60)),
      actions: [
        IconButton(
          icon: Image.asset("assets/images/Final_Aatmanirbhar_Logo.png"),
          iconSize: 70,
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MyHomePage()),
              (route) => false),
        ),
      ],
    );
  }
}
