import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photovault/models/database.dart';

class Image {
  final String id;
  final String title;
  final String description;
  final String location;
  final File image;

  Image({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.location,
    @required this.image,});

}

class ImageFile with ChangeNotifier{

  List<Image> _items = [];

  List<Image> get items{
    return[..._items];
  }

  Future<void> addImagePlace(String title, String description, File image, String location) async {
    final newImage = Image(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        location: location,
        image: image
    );
    _items.add(newImage);
    notifyListeners();
    DataHelper.insert('user_image', {
      'id':newImage.id,
      'title':newImage.title,
      'description':newImage.description,
      'location':newImage.location,
      'image':newImage.image.path,
    });
  }

  Future<void> deleteImage(String id) async {
    await DataHelper.delete('user_image', id);
  }

  Image findImage(String imageId) {
    return _items.firstWhere((image) => image.id == imageId);
  }

  Future<void> fetchImage() async {
    final list = await DataHelper.getData('user_image');
    _items = list.map(
          (item) => Image(
            id: item['id'],
            title: item['title'],
            description: item['description'],
            location: item['location'],
            image: File(item['image']),
          ),
    ).toList();
    notifyListeners();
  }

}