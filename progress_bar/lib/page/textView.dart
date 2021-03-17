import 'package:flutter/material.dart';
import 'package:progress_bar/bloc/text_view_bloc.dart';
import 'package:progress_bar/state/text_view_state.dart';
import 'package:progress_bar/event/text_view_event.dart';

class TextEditViewSample extends StatefulWidget {
  TextEditViewSample({Key? key}) : super(key: key);

  @override
  _TextEditViewSampleState createState() => _TextEditViewSampleState();
}

class _TextEditViewSampleState extends State<TextEditViewSample> {
  final bloc = TextViewBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Editor Sample'),
      ),
      body: bodyWithStream(),
    );
  }

  Widget bodyWithStream() {
    return StreamBuilder(
      initialData: bloc.state,
      stream: bloc.stateController.stream,
      builder: (BuildContext context, AsyncSnapshot<TextViewState> snapshot) {
        return getBody(snapshot.data!);
      },
    );
  }

//Todos
  getBody(TextViewState data) {
    return Container(
      child: Column(
        children: [
          showText(data),
          //Size
          Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 20, 0),
              child: SizedBox(
                width: double.infinity,
                child: Text('Size: ${data.size}'),
              )),
          Slider(
            value: data.size,
            min: 10.0,
            max: 40.0,
            divisions: 40,
            onChanged: (double value) {
              // setState(() {
              //   _currentSlidervalue = value;
              // });
              bloc.eventController.sink.add(ChangeTextSize(value));
            },
          ),
          //Red
          Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 20, 0),
              child: SizedBox(
                width: double.infinity,
                child: Text('Red: ${data.red}'),
              )),
          Slider(
            value: data.red.toDouble(),
            activeColor: Colors.red,
            min: 0,
            max: 255,
            divisions: 255,
            onChanged: (double value) {
              // setState(() {
              //   _red = value.toInt();
              // });
              bloc.eventController.sink.add(ChangeTextColorRed(value.toInt()));
            },
          ),
          //Green
          Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 20, 0),
              child: SizedBox(
                width: double.infinity,
                child: Text('Green: ${data.green}'),
              )),
          Slider(
            value: data.green.toDouble(),
            activeColor: Colors.green,
            min: 0,
            max: 255,
            divisions: 255,
            onChanged: (double value) {
              // setState(() {
              //   _green = value.toInt();
              // });
              bloc.eventController.sink
                  .add(ChangeTextColorGreen(value.toInt()));
            },
          ),
          //Blue
          Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 20, 0),
              child: SizedBox(
                width: double.infinity,
                child: Text('Blue: ${data.blue}'),
              )),
          Slider(
            value: data.blue.toDouble(),
            activeColor: Colors.blue,
            min: 0,
            max: 255,
            divisions: 255,
            onChanged: (double value) {
              // setState(() {
              //   _blue = value.toInt();
              // });
              bloc.eventController.sink.add(ChangeTextColorBlue(value.toInt()));
            },
          ),
          //Opacity
          Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 20, 0),
              child: SizedBox(
                width: double.infinity,
                child: Text('Opacity: ${data.opacity}'),
              )),
          Slider(
            value: data.opacity,
            activeColor: Colors.black,
            min: 0,
            max: 1,
            divisions: 100,
            onChanged: (double value) {
              // setState(() {
              //   _opacity = value;
              // });
              bloc.eventController.sink.add(ChangeTextOpacity(value));
            },
          ),
        ],
      ),
    );
  }

  showText(TextViewState data) {
    return Text(
      'Edit me please!',
      style: TextStyle(
        fontSize: data.size,
        color: getColor(data),
      ),
    );
  }

  Color getColor(TextViewState data) =>
      Color.fromRGBO(data.red, data.green, data.blue, data.opacity);
}
