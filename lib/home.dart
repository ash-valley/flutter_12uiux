import 'package:flutter/material.dart';
import 'package:flutter_12uiux/router.dart';
import 'package:go_router/go_router.dart';

import 'common/scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Home Page',
      body: ListView.builder(
          itemCount: pageList.length,
          itemBuilder: (context, index) {
            final page = pageList[index];
            return Card(
              child: ListTile(
                title: Text("${index + 1}. ${page.title}"),
                onTap: () => context.go('/${page.path}'),
              ),
            );
          }),
    );
  }
}
