import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NetworkHelper {
  Future getData(Uri url) async {
    //Response response = await get('https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}');

    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }
}
