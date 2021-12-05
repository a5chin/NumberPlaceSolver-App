import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Imagedata> fetchImage() async {
  final response = await http.get(Uri.parse('http://localhost:8000/images/example/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Imagedata.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load imagedata');
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

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Imagedata> futureImage;

  @override
  void initState() {
    super.initState();
    futureImage = fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Imagedata>(
            future: futureImage,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Image.asset('${snapshot.data!.path}');
              } else if (snapshot.hasError) {
                return Text('${snapshot.data}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
