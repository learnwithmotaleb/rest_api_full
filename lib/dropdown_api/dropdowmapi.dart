import 'dart:convert';
import 'dart:io';

import 'package:api/dropdown_api/model/PostModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DropdwonAPI extends StatefulWidget {
  const DropdwonAPI({super.key});

  @override
  State<DropdwonAPI> createState() => _DropdwonAPIState();
}

class _DropdwonAPIState extends State<DropdwonAPI> {


  Future<List<PostModel>> getPostApi()async{
    try{
      final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      final body = jsonDecode(response.body) as List;
      if(response.statusCode == 200){
        
        return body.map((e){
          final map = e as Map<String,dynamic>;
          return PostModel(
            id: map['id'],
            userId: map['userId'],
            title: map['title'],
            body: map['body'],
          );
        }).toList();

      }

    }on SocketException {
      throw Exception("No Internet Exception!");

    }
    throw Exception("Error fetching Data");
    

  }

  var selectedValue;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DropdwonAPI"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<List<PostModel>>(
                  future: getPostApi(),
                  builder: (context,AsyncSnapshot<List<PostModel>>snapshot){
                    if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else{
                      return DropdownButton(
                        isExpanded: true,
                        icon: Icon(Icons.more_vert),
                        hint: Text("Choose Data"),
                          value: selectedValue,
                          items: snapshot.data!.map((e){
                            return DropdownMenuItem(
                              value: e.id.toString(),
                                child: Text(e.title.toString())
                            );

                          }).toList(),
                          onChanged: (value){
                          selectedValue = value;
                          setState(() {

                          });
                          }
                      );

                    }

                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
