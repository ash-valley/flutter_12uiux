import 'package:flutter/material.dart';
import 'package:flutter_12uiux/home.dart';
import 'package:flutter_12uiux/page/easing.dart';
import 'package:go_router/go_router.dart';
import '../extensions/list_map_with_index.dart';

class Page {
  Page({
    required this.title,
    required this.path,
    required this.widgetBuilder,
  });
  final String title;
  final String path;
  final Widget Function(String title) widgetBuilder;
}

final pageList = [
  Page(
    title: 'Easing',
    path: "easing",
    widgetBuilder: (title) => Easing(
      title: title,
    ),
  ),
//   Page(path: "/offset&delay", title: "2. Offset & Delay"),
//   Page(path: "/parenting", title: "3. Parenting"),
];

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomePage(),
      routes: [
        ...pageList.mapWithIndex(
          (e, i) => GoRoute(
            path: e.path,
            builder: (_, __) => e.widgetBuilder('${i + 1}. ${e.title}'),
          ),
        ),
      ],
    ),
  ],
);
