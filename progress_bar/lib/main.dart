import 'dart:async';

import 'package:flutter/material.dart';
import 'package:progress_bar/drawView.dart';
import 'package:progress_bar/imageView.dart';
import 'package:progress_bar/listView.dart';
import 'package:progress_bar/textView.dart';

StreamController<bool> isLightTheme = StreamController();

void main() {
  runApp(SampleApp());
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: false,
      stream: isLightTheme.stream,
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'Sample App',
          theme: setTheme(snapshot.data),
          home: SampleAppPage(),
        );
      },
    );
  }

  setTheme(bool isLight) {
    if (isLight) {
      return ThemeData(
          primarySwatch: Colors.purple, brightness: Brightness.dark);
    } else {
      return ThemeData(
          primarySwatch: Colors.blue, brightness: Brightness.light);
    }
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<String> widgets = [];
  bool isLight = false;

  @override
  void initState() {
    super.initState();
    addItemToWidgets();
  }

  showLoadingDialog() {
    return widgets.length == 0;
  }

  addItemToWidgets() {
    widgets.add('List View With Progress');
    widgets.add('Image View');
    widgets.add('Draw View');
    widgets.add('Text Edit View');
  }

  getBody() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: getListView(),
          ),
          Switch(
            value: isLight,
            onChanged: (value) {
              setState(() {
                isLight = value;
                isLightTheme.add(value);
              });
            },
          ),
          Text('isLight: $isLight'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sample App"),
        ),
        body: getBody());
  }

  ListView getListView() => ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  Widget getRow(int i) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Text('Function ${i + 1} ${widgets[i]}'),
              onPressed: () {
                getFunction(i);
              },
            ),
          ),
        ],
      ),
    );
  }

  getFunction(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListViewSample()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ImageViewSample()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DrawViewSample()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TextEditViewSample()),
        );
        break;
      default:
        break;
    }
  }
}
