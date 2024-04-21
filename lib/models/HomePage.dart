import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'PostModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List<PostModel> postList = [];

  Future<List<PostModel>> getPostApi()async{

    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      postList.clear();
      for(Map<String, dynamic> i in data) {
        postList.add(PostModel.fromJson(i));

      }
      return postList;
    }else{
      return postList;
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest_API"),
        centerTitle: true,
      ),
      body: Column(
       children: [
         Expanded(
           child: FutureBuilder(
               future: getPostApi(),
               builder: (context, snapshot){
                 if(!snapshot.hasData){
                   return Center(child: Text("Loading"),);
                 }else{
                   return ListView.builder(
                     itemCount: postList.length,
                       itemBuilder: (context, index){
                       return Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Card(
                           child: ListTile(
                             title: Text(postList[index].title.toString()),
                             subtitle: Text(postList[index].body.toString()),
                             leading: Text(postList[index].userId.toString()),
                             trailing: Text(postList[index].id.toString()),
                           ),
                         ),
                       );
                       }
                   );
           
                 }
           
               }
           
           ),
         )
       ],
      ),
    );
  }
}
