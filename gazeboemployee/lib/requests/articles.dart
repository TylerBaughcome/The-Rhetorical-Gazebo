import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import "../utilities/localStorage.dart" as localStorage;
import "../googleapi/drive.dart";

Future<bool> _postArticle(Map<String, dynamic> fields) async {
  try {
    //parse data from google doc first => everything after first paragraph or title...
    List<dynamic> content = await loadDocumentContent(fields["googleDocId"]);
    Map<String, dynamic> final_fields = fields;
    final_fields["content"] = content;
    Uri uri = Uri.parse(dotenv.env["domain"]! + "/api/articles");
    String local_token =
        await localStorage.readFromLocalStorage("x-auth-token");
    http.Response response = await http.post(uri,
        body: json.encode({"fields": final_fields}),
        headers: {
          "x-auth-token": local_token,
          "Content-Type": "application/json"
        });
    print("Article post response: ${response.body}");
    if (json.decode(response.body).containsKey("error")) {
      throw ErrorDescription((json.decode(response.body)["error"].toString()));

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
