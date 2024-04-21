import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/PhotosModels.dart';


class HomePageWithoutModel extends StatefulWidget {
  const HomePageWithoutModel({super.key});

  @override
  State<HomePageWithoutModel> createState() => _HomePageWithoutModelState();
}

class _HomePageWithoutModelState extends State<HomePageWithoutModel> {
  List<PhotosModels> photoList = [];

  Future<List<PhotosModels>> getPhotoAPI() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        // Photos photos = Photos(
        //     id: i["id"],
        //     title: i["title"],
        //     url: i["url"],);
        photoList.add(PhotosModels.fromJson(i));
      }

      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photos API"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<List<PhotosModels>>(
            future: getPhotoAPI(),
            builder: (BuildContext context, AsyncSnapshot<List<PhotosModels>> snapshot) {
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else{
                return ListView.builder(
                  itemCount: photoList.length,
                    itemBuilder: (context,index){
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data![index].title.toString()),
                      subtitle: Text(snapshot.data![index].id.toString()),
                      leading: CircleAvatar(
                        backgroundImage:NetworkImage(
                            snapshot.data![index].url.toString()
                        ) ,
                      ),
                      trailing: TextButton(
                        onPressed: (){},
                        child: Text("Follow"),
                      ),
                    ),
                  );

                });
              }

            },
          ))
        ],
      ),
    );
  }
}

class Photos {
  String title, url;
  int id;

  Photos({required this.title, required this.url, required this.id});
}
