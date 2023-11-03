import 'dart:math';

import 'package:flutter/material.dart';

class FlippingCircle extends StatefulWidget {
  const FlippingCircle({super.key});

  @override
  State<FlippingCircle> createState() => _FlippingCircleState();
}

class _FlippingCircleState extends State<FlippingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flippingAnimation;
  late Animation<double> _flippingInYAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _flippingAnimation = Tween<double>(begin: 0, end: -pi / 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );
    _flippingInYAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );

    _flippingAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flippingAnimation = Tween<double>(
                begin: _flippingAnimation.value,
                end: _flippingAnimation.value + -pi / 2)
            .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0, 0.5, curve: Curves.bounceOut),
          ),
        );
      }
    });

    _flippingInYAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flippingInYAnimation = Tween<double>(
                begin: _flippingInYAnimation.value,
                end: _flippingInYAnimation.value + pi)
            .animate(
          CurvedAnimation(
              parent: _controller,
              curve: const Interval(0.5, 1, curve: Curves.bounceOut)),
        );
        _controller
          ..reset()
          ..forward();
      }
    });
    _controller.forward();
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
                  ..rotateZ(_flippingAnimation.value),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          return Transform(
                            alignment: Alignment.centerRight,
                            transform: Matrix4.identity()
                              ..rotateY(_flippingInYAnimation.value),
                            child: ClipRect(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                widthFactor: 0.5,
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          return Transform(
                            alignment: Alignment.centerLeft,
                            transform: Matrix4.identity()
                              ..rotateY(_flippingInYAnimation.value),
                            child: ClipRect(
                              child: Align(
                                alignment: Alignment.centerRight,
                                widthFactor: 0.5,
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                ),
              );
            }),
      ),
    );
  }
}
