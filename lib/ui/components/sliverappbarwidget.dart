import 'package:atamnirbharapp/ui/components/searchbarwidget.dart';
import 'package:atamnirbharapp/ui/components/titlewidget.dart';
import 'package:atamnirbharapp/ui/userauthentication/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  CustomSliverAppBar({
    Key key,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.orange[100],
      leading: IconButton(
        icon: Image.asset("assets/images/indian_flag_icon.png"),
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
        _auth.currentUser != null
            ? Padding(
                padding: EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  backgroundImage: _auth.currentUser.photoURL != null
                      ? NetworkImage(
                          _auth.currentUser.photoURL,
                        )
                      : Icon(Icons.face),
                ))
            : Padding(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  icon: Icon(Icons.face),
                  color: Color.fromARGB(255, 0, 0, 136),
                ))
      ],
    );
  }
}
