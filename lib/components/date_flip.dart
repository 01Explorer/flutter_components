import 'dart:math';

import 'package:flutter/material.dart';

class DateFlipper extends StatefulWidget {
  const DateFlipper({super.key});

  @override
  State<DateFlipper> createState() => _DateFlipperState();
}

class _DateFlipperState extends State<DateFlipper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Tween<double> _tweenFlip;
  late final Tween<double> _secondFlip;
  late final Animation<double> _animationFlip;
  late final Animation<double> _secondAnimationFlip;
  int counter = 0;
  int secondCounter = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _tweenFlip = Tween(begin: 0, end: -pi / 2);
    _secondFlip = Tween(begin: pi / 2, end: -pi / 16);
    _animationFlip = CurvedAnimation(
            parent: _controller,
            curve: const Interval(0, 0.5, curve: Curves.linear))
        .drive(_tweenFlip);
    _secondAnimationFlip = CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.5, 1, curve: Curves.linear))
        .drive(_secondFlip);

    _controller.addStatusListener((status) {
      debugPrint(status.toString());
      debugPrint(counter.toString());
      if (status == AnimationStatus.forward) {
        setState(() {
          secondCounter++;
        });
      }
      if (status == AnimationStatus.completed) {
        setState(() {
          counter++;
        });
        _controller.reset();
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Date Flipper"),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.5,
                  child: Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        '${counter % 10}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 124,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 2)),
              ClipRect(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: 0.5,
                  child: Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        '${secondCounter % 10}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 124,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(_secondAnimationFlip.value),
                      alignment: Alignment.bottomCenter,
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          heightFactor: 0.5,
                          child: Container(
                            width: 150,
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                '${secondCounter % 10}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 124,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 2)),
                    Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(_animationFlip.value),
                      alignment: Alignment.topCenter,
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          heightFactor: 0.5,
                          child: Container(
                            width: 150,
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                '${counter % 10}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 124,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.forward();
        },
        child: const Icon(Icons.bolt_rounded),
      ),
    );
  }
}
