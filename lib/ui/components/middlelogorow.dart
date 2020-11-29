import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MiddleRow extends StatelessWidget {
  final company;
  const MiddleRow({Key key, this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.15,
              width: MediaQuery.of(context).size.width * 0.15,
              margin: EdgeInsets.only(left: 25, right: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: company.firstCountry.contains("India")
                  ? Image.asset("assets/images/MakesInIndia_Logo.png")
                  : Image.asset("assets/images/Imported_Icon.png"),
            ),
            company.firstCountry.contains("India")
                ? RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Makes ",
                        children: [
                          TextSpan(
                              text: "In India",
                              style: TextStyle(color: Colors.green))
                        ],
                        style: TextStyle(color: Colors.orange)),
                  )
                : RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Imported", style: TextStyle(color: Colors.red)),
                  )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.15,
              width: MediaQuery.of(context).size.width * 0.15,
              margin: EdgeInsets.only(left: 25, right: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: company.firstCountry.contains("India")
                  ? Image.asset("assets/images/PreferThis.png")
                  : Image.asset("assets/images/alternatives_icon.png"),
            ),
            company.firstCountry.contains("India")
                ? RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Prefer ",
                        children: [
                          TextSpan(
                              text: "This",
                              style: TextStyle(color: Colors.green))
                        ],
                        style: TextStyle(color: Colors.orange)),
                  )
                : RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Prefer Alternatives ",
                        style: TextStyle(color: Colors.red)),
                  )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.15,
              width: MediaQuery.of(context).size.width * 0.15,
              margin: EdgeInsets.only(left: 25, right: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: company.firstCountry.contains("India")
                  ? Image.asset("assets/images/Indian_Flag.png")
                  : FutureBuilder<Object>(
                      future: FirebaseStorage.instance
                          .ref()
                          .child("Country_Flags/flag-of-" +
                              company.firstCountry +
                              ".png")
                          .getDownloadURL(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return ClipOval(
                            child: Image.network(
                              snapshot.data,
                              fit: BoxFit.fill,
                            ),
                          );
                        return CommanWidgets().getCircularProgressIndicator();
                      }),
            ),
            Text(
              company.firstCountry,
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 128)),
            )
          ],
        ),
      ],
    );
  }
}
