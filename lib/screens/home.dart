import 'package:flutter/material.dart';
import 'package:photovault/screens/details.dart';
import 'package:photovault/widgets/image_add.dart';
import 'package:provider/provider.dart';
import 'package:photovault/models/classes.dart' as img;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddImage.routeName);
        },
        backgroundColor: Colors.white10,
        child: Icon(Icons.camera),
      ),
      appBar: AppBar(
          backgroundColor: Colors.white10,
          title: Text("PhotoVault",
              style: TextStyle(
                color: Colors.white,
              )
          )
      ),
      body: FutureBuilder(
        future: Provider.of<img.ImageFile>(context, listen: false).fetchImage(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting ?
            Center(
              child: CircularProgressIndicator(),
            ):
            Consumer<img.ImageFile>(
            child: Center(
              child: Text(
                'Sad gallery :"(',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            builder: (ctx, image, ch) => image.items.length <= 0
                ? ch
                : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridTile(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, DetailsScreen.routeName, arguments: image.items[i].id);
                      },
                      child: Image.file(
                        image.items[i].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  footer: GridTileBar(
                    leading: Column(
                      children: [
                        Text(
                          image.items[i].title,
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.white),
                        ),
                      ],
                    ),
                    title: Text(' '),
                  ),
                ),
              ),
              itemCount: image.items.length,
            )),
      )
    );
  }
}
