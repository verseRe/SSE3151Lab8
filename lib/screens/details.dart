import 'package:flutter/material.dart';
import 'package:photovault/models/classes.dart' as img;
import 'package:photovault/screens/app.dart';
import 'package:provider/provider.dart';
import 'package:commons/alert_dialogs.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = 'DetailsScreen';

  Future<bool> confirmation(BuildContext context) async {
    bool confirm = false;
    await confirmationDialog(
        context,
        "The photo will be lost forever",
        title: "Would you like to delete this photo ?",
        neutralText: "No",
        positiveText: "Yes",
        positiveAction: () {
          confirm = true;
          },
    );
    return confirm;
  }

  @override
  Widget build(BuildContext context) {
    final imageId = ModalRoute.of(context).settings.arguments as String;
    final image =
        Provider.of<img.ImageFile>(context, listen: false).findImage(imageId);
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text(image.title),
        backgroundColor: Colors.white10,
        actions: [
          IconButton(icon: Icon(Icons.delete_outline_rounded), onPressed: () async {
            bool temp = await confirmation(context);
            print(temp);
            if (temp) {
              Provider.of<img.ImageFile>(context, listen: false).deleteImage(imageId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TheApp(),
                ),
              );
            }
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Image.file(
                image.image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,),
              child: Text(
                image.title,
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "Description : " + image.description,
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Date : " + image.id.substring(0,10),
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Time : " + image.id.substring(11,16),
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Location : " + image.location,
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
