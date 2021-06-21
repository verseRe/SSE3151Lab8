import 'package:flutter/material.dart';
import 'package:photovault/screens/details.dart';
import 'package:photovault/screens/home.dart';
import 'package:photovault/widgets/image_add.dart';
import 'package:provider/provider.dart';
import 'package:photovault/models/classes.dart';

class TheApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx)=>ImageFile(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        routes: {
          AddImage.routeName:(ctx)=>AddImage(),
          DetailsScreen.routeName: (ctx)=>DetailsScreen(),
        },
      ),
    );
  }
}