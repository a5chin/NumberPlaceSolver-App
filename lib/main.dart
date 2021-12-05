import 'dart:async';
import 'package:flutter/material.dart';
import 'model/image.dart';
import 'page/upload.dart';
import 'page/question.dart';
import 'page/result.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final List _pageWidgets = [
    UploadPage(),
    QuestionPage(),
    ResultPage(),
  ];

  late Future<Imagedata> futureImage;

  @override
  void initState() {
    super.initState();
    futureImage = fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'Number Place Solver';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: _pageWidgets.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.upload_file), label: 'Upload'),
            BottomNavigationBarItem(icon: Icon(Icons.question_answer), label: 'Question'),
            BottomNavigationBarItem(icon: Icon(Icons.panorama_fish_eye), label: 'Result'),
          ],
          currentIndex: _currentIndex,
          fixedColor: Colors.blueAccent,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
  void _onItemTapped(int index) => setState(() => _currentIndex = index );
}
