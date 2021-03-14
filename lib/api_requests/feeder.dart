import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

String host = GlobalConfiguration().getString("Host");

Future<List<dynamic>> fetchFeeders() async {
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "Token");
  Map<String, String> requestHeaders = {'Authorization': token};
  // Get hubs
  final hubsResponse = await http.get(host + '/hubs/', headers: requestHeaders);
  if (hubsResponse.statusCode == 200) {
    Map<String, dynamic> hubs = json.decode(hubsResponse.body);
    List<dynamic> finalFeeders = [];
    // For each hub id, fetch feeders
    for (var hubJson in hubs["results"]) {
      int hubId = hubJson["id"];
      final feedersResponse = await http.get(host + '/hubs/$hubId/feeders/',
          headers: requestHeaders);
      if (feedersResponse.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        Map<String, dynamic> feeders = json.decode(feedersResponse.body);
        finalFeeders.addAll(feeders["results"]);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load feeders');
      }
    }
    return finalFeeders;
    // return finalFeeders response
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load hubs');
  }
}
