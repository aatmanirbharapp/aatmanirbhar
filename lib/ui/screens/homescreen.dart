import 'package:atamnirbharapp/bloc/IndexBloc.dart';
import 'package:atamnirbharapp/bloc/company_repo.dart';
import 'package:atamnirbharapp/ui/components/searchbarwidget.dart';
import 'package:atamnirbharapp/ui/components/titlewidget.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:number_slide_animation/number_slide_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'package:translator/translator.dart';

class CompanyCardView extends StatefulWidget {
  CompanyCardView({
    Key key,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  _CompanyCardViewState createState() => _CompanyCardViewState();
}

class _CompanyCardViewState extends State<CompanyCardView> {
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  PageController _controller = PageController(initialPage: 0, keepPage: true);
  bool _isPlayerReady = false;
  var selectedPage = 0;
  final FirebaseFirestore store = FirebaseFirestore.instance;
  final FirebaseStorage storageRef = FirebaseStorage.instance;
  CompanyRepository companyRepo = CompanyRepository();
  String _selection = "en";
  final translator = GoogleTranslator();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    indexBloc.dispose();
    _controller.dispose();
  }

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences
            .getBool(CommanWidgets.PREFERENCES_IS_FIRST_LAUNCH_STRING) ??
        true;

    if (isFirstLaunch)
      sharedPreferences.setBool(
          CommanWidgets.PREFERENCES_IS_FIRST_LAUNCH_STRING, false);

    return isFirstLaunch;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirstLaunch().then((result) {
        if (result) ShowCaseWidget.of(context).startShowCase([_one, _two,_three]);
      });
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Image.asset("assets/images/sidebar.png"),
              onPressed: () {
                widget._scaffoldKey.currentState.openDrawer();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TitleWidget(),
            ),
            Showcase(
              key: _three,
              description: "Switch between different languages",
              title: "Language",
              child: PopupMenuButton(
                initialValue: 'en',
                padding: EdgeInsets.only(right: 8),
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
                  setState(() {
                    _selection = result;
                    context.locale = Locale(result);
                  });
                },
                icon: Icon(Icons.language),
              ),
            ),
          ],
        ),
        ChatBubble(
          clipper: ChatBubbleClipper3(type: BubbleType.sendBubble),
          margin: EdgeInsets.all(10),
          backGroundColor: Color.fromARGB(255, 0, 0, 132),
          elevation: 5.0,
          alignment: Alignment.center,
          child: Showcase(
            key: _two,
            title: "Use this app to:",
            description:
                "1) Know where your money goes \n2) Add local companies and products \n3) Know stories about Indian companies",
            child: Text(
              'home_welcome'.tr().toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
            ),
          ),
        ),
        Showcase(
            key: _one,
            title: 'Search here',
            description: 'Please search companies/products here.',
            child: SearchBarWidget()),
        FutureBuilder<QuerySnapshot>(
            future: store.collection("count").get(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return LinearProgressIndicator();
                default:
                  if (snapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("home_search_from".tr().toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Ambit',
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 136))),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: NumberSlideAnimation(
                              number: snapshot.data.docs.first
                                  .data()['company']
                                  .toString(),
                              curve: Curves.bounceInOut,
                              duration: const Duration(seconds: 2),
                              textStyle: TextStyle(
                                  fontFamily: 'Ambit',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        Text("home_search_company".tr().toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Ambit',
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 136))),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: NumberSlideAnimation(
                              number: snapshot.data.docs.first
                                  .data()['product']
                                  .toString(),
                              curve: Curves.fastOutSlowIn,
                              duration: const Duration(seconds: 2),
                              textStyle: TextStyle(
                                  fontFamily: 'Ambit',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        Text("home_search_product".tr().toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Ambit',
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 136))),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text("Error occurred while loading the data"));
                  } else {
                    return Center(
                        child: Text("Error occurred while loading the data"));
                  }
              }
            }),
        Padding(
          padding: EdgeInsets.only(top: 15, right: 8, left: 8),
          child: Text("home_trending".tr().toString(),
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
                                                                'trendingImage${_selection}'])
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
                                                child: FutureBuilder<
                                                        Translation>(
                                                    future:
                                                        translator.translate(
                                                            snapshot.data
                                                                    .elementAt(
                                                                        index)
                                                                    .data()[
                                                                'companyName'],
                                                            to: context.locale
                                                                .languageCode),
                                                    builder:
                                                        (context, snapshot) {
                                                      switch (snapshot
                                                          .connectionState) {
                                                        case ConnectionState
                                                            .waiting:
                                                          return CommanWidgets()
                                                              .getCircularProgressIndicator(
                                                                  context);
                                                        default:
                                                          if (snapshot
                                                              .hasData) {
                                                            return Text(
                                                              snapshot
                                                                  .data.text,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          136),
                                                                  fontFamily:
                                                                      'Ambit',
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              softWrap: true,
                                                              maxLines: null,
                                                            );
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return Center(
                                                                child: Text(
                                                                    "Loading ..."));
                                                          } else {
                                                            return Center(
                                                                child: Text(
                                                                    "Loading ..."));
                                                          }
                                                      }
                                                    }),
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
                                                          print('trendingImage${_selection}');
                                                          await showDialog(
                                                              context: context,
                                                              builder: (_) =>
                                                                  Dialog(
                                                                      child: FutureBuilder<
                                                                              Object>(
                                                                          future: storageRef
                                                                              .ref()
                                                                              .child("trending_company_logos/" + snapshot.data.elementAt(index).data()['trendingImage${_selection}'])
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
                                                child: FutureBuilder<
                                                        Translation>(
                                                    future:
                                                        translator.translate(
                                                            snapshot.data
                                                                    .elementAt(
                                                                        index)
                                                                    .data()[
                                                                'catchyline'],
                                                            to: context.locale
                                                                .languageCode),
                                                    builder:
                                                        (context, snapshot) {
                                                      switch (snapshot
                                                          .connectionState) {
                                                        case ConnectionState
                                                            .waiting:
                                                          return CommanWidgets()
                                                              .getCircularProgressIndicator(
                                                                  context);
                                                        default:
                                                          if (snapshot
                                                              .hasData) {
                                                            return Text(
                                                              snapshot
                                                                  .data.text,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Ambit',
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              softWrap: true,
                                                              maxLines: null,
                                                            );
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return Center(
                                                                child: Text(
                                                                    "Loading ..."));
                                                          } else {
                                                            return Center(
                                                                child: Text(
                                                                    "Loading ..."));
                                                          }
                                                      }
                                                    }),
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
                    if (selectedPage < 4) {
                      selectedPage = selectedPage + 1;
                      _controller.jumpToPage(selectedPage);
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
