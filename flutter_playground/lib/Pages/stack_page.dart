import 'package:flutter/material.dart';
import 'dart:math' as math;

class StackDemoPage extends StatelessWidget {
  const StackDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack widget demo'),
      ),
      body: Center(
        child: Stack(
          children: const [
            SizedBorderBox(),
            Positioned(bottom: 16, left: 16, child: Text('Stack demo'))
          ],
        ),
      ),
    );
  }
}

class SizedBorderBox extends StatelessWidget {
  const SizedBorderBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: const SizedBox(
        height: 200,
        width: 300,
      ),
    );
  }
}
