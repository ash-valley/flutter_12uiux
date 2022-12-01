import 'package:flutter/material.dart';
import 'package:flutter_12uiux/common/scaffold.dart';

class Transformation extends StatelessWidget {
  const Transformation({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: title,
      body: const _Transformation(),
    );
  }
}

class _Transformation extends StatelessWidget {
  const _Transformation();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
