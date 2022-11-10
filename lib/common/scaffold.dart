import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    super.key,
    required this.title,
    required this.body,
    this.withSafeArea = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  final String title;
  final Widget body;
  final bool withSafeArea;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).location;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: location == '/'
            ? null
            : TextButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_ios),
                label: const Text(''),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
      ),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
      body: withSafeArea ? SafeArea(child: body) : body,
    );
  }
}
