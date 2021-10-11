import 'package:google_sign_in/google_sign_in.dart';
import "package:googleapis_auth/auth_io.dart";
import "package:http/http.dart" as http;
import "package:flutter_dotenv/flutter_dotenv.dart";
import "../utilities/localStorage.dart" as localStorage;

void saveTokenToLocalStorage() {
  var clientId = dotenv.env["GOOGLE_CLIENT_ID"];
  var id = ClientId(clientId!, "...");
  var scopes = [
    "https://www.googleapis.com/auth/documents",
    "https://www.googleapis.com/auth/drive"
  ];
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: scopes);

  _googleSignIn.signIn().then((result) {
    result!.authentication.then((googleKey) async {
      print("Google token: ${googleKey.accessToken}");
      await localStorage.writeToLocalStorage(
          "google_access_token", googleKey.accessToken);
    }).catchError((err) {
      print('Error authenticating google: $err');
    });
  }).catchError((err) {
    print('Error with google authentication api: $err');
  });
}
