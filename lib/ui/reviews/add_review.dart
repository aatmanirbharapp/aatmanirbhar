import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/http/faqrequest.dart';
import 'package:atamnirbharapp/ui/reviews/star_field.dart';
import 'package:flutter/material.dart';

class AddReview extends StatefulWidget {
  final Company object;
  final String username;
  final String uid;

  AddReview(this.object, this.uid, this.username);

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final formKey = GlobalKey<FormState>();

  final textEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();

  final _httpReq = SqlResponse();

  double rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[100],
        title: Text(
          "Add Review" + widget.object.companyId,
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
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: StarRating(
                        color: Color.fromARGB(255, 0, 0, 136),
                        rating: rating,
                        onRatingChanged: (rating) =>
                            setState(() => this.rating = rating),
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
                  if (formKey.currentState.validate() && rating <= 0.0) {
                    await _httpReq.addRating(
                        widget.uid,
                        "0",
                        widget.object.id,
                        rating,
                        DateTime.now().toString(),
                        textEditingController.text,
                        descriptionEditingController.text,
                        widget.username);
                  } else {}
                },
                child: Container(
                  child: Center(
                    child: Text(
                      "Add review",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.orange[100], Colors.green[100]],
                    ),
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
