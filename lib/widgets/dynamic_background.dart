import 'package:flutter/material.dart';

class DynamicBackground extends StatelessWidget {
  final Widget child;

  const DynamicBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size.infinite,
          painter: WavePainter(),
        ),
        child,
      ],
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.2)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.3, size.width * 0.5, size.height * 0.2)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.1, size.width, size.height * 0.2)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);

    final paint2 = Paint()
      ..color = Colors.white70
      ..style = PaintingStyle.fill;

    final path2 = Path()
      ..moveTo(0, size.height * 0.4)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.5, size.width * 0.5, size.height * 0.4)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.3, size.width, size.height * 0.4)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}