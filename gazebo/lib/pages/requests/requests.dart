import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "package:flutter_dotenv/flutter_dotenv.dart";
import "dart:convert";

Future<Map<String, dynamic>> get_home_digest() async {
  try {
    Uri uri = Uri.parse(dotenv.env["domain"]! + "/api/articles/digest");
    http.Response response = await http.get(uri);
    Map<String, dynamic> data = json.decode(response.body);
    if (data.containsKey("error")) {
      throw ErrorDescription(data["error"].toString());
    }
    return data["digest"];
  } catch (err) {
    //figure out what to return if response is invalid
    print("Error getting featured articles; $err");
    return {};
  }
}

Future<dynamic> get_genre(String genre) async {
  try {
    Uri uri = Uri.parse(dotenv.env["domain"]! + "/api/articles/$genre");
    http.Response response = await http.get(uri);
    Map<String, dynamic> data = json.decode(response.body);
    if (data.containsKey("error")) {
      throw ErrorDescription(data["error"].toString());
    }
    return data["${genre}_articles"];
  } catch (err) {
    //figure out what to return if response is invalid
    print("Error getting articles of genre $genre: $err");
    return [];
  }
}

Future<List<Map<String, dynamic>>> getFeaturedArticles() async {
  try {
    Uri uri = Uri.parse(dotenv.env["domain"]! + "/api/articles/featured");
    http.Response response = await http.get(uri);
    Map<String, dynamic> data = json.decode(response.body);
    if (data.containsKey("error")) {
      throw ErrorDescription(data["error"].toString());
    }
    return data["featured"];
  } catch (err) {
    //figure out what to return if response is invalid
    print("Error getting featured articles; $err");
    return [];
  }
}
