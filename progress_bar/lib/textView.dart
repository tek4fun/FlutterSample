import 'package:flutter/material.dart';

class TextEditViewSample extends StatefulWidget {
  TextEditViewSample({Key key}) : super(key: key);

  @override
  _TextEditViewSampleState createState() => _TextEditViewSampleState();
}

class _TextEditViewSampleState extends State<TextEditViewSample> {
  double _currentSlidervalue = 20.0;
  int _red = 0;
  int _green = 0;
  int _blue = 0;
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Editor Sample'),
      ),
      body: getBody(),
    );
  }

  getBody() {
    return Container(
      child: Column(
        children: [
          showText(),
          //Size
          Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 20, 0),
              child: SizedBox(
                width: double.infinity,
                child: Text('Size:'),
              )),
          Slider(
            value: _currentSlidervalue,
            min: 10.0,
            max: 40.0,
            divisions: 40,
            onChanged: (double value) {
              setState(() {
                _currentSlidervalue = value;
              });
            },
          ),
          //Red
          Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 20, 0),
              child: SizedBox(
                width: double.infinity,
                child: Text('Red:'),
              )),
          Slider(
            value: _red.toDouble(),
            activeColor: Colors.red,
            min: 0,
            max: 255,
            divisions: 255,
            onChanged: (double value) {
              setState(() {
                _red = value.toInt();
              });
            },
          ),
          //Green
          Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 20, 0),
              child: SizedBox(
                width: double.infinity,
                child: Text('Green:'),
              )),
          Slider(
            value: _green.toDouble(),
            activeColor: Colors.green,
            min: 0,
            max: 255,
            divisions: 255,
            onChanged: (double value) {
              setState(() {
                _green = value.toInt();
              });
            },
          ),
          //Blue
          Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 20, 0),
              child: SizedBox(
                width: double.infinity,
                child: Text('Blue:'),
              )),
          Slider(
            value: _blue.toDouble(),
            activeColor: Colors.blue,
            min: 0,
            max: 255,
            divisions: 255,
            onChanged: (double value) {
              setState(() {
                _blue = value.toInt();
              });
            },
          ),
          //Opacity
          Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 20, 0),
              child: SizedBox(
                width: double.infinity,
                child: Text('Opacity:'),
              )),
          Slider(
            value: _opacity.toDouble(),
            activeColor: Colors.black,
            min: 0,
            max: 1,
            divisions: 100,
            onChanged: (double value) {
              setState(() {
                _opacity = value;
              });
            },
          ),
        ],
      ),
    );
  }

  showText() {
    return Text(
      'Edit me please!',
      style: TextStyle(
        fontSize: _currentSlidervalue,
        color: getColor(),
      ),
    );
  }

  Color getColor() => Color.fromRGBO(_red, _green, _blue, _opacity);
}
