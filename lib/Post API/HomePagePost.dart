import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomePagePost extends StatefulWidget {
  const HomePagePost({super.key});

  @override
  State<HomePagePost> createState() => _HomePagePostState();
}

class _HomePagePostState extends State<HomePagePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Post Api"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Loading"),
      ),

    );
  }
}
