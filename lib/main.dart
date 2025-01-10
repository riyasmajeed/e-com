import 'package:comm/view/bannersileder.dart';
import 'package:comm/view/home.dart';
import 'package:comm/view/loginpage.dart';
import 'package:comm/view/mainhomepage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Mainhomepage(),
    );
  }
}
