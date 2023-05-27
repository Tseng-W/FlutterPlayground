import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SimpleUIPage extends StatelessWidget {
  SimpleUIPage({super.key});

  double? maxTextHeight;
  double? maxTextWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Simple UI Demo'),
          leading: Visibility(
              child: context.canPop()
                  ? IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.arrow_back))
                  : const Spacer()),
          actions: [
            Builder(builder: ((context) {
              return IconButton(
                  onPressed: (() => Scaffold.of(context).openDrawer()),
                  icon: Icon(Icons.menu));
            })),
          ],
        ),
        body: Row(
          children: [
            Expanded(
              child: Center(
                child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: SizedBox(
                        width: maxTextWidth,
                        height: maxTextHeight,
                        child: const Text('Demo Text'))),
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: SizedBox(
                width: 300,
                child: Text('sizeed.'),
              ),
            )
          ],
        ));
  }
}
