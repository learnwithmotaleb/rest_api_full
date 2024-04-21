import 'dart:convert';

import 'package:api/Covid19Project/services/utilitis/app_url.dart';
import 'package:http/http.dart' as http;

import '../model/WorldStateModel.dart';

class StateServices{

  Future<WorldStateModel> fechtWorldState()async{

    final response = await http.get(Uri.parse(AppUrl.worldStateAPI));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      print(data);
      return WorldStateModel.fromJson(data);

    }else{
      throw Exception("error");
    }




  }

  Future<List<dynamic>> countryList()async{

    var data;

    final response = await http.get(Uri.parse(AppUrl.countryListAPI));

    if(response.statusCode == 200){
       data = jsonDecode(response.body.toString());
      print(data);
      return data;

    }else{
      throw Exception("error");
    }




  }


}