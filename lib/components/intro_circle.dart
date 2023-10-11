import 'package:flutter/material.dart';

class MyAnimation extends StatefulWidget {
  const MyAnimation({super.key});

  @override
  State<MyAnimation> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation>
    with SingleTickerProviderStateMixin {
  late final Tween<Alignment> _tweenAlignment;
  late final Tween<double> _tweenSize;
  late final Tween<Offset> _tweenOffset;
  late final AnimationController _controller;
  late final Animation<Alignment> _animationAlignment;
  late final Animation<double> _animationSize;
  late final Animation<Offset> _animationOffset;
  late double maxSize;
  bool animationCompleted = false;
  bool isCircle = true;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _tweenOffset =
        Tween(begin: const Offset(0, -1000), end: const Offset(0, 0));
    _animationOffset = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.1, curve: Curves.bounceOut),
    ).drive(_tweenOffset);

    _tweenAlignment = Tween(begin: Alignment.topCenter, end: Alignment.center);
    _animationAlignment = CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.1, 0.3, curve: Curves.elasticIn))
        .drive(_tweenAlignment);

    _tweenSize = Tween(begin: 0.1, end: 1);
    _animationSize = CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.4, 1, curve: Curves.elasticOut))
        .drive(_tweenSize);
    _controller.forward().whenComplete(() => setState(() => isCircle = true));
  }

  @override
  Widget build(BuildContext context) {
    maxSize = MediaQuery.orientationOf(context) == Orientation.portrait
        ? MediaQuery.sizeOf(context).height
        : MediaQuery.sizeOf(context).width;
    debugPrint(isCircle.toString());
    debugPrint(_animationSize.value.toString());
    debugPrint(_animationAlignment.value.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intro Animation'),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return OverflowBox(
            maxWidth: double.infinity,
            maxHeight: double.infinity,
            child: Transform.translate(
              offset: _animationOffset.value,
              child: Align(
                alignment: _animationAlignment.value,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  width: _animationSize.value * maxSize * 1.5,
                  height: _animationSize.value * maxSize * 1.5,
                  decoration: BoxDecoration(
                    shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.isCompleted
              ? _controller.reverse()
              : _controller.forward();
        },
        child: const Icon(Icons.bolt),
      ),
    );
  }
}
