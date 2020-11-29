import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PeopleRow extends StatelessWidget {
  final company;

  PeopleRow({Key key, this.company}) : super(key: key);

  final storageRef = FirebaseStorage();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.45,
                child: FutureBuilder<Object>(
                    future: storageRef
                        .ref()
                        .child("Team/" + company.addedByImage)
                        .getDownloadURL(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return CircleAvatar(
                          child: ClipOval(
                            child: Image.network(
                              snapshot.data,
                              fit: BoxFit.cover,
                            ),
                          ),
                          radius: 30.0,
                        );
                      return CommanWidgets().getCircularProgressIndicator();
                    }),
              ),
              Column(
                children: [
                  Text(
                    "Added By",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(company.addedByName),
                  Text(company.addedByPlace)
                ],
              )
            ],
          ),
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.5,
                child: FutureBuilder<Object>(
                    future: storageRef
                        .ref()
                        .child("Team/" + company.moderatorByImage)
                        .getDownloadURL(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return CircleAvatar(
                          child: ClipOval(
                            child: Image.network(
                              snapshot.data,
                              fit: BoxFit.cover,
                            ),
                          ),
                          radius: 30.0,
                        );
                      return CommanWidgets().getCircularProgressIndicator();
                    }),
              ),
              Column(
                children: [
                  Text(
                    "Moderated By",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(company.moderatorByName),
                  Text(company.moderatorByPlace)
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
