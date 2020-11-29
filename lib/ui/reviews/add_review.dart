import 'package:atamnirbharapp/ui/components/alternate_company_header.dart';
import 'package:flutter/material.dart';

class AddReview extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[100],
        title: Text(
          "Add Review",
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
        child: Column(
          children: [
            AlternateCompanyHeader(),
            Divider(),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
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
                      prefixIcon: Icon(
                        Icons.call,
                        color: Colors.grey,
                      ),
                      hintText: "Title",
                      fillColor: Colors.orange[50],
                      labelText: "Title",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black45),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  TextFormField(
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.text,
                    controller: textEditingController,
                    autocorrect: true,
                    validator: (val) {
                      if (val.length == 0) {
                        return "Description cant be empty";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.call,
                        color: Colors.grey,
                      ),
                      hintText: "Description",
                      fillColor: Colors.orange[50],
                      labelText: "Description",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black45),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
