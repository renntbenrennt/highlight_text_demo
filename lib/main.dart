import 'package:flutter/material.dart';
import 'package:text_span_thousands/highlight_text/hightlight_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Highlight Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Highlight Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Data {
  final String value;
  final String style;

  Data({this.value, this.style});
}

class _MyHomePageState extends State<MyHomePage> {
  List<Data> data = [
    Data(
        value:
            'But I must explain to you how all this mistaken idea of denouncing'
            ' pleasure and praising pain was born and I will give you a complete'
            ' account of the system, and expound the actual teachings of the great'
            ' explorer of the truth, the master-builder of human happiness. '),
    Data(
      value: 'No one rejects, dislikes, or avoids pleasure itself, ',
      style: 'bold',
    ),
    Data(
        value: 'because it is pleasure, but because those who do not know '
            'how to pursue pleasure rationally encounter consequences',
        style: 'italic'),
    Data(value: ' that are extremely painful.')
  ];

  TextStyle getStyleValue(String style) {
    switch (style) {
      case 'bold':
        return TextStyle(fontWeight: FontWeight.bold);
      case 'italic':
        return TextStyle(fontStyle: FontStyle.italic);
      default:
        return TextStyle(fontStyle: FontStyle.normal);
    }
  }

  List<TextSpan> destructData(List<Data> data) {
    List<TextSpan> res = [];
    for (final d in data) {
      final style = d.style;
      for (final s in d.value.split('')) {
        res.add(
          TextSpan(
            text: s,
            style: (style == null) ? TextStyle() : getStyleValue(style),
          ),
        );
      }
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: HighlightText(
            spans: destructData(data),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
