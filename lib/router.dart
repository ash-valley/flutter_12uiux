import 'package:flutter/material.dart';
import 'package:flutter_12uiux/home.dart';
import 'package:flutter_12uiux/page/easing.dart';
import 'package:flutter_12uiux/page/offset_and_delay.dart';
import 'package:flutter_12uiux/page/parenting.dart';
import 'package:flutter_12uiux/page/transformation.dart';
import 'package:go_router/go_router.dart';

import '../extensions/list_map_with_index.dart';

class Page {
  Page({
    required this.title,
    required this.path,
    required this.builder,
  });
  final String title;
  final String path;
  final Widget Function(String title) builder;
}

final pageList = [
  Page(
    title: 'Easing',
    path: "easing",
    builder: (title) => Easing(title: title),
  ),
  Page(
    title: "Offset & Delay",
    path: "offset&delay",
    builder: (title) => OffsetAndDelay(title: title),
  ),
  Page(
    title: "Parenting",
    path: "parenting",
    builder: (title) => Parenting(title: title),
  ),
  Page(
    title: "Transformation",
    path: "transformation",
    builder: (title) => Transformation(title: title),
  )
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
            builder: (_, __) => e.builder('${i + 1}. ${e.title}'),
          ),
        ),
      ],
    ),
  ],
);
