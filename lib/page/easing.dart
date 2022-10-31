import 'package:flutter/material.dart';
import 'package:flutter_12uiux/common/scaffold.dart';

class Easing extends StatelessWidget {
  const Easing({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: title,
      body: const Center(
        child: _Easing(),
      ),
    );
  }
}

class _Easing extends StatelessWidget {
  const _Easing({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('test');
  }
}
