import 'package:atamnirbharapp/ui/datasearch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcase_widget.dart';

class SearchBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10, top: 5),
      child: Container(
        height: 43,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 25, right: 25),
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border:
                  Border.all(color: Colors.grey.withOpacity(0.5), width: 1.0),
              color: Colors.white),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => DataSearch(),
                      settings: RouteSettings(name: 'search')));
            },
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => DataSearch(),
                            settings: RouteSettings(name: 'search')));
                  },
                ),
                Expanded(
                    child: Text(
                  "home_search".tr().toString(),
                  style: TextStyle(fontSize: 15, color: Colors.black45),
                  textAlign: TextAlign.left,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
