import 'package:flutter/material.dart';
import 'package:planets/ui/home/HomePage.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Planets',
    home: new HomePage(),
    // routes: <String, WidgetBuilder>{
    //   '/detail': (_) =>  DetailPage(),
    // },
  ));
}