import 'package:flutter/material.dart';
import 'package:flutter_playground/main.dart';
import 'package:go_router/go_router.dart';

import 'Pages/Component/text_page.dart';
import 'Pages/Component/drawer_page.dart';
import 'Pages/Animation/animation_controller_page.dart';
import 'Pages/Animation/animation_paging_page.dart';
import 'Pages/Component/stack_page.dart';
import 'Pages/Animation/advance_animation_control_page.dart';
import 'Pages/Component/draggable_page.dart';

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
        builder: (context, state) => TextPage(),
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
        path: 'advanceAnimationControl',
        builder: (context, state) => AdvanceAnimationControllerPage(),
      ),
      GoRoute(
        path: 'stack',
        builder: (context, state) => const StackDemoPage(),
      ),
      GoRoute(
        path: 'animationPaging',
        builder: (context, state) => const AnimationPagingPage(),
      ),
      GoRoute(
          path: 'draggablePage', builder: ((context, state) => DraggablePage()))
    ],
  ),
]);
