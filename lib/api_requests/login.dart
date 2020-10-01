import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

String host = GlobalConfiguration().getString("Host");
final storage = FlutterSecureStorage();

Future<bool> login(String username, String password) async {
  Map<String, String> postToken = {"username": username, "password": password};
  final response = await http.post(
    host + '/api-token-auth/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(postToken),
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    await storage.write(key: "Token", value: "Token " + jsonResponse["token"]);
    return true;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return false;
//    throw Exception('Failed to login');
  }
}
