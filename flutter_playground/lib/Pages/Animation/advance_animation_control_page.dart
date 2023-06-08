import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../Containers/count_page.dart';

// Reference: https://www.youtube.com/watch?v=FCyoHclCqc8

class AdvanceAnimationControllerPage extends StatefulWidget {
  AdvanceAnimationControllerPage({super.key});

  final double maxSlide = 225.0;

  @override
  State<AdvanceAnimationControllerPage> createState() =>
      _AdvanceAnimationControllerPageState();
}

class _AdvanceAnimationControllerPageState
    extends State<AdvanceAnimationControllerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final double _minDragStartEdge = 150;
  bool _canBeDragged = true;

  late final Widget child;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    child = SizedBox(
        width: widget.maxSlide, child: Container(color: Colors.yellow));
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  void _onDragStart(DragStartDetails details) {
    final maxDragStartEdge =
        MediaQuery.of(context).size.width - _minDragStartEdge;
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < _minDragStartEdge;
    bool isDragOpenFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;
    _canBeDragged = isDragOpenFromLeft || isDragOpenFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged && details.primaryDelta != null) {
      double delta = details.primaryDelta! / widget.maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      _animationController.animateBack(0);
    } else {
      _animationController.animateTo(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation control demo'),
      ),
      body: GestureDetector(
        onTap: toggle,
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Stack(
              children: [
                Container(
                  color: Colors.grey,
                ),
                Transform.translate(
                  offset:
                      Offset(widget.maxSlide * _animationController.value, 0),
                  child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(-math.pi / 2 * _animationController.value),
                      alignment: Alignment.centerLeft,
                      child: const CounterPage()),
                ),
                Transform.translate(
                  offset: Offset(
                      widget.maxSlide * (_animationController.value - 1), 0),
                  child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(
                            math.pi / 2 * (1 - _animationController.value)),
                      alignment: Alignment.centerRight,
                      child: child),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
