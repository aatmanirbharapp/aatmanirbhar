import 'package:atamnirbharapp/ui/components/footerwidget.dart';
import 'package:atamnirbharapp/ui/components/sliverappbarwidget.dart';
import 'package:atamnirbharapp/ui/drawer.dart';
import 'package:atamnirbharapp/ui/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:share/share.dart';
import 'package:showcaseview/showcase_widget.dart';

class MyHomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerClass(),
      body: ShowCaseWidget(
        onStart: (index, key) {
          //log('onStart: $index, $key');
        },
        onComplete: (index, key) {
          //log('onComplete: $index, $key');
        },
        builder: Builder(
          builder: (context) => SafeArea(
            top: true,
            bottom: true,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/BG_Color.jpeg"),
                fit: BoxFit.cover,
              )),
              child: CustomScrollView(slivers: [
                CustomSliverAppBar(scaffoldKey: _scaffoldKey),
                SliverList(
                    delegate: SliverChildListDelegate([
                  ChatBubble(
                    clipper: ChatBubbleClipper3(type: BubbleType.sendBubble),
                    margin: EdgeInsets.all(10),
                    backGroundColor: Color.fromARGB(255, 0, 0, 132),
                    elevation: 5.0,
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome to the Aatmanirbhar App!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white),
                    ),
                  ),
                  CompanyCardView(),
                  FooterWidget()
                ])),
              ]),
            ),
          ),
        ),
        autoPlay: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final RenderBox box = context.findRenderObject();
          Share.share(
              'Want to support made in India products that benefit India? Looking for Indian alternatives to foreign products? Want to support local businesses? Unaware of interesting aatmanirbhar stories and facts about Indian companies? Download and install The Aatmanirbhar App from the following link to find answers to all these questions. https://play.google.com/store/apps/details?id=com.aatmanirbhar.flutter',
              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
        },
        child: Icon(
          Icons.share_rounded,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 136),
      ),
    );
  }
}
