import 'package:flutter/material.dart';
import 'package:photovault/widgets/image_input.dart';
import 'package:photovault/widgets/location_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:photovault/models/classes.dart';

class AddImage extends StatefulWidget {
  static const routeName = '';
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  File savedImage;
  String imageLocation;

  void savedImages(File image) {
    savedImage = image;
  }

  void savedLocation(String location) {
    imageLocation = location;
  }

  void onSave() {
    if(_titleController.text.isEmpty || _descController.text.isEmpty || savedImage == null) {
      return;
    }
    else {
      if (imageLocation == null) imageLocation = "No Location";
      Provider.of<ImageFile>(context,listen: false).addImagePlace(_titleController.text, _descController.text, savedImage, imageLocation);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: Text("Add New Image"),
        backgroundColor: Colors.white10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageInput(savedImages),
              SizedBox(height: 50),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30,),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _descController,
                decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                ),
              ),
              SizedBox(height: 30,),
              LocationInput(savedLocation),
              Padding(
                padding: const EdgeInsets.only(left: 250, top: 30),
                child: TextButton(
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: onSave,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
