import 'package:atamnirbharapp/bloc/IndexBloc.dart';
import 'package:atamnirbharapp/bloc/company_repo.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class CompanyCardView extends StatefulWidget {
  @override
  _CompanyCardViewState createState() => _CompanyCardViewState();
}

class _CompanyCardViewState extends State<CompanyCardView> {
  YoutubePlayerController _youtubecontroller;
  YoutubePlayerController _youtubecontrollerSec;
  YoutubePlayerController _youtubecontrollerThird;
  PageController _controller = PageController(initialPage: 0, keepPage: true);
  bool _isPlayerReady = false;
  var selectedPage = 0;

  final FirebaseStorage storageRef = FirebaseStorage.instance;
  CompanyRepository companyRepo = CompanyRepository();

  @override
  void initState() {
    super.initState();
    _youtubecontroller = YoutubePlayerController(
        initialVideoId: YoutubePlayerController.convertUrlToId(
            "https://www.youtube.com/watch?v=Z1-kYZ9SVAg"),
        params: const YoutubePlayerParams(
          autoPlay: false,
          showControls: true,
          showFullscreenButton: true,
          desktopMode: true,
          privacyEnhanced: true,
        ));

    _youtubecontroller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    };
    _youtubecontroller.onExitFullscreen = () {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      Future.delayed(const Duration(seconds: 1), () {
        _youtubecontroller.play();
      });
      Future.delayed(const Duration(seconds: 5), () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      });
    };
    _youtubecontrollerSec = YoutubePlayerController(
        initialVideoId: YoutubePlayerController.convertUrlToId(
            "https://www.youtube.com/watch?v=I0O26nTJUYg"),
        params: const YoutubePlayerParams(
          autoPlay: false,
          showControls: true,
          showFullscreenButton: true,
          desktopMode: true,
          privacyEnhanced: true,
        ));

    _youtubecontrollerSec.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    };
    _youtubecontrollerSec.onExitFullscreen = () {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      Future.delayed(const Duration(seconds: 1), () {
        _youtubecontrollerSec.play();
      });
      Future.delayed(const Duration(seconds: 5), () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      });
    };
    _youtubecontrollerThird = YoutubePlayerController(
        initialVideoId: YoutubePlayerController.convertUrlToId(
            "https://www.youtube.com/watch?v=F7nHOdwD30o"),
        params: const YoutubePlayerParams(
          autoPlay: false,
          showControls: true,
          showFullscreenButton: true,
          desktopMode: true,
          privacyEnhanced: true,
        ));

    _youtubecontrollerThird.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    };
    _youtubecontrollerThird.onExitFullscreen = () {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      Future.delayed(const Duration(seconds: 1), () {
        _youtubecontrollerThird.play();
      });
      Future.delayed(const Duration(seconds: 5), () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      });
    };
  }

  void listener() {
    if (_isPlayerReady && mounted && !_youtubecontroller.value.isFullScreen) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    indexBloc.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: false,
                autoPlayInterval: Duration(seconds: 15),
                pauseAutoPlayOnTouch: true,
                pauseAutoPlayOnManualNavigate: true,
                onPageChanged: (index, reason) {
                  indexBloc.updateCurrentIndex(index);
                }),
            items: [
              YoutubePlayerControllerProvider(
                  controller: _youtubecontroller,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (kIsWeb && constraints.maxWidth > 800) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(child: player),
                          ],
                        );
                      }
                      return player;
                    },
                  )),
              YoutubePlayerControllerProvider(
                  controller: _youtubecontrollerSec,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (kIsWeb && constraints.maxWidth > 800) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(child: player),
                          ],
                        );
                      }
                      return player;
                    },
                  )),
              YoutubePlayerControllerProvider(
                  controller: _youtubecontrollerThird,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (kIsWeb && constraints.maxWidth > 800) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(child: player),
                          ],
                        );
                      }
                      return player;
                    },
                  ))
            ],
          ),
        ),
        StreamBuilder(
            stream: indexBloc.currentIndex,
            initialData: 0,
            builder: (context, snapshot) {
              return DotsIndicator(
                dotsCount: 3,
                position: snapshot.data.toDouble(),
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              );
            }),
        Divider(),
        Padding(
          padding: EdgeInsets.only(top: 15, right: 8, left: 8),
          child: Text("Trending Aatmanirbhar Companies",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Ambit',
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 136))),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          height: MediaQuery.of(context).size.height * 0.4,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  highlightColor: Colors.pink,
                  onPressed: () {
                    setState(() {
                      if (selectedPage > 0) {
                        selectedPage = selectedPage - 1;
                        _controller.jumpToPage(selectedPage);
                      }
                    });
                  },
                ),
              ),
              FutureBuilder<List<QueryDocumentSnapshot>>(
                  future: companyRepo.getAllTrendingCompany(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return CommanWidgets()
                            .getCircularProgressIndicator(context);
                      default:
                        if (snapshot.hasData) {
                          return Expanded(
                              flex: 7,
                              child: PageView.builder(
                                  controller: _controller,
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  onPageChanged: (index) {
                                    selectedPage = index;
                                  },
                                  pageSnapping: true,
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
                                                                    .elementAt(
                                                                        index)
                                                                    .data()[
                                                                'trendingImage'])
                                                        .getDownloadURL(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData)
                                                        return Container(
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      snapshot
                                                                          .data),
                                                                  fit: BoxFit
                                                                      .fill)),
                                                        );
                                                      return SizedBox(
                                                        width: 10,
                                                        height: 10,
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: 5,
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                      );
                                                    })));
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.black26)),
                                        margin: const EdgeInsets.all(3),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: SingleChildScrollView(
                                                child: Text(
                                                  snapshot.data
                                                      .elementAt(index)
                                                      .data()['companyName'],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 136),
                                                      fontFamily: 'Ambit',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  overflow:
                                                      TextOverflow.visible,
                                                  softWrap: true,
                                                  maxLines: null,
                                                ),
                                              ),
                                            ),
                                            FutureBuilder<Object>(
                                                future: storageRef
                                                    .ref()
                                                    .child("Company_Logos/" +
                                                        snapshot.data
                                                            .elementAt(index)
                                                            .data()['image'])
                                                    .getDownloadURL(),
                                                builder:
                                                    (context, innersnapshot) {
                                                  if (innersnapshot.hasData)
                                                    return IconButton(
                                                        iconSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3.5,
                                                        icon: Image.network(
                                                            innersnapshot.data),
                                                        onPressed: () async {
                                                          await showDialog(
                                                              context: context,
                                                              builder: (_) =>
                                                                  Dialog(
                                                                      child: FutureBuilder<
                                                                              Object>(
                                                                          future: storageRef
                                                                              .ref()
                                                                              .child("trending_company_logos/" + snapshot.data.elementAt(index).data()['trendingImage'])
                                                                              .getDownloadURL(),
                                                                          builder: (context, snapshot) {
                                                                            if (snapshot.hasData)
                                                                              return Container(
                                                                                height: 500,
                                                                                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(snapshot.data), fit: BoxFit.fill)),
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
                                                        });

                                                  return Container(
                                                    width: 50,
                                                    child:
                                                        LinearProgressIndicator(
                                                      value: 5,
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                  );
                                                }),
                                            Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: SingleChildScrollView(
                                                child: Text(
                                                  snapshot.data
                                                      .elementAt(index)
                                                      .data()['catchyline'],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Ambit',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  overflow:
                                                      TextOverflow.visible,
                                                  softWrap: true,
                                                  maxLines: null,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }));
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Error occured"));
                        } else {
                          return Center(child: Text("Error occured"));
                        }
                    }
                  }),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  highlightColor: Colors.pink,
                  onPressed: () {
                    if (selectedPage < 3) {
                      selectedPage = selectedPage + 1;
                      _controller.jumpToPage(selectedPage);

                      print("VALUES==>> $selectedPage");
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
