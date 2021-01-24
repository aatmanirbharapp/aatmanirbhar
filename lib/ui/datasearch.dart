import 'dart:convert';
import 'package:atamnirbharapp/bloc/check_internet.dart';
import 'package:provider/provider.dart';
import 'package:atamnirbharapp/http/faqrequest.dart';
import 'package:atamnirbharapp/ui/screens/forein_product_screen.dart';
import 'package:atamnirbharapp/ui/screens/india_product_screen.dart';
import 'package:atamnirbharapp/ui/screens/indiancompanyscreen.dart';

import 'package:atamnirbharapp/ui/screens/outside_india_company.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class DataSearch extends StatefulWidget {
  @override
  _DataSearchState createState() => _DataSearchState();
}

class _DataSearchState extends State<DataSearch>
    with SingleTickerProviderStateMixin {
  TabController _tabcontroller;
  List<QueryDocumentSnapshot> data;
  String _searchText = "";
  final _controller = TextEditingController();
  String type;
  List countryList = new List();
  List sectorList = new List();
  String _country = "";
  int make = 1;
  final _httpReq = SqlResponse();

  _DataSearchState() {
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

  List<bool> _isChecked;

  @override
  void initState() {
    super.initState();
    CheckInternet().checkConnection(context);
    setState(() {
      type = "company";
    });
    _tabcontroller = TabController(length: 2, vsync: this);
    loadCountries();
    _isChecked = List<bool>.filled(21, false);
  }

  final Set _saved = Set();
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
    CheckInternet().listener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
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
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: TextField(
          onChanged: (value) async {
            String date = DateTime.now().toIso8601String();
            FirebaseAnalytics analytics =
                Provider.of<FirebaseAnalytics>(context, listen: false);
            await analytics.logSearch(searchTerm: value, startDate: date);
          },
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
        ),
      ),
      body: ListView(children: [
        ColoredBox(
          color: Color.fromARGB(255, 0, 0, 136),
          child: TabBar(
            controller: _tabcontroller,
            onTap: (index) {
              if (index == 1) {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return Container(
                        height: 380,
                        child: Column(
                          children: <Widget>[
                            new ListTile(
                              leading: new Icon(Icons.all_inclusive),
                              title: new Text('All Countries'),
                              onTap: () => {
                                setState(() {
                                  _country = "";
                                })
                              },
                            ),
                            Container(
                              height: 300,
                              child: ListView.builder(
                                itemCount: countryList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                      leading: new Icon(Icons.flag),
                                      title: new Text(
                                          countryList.elementAt(index)),
                                      onTap: () => {
                                            setState(() {
                                              _country =
                                                  countryList.elementAt(index);
                                            })
                                          });
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    });
              } else {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return Container(
                        child: new Wrap(
                          children: <Widget>[
                            new ListTile(
                                leading:
                                    Image.asset("assets/images/company.png"),
                                title: new Text('Company',
                                    style: TextStyle(
                                        fontFamily: 'Ambit',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 136))),
                                onTap: () => {
                                      setState(() {
                                        type = "company";
                                        _searchText = "";
                                        _controller.text = "";
                                      })
                                    }),
                            new ListTile(
                              leading: Image.asset("assets/images/product.png"),
                              title: new Text('Product',
                                  style: TextStyle(
                                      fontFamily: 'Ambit',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 136))),
                              onTap: () => {
                                setState(() {
                                  type = "product";
                                  _searchText = "";
                                  _controller.text = "";
                                })
                              },
                            ),
                          ],
                        ),
                      );
                    });
              }
            },
            tabs: [
              Tab(
                child: Text(
                  "Type : " + type,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Tab(
                  child: Text(
                "Country",
                style: TextStyle(color: Colors.white),
              )),
            ],
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: type.isNotEmpty
                ? FutureBuilder(
                    future: type.contains('product')
                        ? _httpReq.searchByProduct(
                            type, _searchText, _country, make)
                        : _httpReq.searchByCompany(
                            type, _searchText, _country, make),
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
                                      color: Color.fromARGB(255, 0, 0, 136))),
                            );
                          } else {
                            return createListView(snapshot.data);
                          }
                      }
                    },
                  )
                : CommanWidgets().getCircularProgressIndicator(context)),
      ]),
    );
  }

  Widget _buildSearchList(List data) {
    List<Map> searchList = List();
    if (_searchText.isNotEmpty) {
      for (int i = 0; i < data.length; i++) {
        final Map company = data.elementAt(i);

        if (company[type + '_name']
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          searchList.add(company);
        }
      }
      return createListView(searchList);
    }
    return createListView(searchList);
  }

  Widget createListView(List datalist) {
    return ListView.builder(
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
                            .elementAt(index)['country']
                            .toLowerCase()
                            .contains("india")
                        ? Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => IndianProduct(
                                      productId:
                                          datalist.elementAt(index)['image'],
                                    ),
                                settings: RouteSettings(name: 'product')))
                        : Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => ForeinProductPage(
                                      productId:
                                          datalist.elementAt(index)['image'],
                                    ),
                                settings:
                                    RouteSettings(name: 'productOutside')))
                    : datalist
                            .elementAt(index)['country']
                            .toLowerCase()
                            .contains("india")
                        ? Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => IndianCompany(
                                      companyId:
                                          datalist.elementAt(index)['id'],
                                    ),
                                settings: RouteSettings(name: 'company')))
                        : Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => OutsideIndiaCompany(
                                      companyId:
                                          datalist.elementAt(index)['id'],
                                    ),
                                settings:
                                    RouteSettings(name: 'companyOutside')));
              },
              leading:
                  IconButton(onPressed: () => null, icon: Icon(Icons.search)),
              title: Text(datalist.elementAt(index)[type + '_name'],
                  style: TextStyle(
                      fontFamily: 'Ambit',
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 136))),
              subtitle: Text(datalist.elementAt(index)['country'],
                  style: TextStyle(fontFamily: 'Ambit', color: Colors.black87)),
            ),
          );
        });
  }
}
