import 'package:gazeboemployee/utilities/localStorage.dart';
import "package:http/http.dart" as http;
import "./utils.dart";
import "dart:convert";

Future<dynamic> getAllDocuments() async {
  try {
    String query =
        querystring({"q": "mimeType='application/vnd.google-apps.document'"});
    var url = Uri.parse("https://www.googleapis.com/drive/v3/files?" + query);
    var token = await readFromLocalStorage("google_access_token");
    var testResponse =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    return json.decode(testResponse.body)["files"];
  } catch (err) {
    print("Error retrieving documents from google drive: $err");
    return null;
  }
}

Future<String> parseDocument(googleDocId) async {
  var url = Uri.parse("https://docs.googleapis.com/v1/documents/$googleDocId");
  var token = await readFromLocalStorage("google_access_token");
  var response =
      await http.get(url, headers: {"Authorization": "Bearer $token"});
  var document = json.decode(response.body);
  print("Document data: ${document["body"]["content"][0]}");
  return "";
}
