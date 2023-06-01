import 'package:flutter/material.dart';

class ItemFader extends StatefulWidget {
  ItemFader({super.key, required this.child});

  Widget child;

  @override
  State<ItemFader> createState() => ItemFaderState();
}

class ItemFaderState extends State<ItemFader>
    with SingleTickerProviderStateMixin {
  // 1 means its below, -1 means its top.
  int position = 1;
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  void show() {
    setState(
      () => position = 1,
    );
    _animationController.forward();
  }

  void hide() {
    setState(
      () => position = -1,
    );
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: ((context, child) {
          return Transform.translate(
            offset: Offset(0, 64.0 * position * (1 - _animation.value)),
            child: Opacity(
              opacity: _animation.value,
              child: widget.child,
            ),
          );
        }),
        child: widget.child);
  }
}
