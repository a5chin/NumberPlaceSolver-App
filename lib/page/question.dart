import 'package:flutter/material.dart';
import '../model/image.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<QuestionPage> {
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
            return Image.network('http://127.0.0.1:8000/images/${snapshot.data!.title}.png', width: 250);

          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
