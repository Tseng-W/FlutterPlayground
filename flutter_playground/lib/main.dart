import 'package:flutter/material.dart';
import 'router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      title: 'Navigation with Result',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RouteItem> _items = [];

  List<RouteItem> _generateItems() {
    return [
      RouteItem(title: 'Simple UI Demo', routerPath: '/simpleUI'),
      RouteItem(title: 'Drawer UI Demo', routerPath: '/drawer'),
      RouteItem(title: 'Stack widget Demo', routerPath: '/stack'),
      RouteItem(
          title: 'Animation Control Demo', routerPath: '/animationControl'),
      RouteItem(
          title: 'Advance Animation Control Demo',
          routerPath: '/advanceAnimationControl'),
      RouteItem(title: 'Animation Paging Demo', routerPath: '/animationPaging'),
    ];
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _items = _generateItems();
    });
  }

  ListBody _buildListBody(context, item) {
    return ListBody(children: <Widget>[
      ListTile(
        title: Text(item.title),
        onTap: () => item.push(context),
        trailing: const Icon(Icons.arrow_right),
      ),
      const Divider()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter playground demos'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) =>
              _buildListBody(context, _items[index]),
        ),
      ),
    );
  }
}
