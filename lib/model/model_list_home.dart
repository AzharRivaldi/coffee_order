import 'dart:convert';

import 'package:http/http.dart' as http;

class ModelListHome {
  String? name;
  String? image_url;
  String? flavor_profile;
  String? price;
  String? description;

  ModelListHome({this.name, this.image_url, this.flavor_profile, this.price, this.description});

  ModelListHome.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    image_url = json['image_url'].toString();
    flavor_profile = json['flavor_profile'].toString();
    price = json['price'].toString();
    description = json['description'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['image_url'] = this.image_url;
    data['flavor_profile'] = this.flavor_profile;
    data['price'] = this.price;
    data['description'] = this.description;
    return data;
  }

  static Future<List<ModelListHome>> getListData() async {
    var apiURL = Uri.parse('https://fake-coffee-api.vercel.app/api');
    final jsonData = await http.get(apiURL);
    List list = jsonDecode(jsonData.body);
    return list.map((e) => ModelListHome.fromJson(e)).toList();
  }

  static Future<List<ModelListHome>> getListDataAsc() async {
    var apiURL = Uri.parse('https://fake-coffee-api.vercel.app/api?sort=asc');
    final jsonData = await http.get(apiURL);
    List list = jsonDecode(jsonData.body);
    return list.map((e) => ModelListHome.fromJson(e)).toList();
  }

}