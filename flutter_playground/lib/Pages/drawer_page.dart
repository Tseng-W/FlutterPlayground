import 'package:flutter/material.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // this to prevent the default sliding behaviour
        drawerEnableOpenDragGesture: false,
        drawer: Drawer(),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => // Ensure Scaffold is in context
                IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer()),
          ),
        ));
  }
}
