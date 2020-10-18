import 'package:flutter/material.dart';

class MiddleRow extends StatelessWidget {
  const MiddleRow({
    Key key,
  }) : super(key: key);

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
              child: Image.asset("assets/images/MakesInIndia_Logo.png"),
            ),
            Text("Made In India")
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
              child: Image.asset("assets/images/PreferThis.png"),
            ),
            Text("Prefer This")
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
              child: Image.asset("assets/images/Indian_Flag.png"),
            ),
            Text("Indian")
          ],
        ),
      ],
    );
  }
}
