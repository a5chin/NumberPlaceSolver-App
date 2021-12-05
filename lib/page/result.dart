import 'package:flutter/material.dart';
import '../model/image.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<ResultPage> {
  late Future<Imagedata> futureImage;

  @override
  void initState() {
    futureImage = fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Center(
      child: FutureBuilder<Imagedata>(
        future: futureImage,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Image.network('http://127.0.0.1:8000/images/result.png', width: 250);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
