import 'package:atamnirbharapp/ui/screens/indiancompanyscreen.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  final companies = [
    "Bajaj",
    "Jio",
    "Accenture",
    "Audi",
    "Godrej",
    "LG",
    "MI",
    "One Plus",
    "Nokia"
  ];

  final recentList = [
    "LG",
    "MI",
    "One Plus",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {}),
      IconButton(icon: Icon(Icons.keyboard_voice), onPressed: () {})
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return IndianCompany(
      companyName: 'test',
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? recentList : companies;

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.search),
        title: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
    );
  }
}
