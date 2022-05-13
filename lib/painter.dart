import 'package:flutter/material.dart';

class LinePaintPage extends StatelessWidget {
  const LinePaintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            width: 300,
            height: 300,
            child: CustomPaint(
              foregroundPainter: LinePainter(),
            ),
          ),
        ),
      );
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Colors.white60
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      paint1,
    );

    final paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    canvas.drawLine(
      Offset(size.width * 1 / 12, size.height * 1 / 2),
      Offset(size.width * 11 / 12, size.height * 1 / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
