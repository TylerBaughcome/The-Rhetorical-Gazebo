import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import "../utilities/localStorage.dart" as localStorage;
import "../googleapi/drive.dart";

Future<bool> _postArticle(Map<String, dynamic> fields) async {
  try {
    //parse data from google doc first => everything after first paragraph or title...
    await parseDocument(fields["googleDocId"]);
    return true;
    Uri uri = Uri.parse(dotenv.env["domain"]! + "/api/articles");
    String local_token =
        await localStorage.readFromLocalStorage("x-auth-token");
    http.Response response = await http.post(uri,
        body: json.encode({"fields": fields}),
        headers: {
          "x-auth-token": local_token,
          "Content-Type": "application/json"
        });
    print("Article post response: ${response.body}");
    if (json.decode(response.body).containsKey("error")) {
      throw ErrorDescription(json.decode(response.body)["error"]);
    }
    return true;
  } catch (err) {
    print("Error uploading article: $err");
    return false;
  }
}

Future<bool> postArticles(Map<String, Map<String, dynamic>> fields) async {
  try {
    for (var i in fields.values) {
      bool success = await _postArticle(i);
      if (!success) {
        return false;
      }
    }
    return true;
  } catch (err) {
    print("Error uploading article: $err");
    return false;
  }
}
