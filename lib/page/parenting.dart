import 'package:flutter/material.dart';
import 'package:flutter_12uiux/common/scaffold.dart';

class Parenting extends StatelessWidget {
  const Parenting({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: title,
      body: const Text("Pareting"),
    );
  }
}
