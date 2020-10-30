import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerClass extends StatefulWidget {
  final ValueChanged<String> image;

  const ImagePickerClass({Key key, this.image}) : super(key: key);

  @override
  _ImagePickerClassState createState() => _ImagePickerClassState();
}

class _ImagePickerClassState extends State<ImagePickerClass> {
  PickedFile image;

  _imgFromCamera() async {
    image = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      widget.image(image.path);
      storeImage();
    });
  }

  _imgFromGallery() async {
    image = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      widget.image(image.path);
      storeImage();
    });
  }

  Future storeImage() async {
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(image.path);
    if (firebaseStorageRef.putFile(File(image.path)).isComplete) {
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Error Uploading image"),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 5,
      content: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Upload Using gallery"),
              onTap: () {
                _imgFromGallery();
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Take picture"),
              onTap: () {
                _imgFromCamera();
              },
            )
          ],
        ),
      ),
    );
  }
}
