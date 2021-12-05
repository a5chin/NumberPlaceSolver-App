import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Imagedata> fetchImage() async {
  final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/images/example/')
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Imagedata.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load image data');
  }
}

class Imagedata {
  final String title;
  final String path;

  Imagedata({
    required this.title,
    required this.path,
  });

  factory Imagedata.fromJson(Map<String, dynamic> json) {
    return Imagedata(
      title: json['title'],
      path: json['path'],
    );
  }
}
