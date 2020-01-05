
import 'dart:convert';

import 'package:http/http.dart' as http; // Must include http package in your pubspec.yaml

void main() async {

  final clientID = "br.com.desenroladev.fila.app";
  final body = "username=niel&password=niel&grant_type=password";

  // Note the trailing colon (:) after the clientID.
  // A client identifier secret would follow this, but there is no secret, so it is the empty string.
  final clientCredentials = Base64Encoder().convert("$clientID:".codeUnits);

  print("Basic: " + clientCredentials);

final response = await http.post(
  "http://localhost:8888/auth/token",
  headers: {
    "Content-Type": "application/x-www-form-urlencoded",
    "Authorization": "Basic $clientCredentials"
  },
  body: body);

  print(response.body);

}