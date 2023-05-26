import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SimpleUIPage extends StatelessWidget {
  const SimpleUIPage({super.key});

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
      body: Center(
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(strokeAlign: BorderSide.strokeAlignInside)),
            child: const Text('Demo Text')),
      ),
      drawer: Drawer(),
    );
  }
}
