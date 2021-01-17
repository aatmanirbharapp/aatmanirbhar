import 'package:atamnirbharapp/bloc/company_repo.dart';
import 'package:atamnirbharapp/ui/components/footerwidget.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CompanyCardView extends StatefulWidget {
  @override
  _CompanyCardViewState createState() => _CompanyCardViewState();
}

class _CompanyCardViewState extends State<CompanyCardView> {
  YoutubePlayerController _controller;

  bool _isPlayerReady = false;
  PlayerState _playerState;
  final FirebaseStorage storageRef = FirebaseStorage.instance;
  CompanyRepository companyRepo = CompanyRepository();

  YoutubeMetaData _videoMetaData;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          "https://www.youtube.com/watch?v=0CG8Jd7FdtA"),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);

    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: Padding(
              padding: EdgeInsets.all(5),
              child: YoutubePlayerBuilder(
                builder: (context, player) => Container(),
                player: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.blueAccent,
                  topActions: <Widget>[
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        _controller.metadata.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                  onReady: () {
                    _isPlayerReady = true;
                  },
                  onEnded: (data) {},
                ),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15, right: 8, left: 8, bottom: 8),
          child: Text("Trending Aatmanirbhar Companies",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Ambit',
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 136))),
        ),
        Container(
            margin: EdgeInsets.only(top: 10),
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder<List<QueryDocumentSnapshot>>(
              future: companyRepo.getAllTrendingCompany(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CommanWidgets()
                        .getCircularProgressIndicator(context);
                  default:
                    if (snapshot.hasData) {
                      return CarouselSlider.builder(
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          pauseAutoPlayOnTouch: true,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) => Dialog(
                                      child: FutureBuilder<Object>(
                                          future: storageRef
                                              .ref()
                                              .child("trending_company_logos/" +
                                                  snapshot.data
                                                      .elementAt(index)
                                                      .data()['trendingImage'])
                                              .getDownloadURL(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData)
                                              return Container(
                                                height: 220,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            snapshot.data),
                                                        fit: BoxFit.fill)),
                                              );
                                            return SizedBox(
                                              width: 10,
                                              height: 10,
                                              child: CircularProgressIndicator(
                                                value: 5,
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          })));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black26)),
                              child: Row(
                                children: [
                                  FutureBuilder<Object>(
                                      future: storageRef
                                          .ref()
                                          .child("Company_Logos/" +
                                              snapshot.data
                                                  .elementAt(index)
                                                  .data()['image'])
                                          .getDownloadURL(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData)
                                          return Container(
                                            width: 100,
                                            child: IconButton(
                                                iconSize: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                icon: Image.network(
                                                    snapshot.data),
                                                onPressed: () {}),
                                          );
                                        return Container(
                                          width: 50,
                                          child: LinearProgressIndicator(
                                            value: 5,
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 200,
                                    child: SingleChildScrollView(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        snapshot.data
                                            .elementAt(index)
                                            .data()['companyName'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 0, 136),
                                            fontFamily: 'Ambit',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.visible,
                                        softWrap: true,
                                        maxLines: null,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error occured"));
                    } else {
                      return Center(child: Text("Error occured"));
                    }
                }
              },
            )),
      ],
    );
  }
}
