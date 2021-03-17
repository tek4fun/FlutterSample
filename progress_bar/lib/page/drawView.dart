import 'package:flutter/material.dart';

class DrawViewSample extends StatelessWidget {
  const DrawViewSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draw View'),
      ),
      body: _MyGestureDetector(),
    );
  }
}

class _MyGestureDetector extends StatefulWidget {
  _MyGestureDetector({Key? key}) : super(key: key);

  @override
  _MyGestureDetectorState createState() => _MyGestureDetectorState();
}

class _MyGestureDetectorState extends State<_MyGestureDetector> {
  List<Offset?> _points = <Offset?>[];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            RenderBox referenceBox = context.findRenderObject() as RenderBox;
            Offset localPosition =
                referenceBox.globalToLocal(details.globalPosition);
            _points = List.from(_points)..add(localPosition);
          });
        },
        onPanEnd: (DragEndDetails details) => _points.add(null),
        child: CustomPaint(
          painter: SignaturePainter(_points),
          size: Size(double.infinity, double.infinity),
        ),
      ),
    );
  }
}

// class DrawViewSample extends StatefulWidget {
//   DrawViewSample({Key key}) : super(key: key);

//   @override
//   _DrawViewSampleState createState() => _DrawViewSampleState();
// }

// class _DrawViewSampleState extends State<DrawViewSample> {
//   List<Offset> _points = <Offset>[];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Draw View'),
//       ),
//       body: GestureDetector(
//         onPanUpdate: (DragUpdateDetails details) {
//           setState(() {
//             RenderBox referenceBox = context.findRenderObject();
//             Offset localPosition =
//                 referenceBox.globalToLocal(details.globalPosition);
//             _points = List.from(_points)..add(localPosition);
//           });
//         },
//         onPanEnd: (DragEndDetails details) => _points.add(null),
//         child: CustomPaint(
//           painter: SignaturePainter(_points),
//           size: Size(double.infinity, double.infinity),
//         ),
//       ),
//     );
//   }
// }

class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);
  final List<Offset?> points;
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
    }
  }

  bool shouldRepaint(SignaturePainter other) => other.points != points;
}
