import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/bloc/company_sql.dart';
import 'package:atamnirbharapp/http/faqrequest.dart';
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
  String index;

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
      index = "0";
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
                initialValue: "company",
                position: buttonMenuPosition(context),
                items: <PopupMenuItem<String>>[
                  const PopupMenuItem<String>(
                      child: Text('Company'), value: 'company'),
                  const PopupMenuItem<String>(
                      child: Text('Product'), value: 'product'),
                  const PopupMenuItem<String>(
                      child: Text('Product By Type'), value: 'Product By Type'),
                ],
              );
              setState(() {
                index = value;
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
              hintText: "Search ..",
              hintStyle: TextStyle(color: Colors.black)),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: FutureBuilder(
          future: _httpReq.searchByCompany(index, _searchText),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) return _buildSearchList(snapshot.data);
            return CommanWidgets().getCircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _buildSearchList(List data) {
    List<CompanySql> searchList = List();
    if (_searchText.isNotEmpty) {
      for (int i = 0; i < data.length; i++) {
        final company = CompanySql.fromJson(data.elementAt(i));
        print(company);
        if (company.companyName
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          searchList.add(company);
        }
      }
      return createListView(searchList);
    }
    return createListView(searchList);
  }

  Widget createListView(List<CompanySql> datalist) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: datalist == null ? 0 : datalist.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              onTap: () {
                datalist
                        .elementAt(index)
                        .country
                        .toLowerCase()
                        .contains("india")
                    ? Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => IndianCompany(
                                  companyId: datalist
                                      .elementAt(index)
                                      .logoFileName
                                      .split(".")
                                      .first,
                                )))
                    : Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                OutsideIndiaCompany(company: null)));
              },
              leading:
                  IconButton(onPressed: () => null, icon: Icon(Icons.search)),
              title: Text(datalist.elementAt(index).companyName),
            ),
          );
        });
  }
}
