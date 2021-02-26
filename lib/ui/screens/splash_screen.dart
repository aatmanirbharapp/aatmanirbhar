import 'package:atamnirbharapp/bloc/dbprovider.dart';
import 'package:atamnirbharapp/http/faqrequest.dart';
import 'package:flutter/material.dart';
import 'package:atamnirbharapp/ui/home_page.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  VideoPlayerController _controller;
  final _httpReq = SqlResponse();
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
        "assets/video/Opening_Animation_The_Aatmanirbhar_App.mp4")
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
    _loadFromApi();
    Future.delayed(Duration(seconds: 8), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  _loadFromApi() async {
    List companyList = await _httpReq.searchByCompany();
    List productList = await _httpReq.searchByProduct();
    if (companyList.isNotEmpty) await DBProvider.db.createCompany(companyList);
    if (productList.isNotEmpty) await DBProvider.db.createProduct(productList);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // TODO 6: Create a Stack Widget
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/BG_Color.jpeg"),
            fit: BoxFit.cover,
          )),
          width: _controller.value.size?.width ?? 0,
          height: _controller.value.size?.height ?? 0,
          child: Stack(children: [
            VideoPlayer(_controller),
          ])),
    ));
  }
}
