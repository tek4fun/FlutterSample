import 'package:flutter/material.dart';

class ImageViewSample extends StatefulWidget {
  ImageViewSample({Key key}) : super(key: key);

  @override
  _ImageViewSampleState createState() => _ImageViewSampleState();
}

class _ImageViewSampleState extends State<ImageViewSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image View With Pan and Zoom'),
      ),
      body: showImage(),
    );
  }

  showImage() {
    return Center(
      child: InteractiveViewer(
        boundaryMargin: EdgeInsets.all(10.0),
        minScale: 0.1,
        maxScale: 3.0,
        child: Image.asset('images/flutter-logo.png'),
      ),
    );
  }
}
