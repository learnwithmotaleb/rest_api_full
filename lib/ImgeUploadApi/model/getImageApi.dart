import 'dart:convert';
/// status : true
/// message : "Product Retrieved"
/// data : [{"id":1,"name":"abc","image":"images/1713530383.png","created_at":"2024-04-19T12:39:44.000000Z","updated_at":"2024-04-19T12:39:44.000000Z"},{"id":2,"name":"abcd","image":"images/1713530428.png","created_at":"2024-04-19T12:40:28.000000Z","updated_at":"2024-04-19T12:40:28.000000Z"},{"id":3,"name":"abc1","image":"images/1713530462.png","created_at":"2024-04-19T12:41:02.000000Z","updated_at":"2024-04-19T12:41:02.000000Z"},{"id":4,"name":"abc1","image":"images/1713530473.png","created_at":"2024-04-19T12:41:13.000000Z","updated_at":"2024-04-19T12:41:13.000000Z"},{"id":5,"name":"abc1","image":"images/1713530475.png","created_at":"2024-04-19T12:41:15.000000Z","updated_at":"2024-04-19T12:41:15.000000Z"},{"id":6,"name":"calender","image":"images/1713678473.jpg","created_at":"2024-04-21T05:47:53.000000Z","updated_at":"2024-04-21T05:47:53.000000Z"},{"id":7,"name":"cde","image":"images/1713678854.jpg","created_at":"2024-04-21T05:54:14.000000Z","updated_at":"2024-04-21T05:54:14.000000Z"}]

GetImageApi getImageApiFromJson(String str) => GetImageApi.fromJson(json.decode(str));
String getImageApiToJson(GetImageApi data) => json.encode(data.toJson());
class GetImageApi {
  GetImageApi({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetImageApi.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
GetImageApi copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetImageApi(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name : "abc"
/// image : "images/1713530383.png"
/// created_at : "2024-04-19T12:39:44.000000Z"
/// updated_at : "2024-04-19T12:39:44.000000Z"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      String? name, 
      String? image, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  num? id,
  String? name,
  String? image,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  image: image ?? _image,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get name => _name;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}