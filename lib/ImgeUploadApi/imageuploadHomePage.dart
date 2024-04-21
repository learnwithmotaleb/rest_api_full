import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'image_upload_api.dart';
import 'model/getImageApi.dart';

class HomePageForImage extends StatefulWidget {
  const HomePageForImage({super.key});

  @override
  State<HomePageForImage> createState() => _HomePageForImageState();
}

class _HomePageForImageState extends State<HomePageForImage> {
  Future<GetImageApi> getImageApi() async {
    final response = await http
        .get(Uri.parse("https://image.learnwithmotaleb.com/api/products"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(data.toString());
      return GetImageApi.fromJson(data);
    } else {
      return GetImageApi.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBar"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getImageApi(),
              builder: (context, AsyncSnapshot<GetImageApi>snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("Loading"),
                  );
                }else {
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index){
                      return  ListTile(
                        title: Text(snapshot.data!.data![index].name.toString()),
                        leading: Container(
                          width: 100,
                          height: 50,
                          child: Image.network(snapshot.data!.data![index].image.toString())
                        
                        ),
                      );
                      }
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ImageUploadRestAPI()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
