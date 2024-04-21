import 'package:flutter/material.dart';


import 'ComplexJson/HomePage.dart';
import 'Covid19Project/veiw/splash_screen.dart';
import 'ImgeUploadApi/imageuploadHomePage.dart';
import 'Post API/HomePagePost.dart';
import 'Post API/Signup.dart';
import 'Post API/imageUploadAPI.dart';
import 'Post API/login.dart';
import 'complex2/HomePage.dart';
import 'dropdown_api/dropdowmapi.dart';
import 'models/HomePage.dart';
import 'Non_models/Homeapage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid 19',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        useMaterial3: false,
      ),
      home:  HomePageForImage(),
    );
  }
}
