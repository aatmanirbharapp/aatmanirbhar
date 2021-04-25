import 'dart:async';
import 'dart:convert';

import 'package:atamnirbharapp/bloc/IndexBloc.dart';
import 'package:atamnirbharapp/bloc/dbprovider.dart';
import 'package:atamnirbharapp/bloc/search_bloc.dart';
import 'package:atamnirbharapp/http/faqrequest.dart';
import 'package:atamnirbharapp/ui/screens/forein_product_screen.dart';
import 'package:atamnirbharapp/ui/screens/india_product_screen.dart';
import 'package:atamnirbharapp/ui/screens/indiancompanyscreen.dart';
import 'package:atamnirbharapp/ui/screens/outside_india_company.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'package:speech_to_text/speech_to_text.dart';

class DataSearch extends StatefulWidget {
  @override
  _DataSearchState createState() => _DataSearchState();
}

class _DataSearchState extends State<DataSearch>
    with SingleTickerProviderStateMixin {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING = "loggedIn";
  GlobalKey _three = GlobalKey();
  GlobalKey _fourth = GlobalKey();
  final SpeechToText speech = SpeechToText();
  bool isListing = false;
  GlobalKey _five = GlobalKey();
  GlobalKey _six = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<QueryDocumentSnapshot> data;
  String _searchText = "";
  final _controller = TextEditingController();
  String type;
  List countryList = new List.empty(growable: true);
  List sectorList = new List.empty(growable: true);
  String _country = "India";
  String _dropDowncountry = "India";
  int make = 1;
  bool _isConnected = true;
  var radioValue = 2;
  var radiotype = 1;
  int makesInIndia = 2;
  bool _isVisible = false;
  bool _ignorePointer = false;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String _connectionStatus = 'Unknown';
  final _httpReq = SqlResponse();
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    super.initState();

    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    //_loadFromApi();
    setState(() {
      type = "product";
    });

    //loadCountries();
    //print(DBProvider.db.getAllCompanySearch());
  }

  _loadFromApi() async {
    List companyList = await _httpReq.searchByCompany();
    List productList = await _httpReq.searchByProduct();
    if (companyList.isNotEmpty) await DBProvider.db.createCompany(companyList);
    if (productList.isNotEmpty) await DBProvider.db.createProduct(productList);
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        {
          setState(() {
            _ignorePointer = false;
          });
          internetCheckBloc.updateCurrentIndex(true);
          break;
        }
      case ConnectivityResult.mobile:
        {
          setState(() {
            _ignorePointer = false;
          });
          internetCheckBloc.updateCurrentIndex(true);
          break;
        }
      case ConnectivityResult.none:
        {
          setState(() {
            _ignorePointer = true;
          });
          internetCheckBloc.updateCurrentIndex(false);
          _scaffoldKey.currentState.showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).errorColor,
              content: Text("Please check your internet connection.")));
          break;
        }
      default:
        {
          setState(() {
            _ignorePointer = true;
          });
          internetCheckBloc.updateCurrentIndex(false);
          _scaffoldKey.currentState.showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).errorColor,
              content: Text("Please check your internet connection.")));
          break;
        }
    }
  }

  loadCountries() {
    final country =
        DefaultAssetBundle.of(context).loadString('assets/files/country.json');
    country.then((string) {
      Map<String, dynamic> country = json.decode(string);
      setState(() {
        countryList = country['countryList'];
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    internetCheckBloc.dispose();
  }

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences
            .getBool(CommanWidgets.PREFERENCES_IS_FIRST_LAUNCH_SEARCH_PAGE) ??
        true;

    if (isFirstLaunch)
      sharedPreferences.setBool(
          CommanWidgets.PREFERENCES_IS_FIRST_LAUNCH_SEARCH_PAGE, false);

    return isFirstLaunch;
  }

  void soundLevelListener(double level) {
    setState(() {
      this.level = level;
    });
  }

  void _listen() async {
    print('inside listen method');
    if (!isListing) {
      print('inside listen method true');
      bool available = await speech.initialize(
          onError: (val) => print('onError ${val}'),
          onStatus: (val) => print(' onStatus ${val}'));
      if (available) {
        setState(() {
          isListing = true;
        });
        speech.listen(
            listenFor: Duration(seconds: 10),
            pauseFor: Duration(seconds: 10),
            localeId: 'en',
            onSoundLevelChange: soundLevelListener,
            cancelOnError: true,
            listenMode: ListenMode.confirmation,
            onResult: (val) {
              searchTextBloc.updateSearchText(val.recognizedWords);
              setState(() {
                _controller.text = val.recognizedWords;
                isListing = false;
              });
            });
      }
    } else {
      setState(() {
        isListing = false;
        speech.stop();
      });
    }
  }

  void _onFocusChange() {
    debugPrint("Focus: " + _focus.hasFocus.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        primary: true,
        body: ShowCaseWidget(builder: Builder(builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _isFirstLaunch().then((result) {
              if (result) ShowCaseWidget.of(context).startShowCase([_three]);
            });
          });
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: CustomScrollView(slivers: [
              SliverAppBar(
                  pinned: false,
                  backgroundColor: Colors.orange[50],
                  actions: [
                    StreamBuilder<String>(
                        initialData: "",
                        stream: searchTextBloc.getSearchText,
                        builder: (context, snapshot) {
                          if (snapshot.data.isNotEmpty)
                            return IconButton(
                              onPressed: () {
                                setState(() {
                                  _controller.text = "";
                                });
                                searchTextBloc.updateSearchText("");
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Colors.black,
                              ),
                            );
                          else
                            return IconButton(
                              onPressed: null,
                              icon: Icon(Icons.search_outlined),
                            );
                        }),
                    AvatarGlow(
                        animate: isListing,
                        glowColor: Colors.blue,
                        duration: const Duration(microseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        shape: BoxShape.circle,
                        child: IconButton(
                            color: Colors.black,
                            icon: Icon(isListing ? Icons.mic : Icons.mic_none),
                            onPressed: _listen),
                        endRadius: 20),
                    Showcase(
                      key: _three,
                      title: 'Filters',
                      description: 'Search companies from different countries',
                      child: IconButton(
                        color: Color.fromARGB(255, 0, 0, 136),
                        icon: Icon(Icons.filter_list_sharp),
                        onPressed: () {
                          setState(() {
                            _isVisible = true;
                          });
                        },
                      ),
                    )
                  ],
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  floating: true,
                  title: Container(
                      alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: TextField(
                        onChanged: (value) async {
                          searchTextBloc.updateSearchText(value);
                        },
                        controller: _controller,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "search".tr().toString() +
                              " " +
                              "search_${type}".tr().toString() +
                              " " +
                              "search_name".tr().toString() +
                              "...",
                        ),
                      )),
                  centerTitle: true,
                  bottom: _isVisible
                      ? PreferredSize(
                          preferredSize: const Size.fromHeight(260),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15))),
                            alignment: Alignment.topCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("search".tr().toString() + " :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    Text("search_product".tr().toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    Showcase(
                                      key: _five,
                                      title: 'Search Product',
                                      description:
                                          'Search any products from your regular use to know about its Made In India',
                                      child: Radio(
                                        value: 1,
                                        groupValue: radiotype,
                                        onChanged: (value) {
                                          setState(() {
                                            radiotype = value;
                                            type = "product";
                                          });
                                        },
                                      ),
                                    ),
                                    Text("search_company".tr().toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    Showcase(
                                      key: _six,
                                      title: 'Search companies',
                                      description:
                                          'Search Companies from different countries.',
                                      child: Radio(
                                        value: 0,
                                        groupValue: radiotype,
                                        onChanged: (value) {
                                          setState(() {
                                            radiotype = value;
                                            type = "company";
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          "search_country".tr().toString() +
                                              " :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )),
                                    Spacer(),
                                    DropdownButton(
                                      hint: Text('Country'),
                                      value: _dropDowncountry,
                                      items: <String>[
                                        "All Countries",
                                        'India',
                                        'China',
                                        'United States of America',
                                        'United Kingdom',
                                        'Japan',
                                        'South Korea',
                                        'Germany'
                                      ].map((String value) {
                                        return new DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String val) {
                                        setState(() {
                                          print(val);
                                          if (val.contains('All')) {
                                            _dropDowncountry = val;
                                            _country = "";
                                          } else {
                                            _dropDowncountry = val;
                                            _country = val;
                                          }
                                        });
                                      },
                                    ),
                                    Spacer()
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Text(
                                          "search_makes".tr().toString() + " :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )),
                                    Text("yes".tr().toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    Radio(
                                      value: 1,
                                      groupValue: radioValue,
                                      onChanged: (value) {
                                        setState(() {
                                          radioValue = value;
                                          makesInIndia = value;
                                        });
                                      },
                                    ),
                                    Text("no".tr().toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    Radio(
                                      value: 0,
                                      groupValue: radioValue,
                                      onChanged: (value) {
                                        setState(() {
                                          radioValue = value;
                                          makesInIndia = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Divider(),
                                Center(
                                  child: IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _isVisible = false;
                                        });
                                      }),
                                )
                              ],
                            ),
                          ),
                        )
                      : PreferredSize(
                          preferredSize: const Size.fromHeight(60),
                          child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              alignment: Alignment.topCenter,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("search".tr().toString() + ":",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  Text("search_product".tr().toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  Radio(
                                    value: 1,
                                    groupValue: radiotype,
                                    onChanged: (value) {
                                      setState(() {
                                        radiotype = value;
                                        type = "product";
                                      });
                                    },
                                  ),
                                  Text("search_company".tr().toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  Radio(
                                    value: 0,
                                    groupValue: radiotype,
                                    onChanged: (value) {
                                      setState(() {
                                        radiotype = value;
                                        type = "company";
                                      });
                                    },
                                  ),
                                ],
                              )))),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: type.isNotEmpty
                        ? StreamBuilder<String>(
                            initialData: "",
                            stream: searchTextBloc.getSearchText,
                            builder: (context, snapshot) {
                              return FutureBuilder(
                                future: type.contains('product')
                                    ? DBProvider.db.productSearch(
                                        snapshot.data,
                                        _country,
                                        makesInIndia,
                                        "",
                                        "",
                                        isListing)
                                    : DBProvider.db.companySearch(snapshot.data,
                                        _country, makesInIndia, "", isListing),
                                builder: (BuildContext context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return CommanWidgets()
                                          .getCircularProgressIndicator(
                                              context);

                                    default:
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(
                                              "No result found for the given search. More companies and products are added periodically in this app. Please check back late.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'Ambit',
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 136))),
                                        );
                                      } else {
                                        return createListView(snapshot.data);
                                      }
                                  }
                                },
                              );
                            })
                        : CommanWidgets()
                            .getCircularProgressIndicator(context)),
              ])),
            ]),
          );
        })));
  }

  Widget createListView(List datalist) {
    return StreamBuilder(
        stream: internetCheckBloc.isConnected,
        initialData: true,
        builder: (context, snapshot) {
          return snapshot.data
              ? IgnorePointer(
                  ignoring: _ignorePointer,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: datalist == null ? 0 : datalist.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            onTap: () {
                              type.contains('product')
                                  ? datalist
                                          .elementAt(index)['first_country']
                                          .toLowerCase()
                                          .contains("india")
                                      ? Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  IndianProduct(
                                                    productId:
                                                        datalist.elementAt(
                                                            index)['image'],
                                                  ),
                                              settings: RouteSettings(
                                                  name: 'product')))
                                      : Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  ForeinProductPage(
                                                    productId:
                                                        datalist.elementAt(
                                                            index)['image'],
                                                  ),
                                              settings: RouteSettings(
                                                  name: 'productOutside')))
                                  : datalist
                                          .elementAt(index)['first_country']
                                          .toLowerCase()
                                          .contains("india")
                                      ? Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  IndianCompany(
                                                    companyId: datalist
                                                        .elementAt(index)['id'],
                                                  ),
                                              settings: RouteSettings(
                                                  name: 'company')))
                                      : Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  OutsideIndiaCompany(
                                                    companyId: datalist
                                                        .elementAt(index)['id'],
                                                  ),
                                              settings: RouteSettings(
                                                  name: 'companyOutside')));
                            },
                            leading: IconButton(
                                onPressed: () => null,
                                icon: Icon(Icons.search)),
                            title: Text(
                                datalist.elementAt(index)[type + '_name'],
                                style: TextStyle(
                                    fontFamily: 'Ambit',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 136))),
                            subtitle: Text(
                                datalist.elementAt(index)['first_country'],
                                style: TextStyle(
                                    fontFamily: 'Ambit',
                                    color: Colors.black87)),
                          ),
                        );
                      }),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                );
        });
  }
}
