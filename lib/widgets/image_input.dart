import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function imagesaveat;
  ImageInput(this.imagesaveat);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _imageFile;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
        source: ImageSource.camera,
        maxWidth: 600
    );
    if(imageFile == null) {
      return;
    }
    setState(() {
      _imageFile = File(imageFile.path);
    });

    final apDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveImagepath = await _imageFile.copy('${apDir.path}/$fileName');

    widget.imagesaveat(saveImagepath);

  }

  Future<void> _importPicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
        source: ImageSource.gallery,
        maxWidth: 600
    );
    if(imageFile == null) {
      return;
    }
    setState(() {
      _imageFile = File(imageFile.path);
    });

    final apDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveImagepath = await _imageFile.copy('${apDir.path}/$fileName');

    widget.imagesaveat(saveImagepath);

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            border:  Border.all(width: 2, color: Colors.grey)
          ),
          child: _imageFile != null ?
          Image.file(
            _imageFile,
            fit:BoxFit.cover,
          ):
          Center(
              child: Text(
                "No Image",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
          ),
        ),
        SizedBox(width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _importPicture,
              icon: Icon(Icons.image),
              label: Text("Import image"),
            ),
            TextButton.icon(
              onPressed: _takePicture,
              icon: Icon(Icons.camera_alt),
              label: Text("Take picture"),
            ),
          ],
        ),
      ],
    );
  }
}

