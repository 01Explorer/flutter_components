import 'dart:math';

import 'package:flutter/material.dart';

class PolygonAnimation extends StatefulWidget {
  const PolygonAnimation({super.key});

  @override
  State<PolygonAnimation> createState() => _PolygonAnimationState();
}

class Polygon extends CustomPainter {
  final int sides;

  Polygon({required this.sides});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final angle = (2 * pi) / sides;
    final radius = min(size.width, size.height) / 2;
    final angles = List.generate(sides, (index) => angle * index);
    final center = Offset(size.width / 2, size.height / 2);
    final path = Path();
    path.moveTo(center.dx + cos(0) * radius, center.dy + sin(0) * radius);

    for (final angle in angles) {
      final x = center.dx + cos(angle) * radius;
      final y = center.dy + sin(angle) * radius;
      path.lineTo(x, y);
    }

    path.close();
    return canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is Polygon && oldDelegate.sides != sides;
}

class _PolygonAnimationState extends State<PolygonAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _sidesAnimation;
  late Animation<double> _sizeAnimation;
  late Animation<double> _angleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _sidesAnimation = IntTween(begin: 3, end: 10)
        .chain(
          CurveTween(curve: Curves.easeInOut),
        )
        .animate(_controller);

    _sizeAnimation = Tween<double>(begin: 40, end: 400)
        .chain(
          CurveTween(
            curve: Curves.bounceInOut,
          ),
        )
        .animate(
          _controller,
        );

    _angleAnimation = Tween<double>(begin: 0, end: 2 * pi)
        .chain(
          CurveTween(
            curve: Curves.easeInOut,
          ),
        )
        .animate(
          _controller,
        );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controller.repeat(reverse: true);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(_angleAnimation.value)
                  ..rotateY(_angleAnimation.value)
                  ..rotateZ(_angleAnimation.value),
                child: CustomPaint(
                  painter: Polygon(sides: _sidesAnimation.value),
                  child: SizedBox(
                    width: _sizeAnimation.value,
                    height: _sizeAnimation.value,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
