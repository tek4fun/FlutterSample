import 'dart:async';

import 'package:flutter/material.dart';
import 'package:progress_bar/bloc/main_bloc.dart';
import 'package:progress_bar/event/main_event.dart';
import 'package:progress_bar/state/main_state.dart';
import '../page/drawView.dart';
import '../page/imageView.dart';
import '../page/listView.dart';
import '../page/textView.dart';

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
  final bloc = MainBloc();
  bool isLight = false;

  @override
  void initState() {
    super.initState();
    //addItemToWidgets();
  }

  addItemToWidgets() async {
    bloc.eventController.sink.add(AddPage('List View With Progress'));
    await Future.delayed(Duration(seconds: 1));
    bloc.eventController.sink.add(AddPage('Image View'));
    await Future.delayed(Duration(seconds: 2));
    bloc.eventController.sink.add(AddPage('Draw View'));
    await Future.delayed(Duration(seconds: 3));
    bloc.eventController.sink.add(AddPage('Text Edit View'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sample App"),
        ),
        body: getBody(),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "btnAdd",
              child: Icon(Icons.add),
              onPressed: () {
                addItemToWidgets();
              },
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              heroTag: "btnRemove",
              child: Icon(Icons.remove),
              onPressed: () {
                bloc.eventController.sink.add(RemovePage());
              },
            ),
          ],
        ));
  }

  Widget getBody() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: getListViewWithStream(),
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

  Widget getListViewWithStream() {
    return StreamBuilder<MainState>(
      initialData: bloc.state,
      stream: bloc.stateController.stream,
      builder: (BuildContext context, AsyncSnapshot<MainState> snapshot) {
        return getListView(snapshot.data.widgets);
      },
    );
  }

  ListView getListView(List<String> widgets) => ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position, widgets);
      });

  Widget getRow(int i, List<String> widgets) {
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
