import 'dart:async';
import 'dart:convert';
import 'package:atamnirbharapp/bloc/dbprovider.dart';
import 'package:atamnirbharapp/ui/screens/forein_product_screen.dart';
import 'package:atamnirbharapp/ui/screens/india_product_screen.dart';
import 'package:atamnirbharapp/ui/screens/indiancompanyscreen.dart';
import 'package:atamnirbharapp/bloc/IndexBloc.dart';
import 'package:atamnirbharapp/ui/screens/outside_india_company.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DataSearch extends StatefulWidget {
  @override
  _DataSearchState createState() => _DataSearchState();
}

class _DataSearchState extends State<DataSearch>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<QueryDocumentSnapshot> data;
  String _searchText = "";
  final _controller = TextEditingController();
  String type;
  List countryList = new List.empty(growable: true);
  List sectorList = new List.empty(growable: true);
  String _country = "India";
  int make = 1;
  bool _isConnected = true;
  var radioValue = 2;
  var radiotype = 1;
  int makesInIndia = 2;
  bool _isVisible = false;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String _connectionStatus = 'Unknown';

  _DataSearchState() {
    print(_controller.text);
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    setState(() {
      type = "product";
    });

    loadCountries();
    //print(DBProvider.db.getAllCompanySearch());
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
        internetCheckBloc.updateCurrentIndex(true);
        break;
      case ConnectivityResult.mobile:
        internetCheckBloc.updateCurrentIndex(true);
        break;
      case ConnectivityResult.none:
        internetCheckBloc.updateCurrentIndex(false);
        Scaffold.of(_scaffoldKey.currentContext).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).errorColor,
            content: Text("Please check your internet connection.")));
        break;
      default:
        internetCheckBloc.updateCurrentIndex(false);
        Scaffold.of(_scaffoldKey.currentContext).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).errorColor,
            content: Text("Please check your internet connection.")));
        break;
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

  loadSectors() {
    final country =
        DefaultAssetBundle.of(context).loadString('assets/files/sectors.json');
    country.then((string) {
      Map<String, dynamic> country = json.decode(string);
      setState(() {
        sectorList = country['sectorlist'];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        primary: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CustomScrollView(slivers: [
            SliverAppBar(
                pinned: false,
                backgroundColor: Colors.orange[50],
                actions: [
                  if (_searchText.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _searchText = "";
                          _controller.text = "";
                        });
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                    ),
                  IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.filter_alt),
                    onPressed: () {
                      setState(() {
                        _isVisible = true;
                      });
                    },
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
                      onChanged: (value) async {},
                      controller: _controller,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Search by " + type + " name ...",
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
                                  Text("Search by:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  Text("Product",
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
                                  Text("Company",
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
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "Country :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )),
                                  Spacer(),
                                  DropdownButton(
                                    hint: Text('Country'),
                                    value: _country,
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
                                        if (val == "All Countries")
                                          _country = "";
                                        _country = val;
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
                                        "Makes In India :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )),
                                  Text("Yes",
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
                                  Text("No",
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Search by:",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                Text("Product",
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
                                Text("Company",
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
                      ? FutureBuilder(
                          future: type.contains('product')
                              ? DBProvider.db.productSearch(
                                  _searchText, _country, makesInIndia, "", "")
                              : DBProvider.db.companySearch(
                                  _searchText, _country, makesInIndia, ""),
                          builder: (BuildContext context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return CommanWidgets()
                                    .getCircularProgressIndicator(context);

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
                        )
                      : CommanWidgets().getCircularProgressIndicator(context)),
            ])),
          ]),
        ));
  }

  Widget createListView(List datalist) {
    return StreamBuilder(
        stream: internetCheckBloc.isConnected,
        initialData: true,
        builder: (context, snapshot) {
          return snapshot.data
              ? ListView.builder(
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
                                          builder: (context) => IndianProduct(
                                                productId: datalist
                                                    .elementAt(index)['image'],
                                              ),
                                          settings:
                                              RouteSettings(name: 'product')))
                                  : Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              ForeinProductPage(
                                                productId: datalist
                                                    .elementAt(index)['image'],
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
                                          builder: (context) => IndianCompany(
                                                companyId: datalist
                                                    .elementAt(index)['id'],
                                              ),
                                          settings:
                                              RouteSettings(name: 'company')))
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
                            onPressed: () => null, icon: Icon(Icons.search)),
                        title: Text(datalist.elementAt(index)[type + '_name'],
                            style: TextStyle(
                                fontFamily: 'Ambit',
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 136))),
                        subtitle: Text(
                            datalist.elementAt(index)['first_country'],
                            style: TextStyle(
                                fontFamily: 'Ambit', color: Colors.black87)),
                      ),
                    );
                  })
              : Container(
                  height: MediaQuery.of(context).size.height,
                );
        });
  }
}
