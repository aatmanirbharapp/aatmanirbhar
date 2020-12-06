import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/bloc/company_sql.dart';
import 'package:atamnirbharapp/http/faqrequest.dart';
import 'package:atamnirbharapp/ui/screens/forein_product_screen.dart';
import 'package:atamnirbharapp/ui/screens/india_product_screen.dart';
import 'package:atamnirbharapp/ui/screens/indiancompanyscreen.dart';

import 'package:atamnirbharapp/ui/screens/outside_india_company.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataSearch extends StatefulWidget {
  @override
  _DataSearchState createState() => _DataSearchState();
}

class _DataSearchState extends State<DataSearch> {
  List<QueryDocumentSnapshot> data;
  String _searchText = "";
  final _controller = TextEditingController();
  String type;

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

  @override
  void initState() {
    super.initState();

    setState(() {
      type = "company";
    });
  }

  RelativeRect buttonMenuPosition(BuildContext c) {
    final RenderBox bar = c.findRenderObject();
    final RenderBox overlay = Overlay.of(c).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        bar.localToGlobal(bar.size.topRight(Offset.zero), ancestor: overlay),
        bar.localToGlobal(bar.size.topRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          IconButton(
            onPressed: () async {
              String value = await showMenu(
                elevation: 8,
                context: context,
                position: buttonMenuPosition(context),
                items: <PopupMenuItem<String>>[
                  const PopupMenuItem<String>(
                      child: Text('Company'), value: 'company'),
                  const PopupMenuItem<String>(
                      child: Text('Product'), value: 'product'),
                ],
              );
              setState(() {
                type = value;
                _searchText = "";
                _controller.text = "";
              });
            },
            icon: Icon(Icons.list, color: Colors.black),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: TextField(
          controller: _controller,
          enableSuggestions: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: "Search by " + type + "...",
          ),
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: type.isNotEmpty
              ? FutureBuilder(
                  future: type.contains('product')
                      ? _httpReq.searchByProduct(type, _searchText)
                      : _httpReq.searchByCompany(type, _searchText),
                  builder: (BuildContext context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return CommanWidgets()
                            .getCircularProgressIndicator(context);
                      default:
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                                "Error Occured please check your connection"),
                          );
                        } else {
                          return createListView(snapshot.data);
                        }
                    }
                  },
                )
              : CommanWidgets().getCircularProgressIndicator(context)),
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
                                    )))
                        : Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => ForeinProductPage(
                                      productId:
                                          datalist.elementAt(index)['image'],
                                    )))
                    : datalist
                            .elementAt(index)['country']
                            .toLowerCase()
                            .contains("india")
                        ? Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => IndianCompany(
                                      companyId: datalist
                                          .elementAt(index)['company_logo'],
                                    )))
                        : Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => OutsideIndiaCompany(
                                      companyId: datalist
                                          .elementAt(index)['company_logo'],
                                    )));
              },
              leading:
                  IconButton(onPressed: () => null, icon: Icon(Icons.search)),
              title: Text(datalist.elementAt(index)[type + '_name']),
            ),
          );
        });
  }
}
