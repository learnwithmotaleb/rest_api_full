import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/ComplexModel.dart';

class HomePageComplex2 extends StatefulWidget {
  const HomePageComplex2({super.key});

  @override
  State<HomePageComplex2> createState() => _HomePageComplex2State();
}

class _HomePageComplex2State extends State<HomePageComplex2> {
  Future<ComplexModel> getComplexAPI() async {
    final response = await http.get(
        Uri.parse("https://webhook.site/ea3569cc-876f-4901-aecc-faf2430c94c2"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ComplexModel.fromJson(data);
    } else {
      return ComplexModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Complex API"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder<ComplexModel>(
              future: getComplexAPI(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.batters!.batter!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          subtitle:Text(snapshot.data!.batters!.batter![index].type.toString()) ,
                          trailing:Text(snapshot.data!.batters!.batter![index].id.toString()) ,
                          title:Text(snapshot.data!.topping![index].type.toString()) ,
                          leading:Text(snapshot.data!.topping![index].id.toString()) ,
                        );
                      });
                }
              },
            )),
            Expanded(
                child: FutureBuilder<ComplexModel>(
              future: getComplexAPI(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.topping!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [Text(index.toString())],
                        );
                      });
                }
              },
            )),
          ],
        ));
  }
}
