import 'package:atamnirbharapp/bloc/bugs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReportBug extends StatelessWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var _scafolldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final textEditingController = TextEditingController();
  final nameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[100],
        title: Text(
          "Report Bug/Error",
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
            Divider(),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                      keyboardType: TextInputType.text,
                      controller: emailEditingController,
                      autocorrect: true,
                      validator: (val) {
                        if (val.length == 0) {
                          return "Email cant empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Email Id",
                        fillColor: Colors.orange[50],
                        labelText: "Email Id",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black45),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                      keyboardType: TextInputType.text,
                      controller: nameEditingController,
                      autocorrect: true,
                      validator: (val) {
                        if (val.length == 0) {
                          return "Name cant be empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Name",
                        fillColor: Colors.orange[50],
                        labelText: "Name",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black45),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                      keyboardType: TextInputType.text,
                      controller: textEditingController,
                      autocorrect: true,
                      validator: (val) {
                        if (val.length == 0) {
                          return "Title cant be empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Title",
                        fillColor: Colors.orange[50],
                        labelText: "Title",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black45),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      controller: descriptionEditingController,
                      autocorrect: true,
                      validator: (val) {
                        if (val.length == 0) {
                          return "Description cant be empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Description",
                        fillColor: Colors.orange[50],
                        labelText: "Description",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black45),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
                onTap: () async {
                  if (formKey.currentState.validate()) {
                    var bug = Bug(
                      name: nameEditingController.text,
                      emailId: emailEditingController.text,
                      title: textEditingController.text,
                      description: descriptionEditingController.text,
                      timeAdded: DateTime.now().toString(),
                    );

                    await _firestore
                        .collection("bugs")
                        .add(bug.toJson())
                        .then((value) => {Navigator.pop(context)})
                        .catchError((error) =>
                            {print("error define here"), print(error)});
                  } else {}
                },
                child: Container(
                  child: Center(
                    child: Text(
                      "Report Bug",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 136),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  margin: EdgeInsets.all(20),
                ))
          ],
        ),
      ),
    );
  }
}
