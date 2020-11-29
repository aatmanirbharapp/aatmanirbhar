import 'package:flutter/material.dart';

class AllReview extends StatelessWidget {
  final object;

  const AllReview({Key key, @required this.object});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[100],
        title: Text(
          "All Reviews",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 136)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 0, 0, 136),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reviews and Ratings",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "WRITE A REVIEW",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    color: Color.fromARGB(255, 0, 0, 136),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              height: 130,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Average Rating"),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 0, 0, 136),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 1)),
                            height: 40,
                            width: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("4.2",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text("Total 46 Ratings")
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("5",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600])),
                                Icon(
                                  Icons.star,
                                  color: Color.fromARGB(255, 0, 0, 136),
                                  size: 12,
                                ),
                              ],
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.5 - 80,
                              height: 5,
                              child: LinearProgressIndicator(
                                value: 10,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                "54%",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("4",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600])),
                                Icon(
                                  Icons.star,
                                  color: Color.fromARGB(255, 0, 0, 136),
                                  size: 12,
                                ),
                              ],
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.5 - 80,
                              height: 5,
                              child: LinearProgressIndicator(
                                value: 10,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                "54%",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("3",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600])),
                                Icon(
                                  Icons.star,
                                  color: Color.fromARGB(255, 0, 0, 136),
                                  size: 12,
                                ),
                              ],
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.5 - 80,
                              height: 5,
                              child: LinearProgressIndicator(
                                value: 10,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                "54%",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("2",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600])),
                                Icon(
                                  Icons.star,
                                  color: Color.fromARGB(255, 0, 0, 136),
                                  size: 12,
                                ),
                              ],
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.5 - 80,
                              height: 5,
                              child: LinearProgressIndicator(
                                value: 10,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                "54%",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("1",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600])),
                                Icon(
                                  Icons.star,
                                  color: Color.fromARGB(255, 0, 0, 136),
                                  size: 12,
                                ),
                              ],
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.5 - 80,
                              height: 5,
                              child: LinearProgressIndicator(
                                value: 10,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                "54%",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height,
              child: ListView(children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all()),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Yash Agrawal",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 0, 0, 136),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(width: 1)),
                                    height: 25,
                                    width: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("4.2",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                        Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text("09 OCT,20")
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Title",
                              textAlign: TextAlign.left,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                "Aatamanirbhar app is desinged by yash agrawal and developed by yash agrawal ",
                                overflow: TextOverflow.visible,
                                maxLines: null,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
