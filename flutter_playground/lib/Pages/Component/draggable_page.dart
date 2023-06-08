import 'package:flutter/material.dart';

class DraggablePage extends StatelessWidget {
  const DraggablePage({super.key});

  final colorToSend = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Draggable widget Demo'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Draggable<Color>(
              data: colorToSend,
              feedback: const RoundedBlueBox(),
              childWhenDragging: const GreyBox(),
              child: ColorBox(
                color: colorToSend,
              ),
            ),
            const Spacer(),
            DragTarget<Color>(builder: ((context, candidateData, rejectedData) {
              return candidateData.isNotEmpty
                  ? ColorBox(color: candidateData.first!)
                  : const BorderBox();
            }))
          ],
        ));
  }
}

class ColorBox extends StatelessWidget {
  ColorBox({super.key, required this.color});

  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: const SizedBox(
        width: 100,
        height: 100,
        child: Text("Hi"),
      ),
    );
  }
}

class RoundedBlueBox extends StatelessWidget {
  const RoundedBlueBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.blueAccent),
      child: const SizedBox(
        width: 100,
        height: 100,
        child: Text("Hi"),
      ),
    );
  }
}

class GreyBox extends StatelessWidget {
  const GreyBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SizedBox(
        width: 100,
        height: 100,
        child: Container(),
      ),
    );
  }
}

class BorderBox extends StatelessWidget {
  const BorderBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: Colors.grey)),
      child: const SizedBox(
        width: 100,
        height: 100,
      ),
    );
  }
}

/// Flutter code sample for [Draggable].
class DraggableExample extends StatefulWidget {
  const DraggableExample({super.key});

  @override
  State<DraggableExample> createState() => _DraggableExampleState();
}

class _DraggableExampleState extends State<DraggableExample> {
  int acceptedData = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Draggable<int>(
          // Data is the value this Draggable stores.
          data: 10,
          feedback: Container(
            color: Colors.deepOrange,
            height: 100,
            width: 100,
            child: const Icon(Icons.directions_run),
          ),
          childWhenDragging: Container(
            height: 100.0,
            width: 100.0,
            color: Colors.pinkAccent,
            child: const Center(
              child: Text('Child When Dragging'),
            ),
          ),
          child: Container(
            height: 100.0,
            width: 100.0,
            color: Colors.lightGreenAccent,
            child: const Center(
              child: Text('Draggable'),
            ),
          ),
        ),
        DragTarget<int>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return Container(
              height: 100.0,
              width: 100.0,
              color: Colors.cyan,
              child: Center(
                child: Text('Value is updated to: $acceptedData'),
              ),
            );
          },
          onAccept: (int data) {
            setState(() {
              acceptedData += data;
            });
          },
        ),
      ],
    );
  }
}
