import 'package:flutter/material.dart';

class PeopleRow extends StatelessWidget {
  const PeopleRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 250,
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            children: [
              Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2, color: Colors.black38),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/Dani.jpeg"),
                      )),
                  child: null),
              Column(
                children: [
                  Text(
                    "Added BY",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text("Danial Rugeles"),
                  Text("USA")
                ],
              )
            ],
          ),
        ),
        Container(
          height: 250,
          width: MediaQuery.of(context).size.width * 0.45,
          child: Column(
            children: [
              Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2, color: Colors.black38),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/Prathm.jpg"),
                      )),
                  child: null),
              Column(
                children: [
                  Text(
                    "Moderator By",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text("Danial Rugeles"),
                  Text("USA")
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
