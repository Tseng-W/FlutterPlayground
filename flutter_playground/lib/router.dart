import 'package:flutter/material.dart';
import 'package:flutter_playground/main.dart';
import 'package:go_router/go_router.dart';

import 'Pages/simple_ui_page.dart';
import 'Pages/drawer_page.dart';
import 'Pages/animation_controller_page.dart';
import 'Pages/stack_page.dart';

typedef RouteCallback = void Function(BuildContext context);

class RouteItem {
  RouteItem({
    required this.title,
    required this.routerPath,
  });

  final String title;
  final String routerPath;

  push(BuildContext context) {
    context.push(routerPath);
  }
}

final GoRouter router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
    routes: [
      GoRoute(
        path: 'simpleUI',
        builder: (context, state) => SimpleUIPage(),
      ),
      GoRoute(
        path: 'drawer',
        builder: (context, state) => DrawerPage(),
      ),
      GoRoute(
        path: 'animationControl',
        builder: (context, state) => AnimationControllerPage(),
      ),
      GoRoute(
        path: 'stack',
        builder: (context, state) => StackDemoPage(),
      ),
    ],
  ),
]);
