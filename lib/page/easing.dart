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
        child: EasingBody(),
      ),
    );
  }
}

class EasingBody extends StatefulWidget {
  const EasingBody({super.key});

  @override
  State<EasingBody> createState() => _EasingBodyState();
}

class _EasingBodyState extends State<EasingBody>
    with SingleTickerProviderStateMixin {
  static const List<Tab> tabs = [
    Tab(
      text: "tab1",
    ),
    Tab(
      text: "tab2",
    ),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: tabs.length,
    );
    _tabController.animation?.addListener(() {
      print(_tabController.animation?.value);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [Content(), Content()],
          ),
        ),
        // SizedBox(
        //   height: 32,
        //   child: TabBar(
        //     indicatorColor: Theme.of(context).secondaryHeaderColor,
        //     labelColor: Theme.of(context).primaryColor,
        //     tabs: tabs,
        //     controller: _tabController,
        //   ),
        // ),
      ],
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 98, left: 16, right: 16, bottom: 24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox.square(
                    dimension: 100,
                  ),
                  Text(
                    'Janet',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    '￥100,000',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      '''
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                      ''',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Theme.of(context).secondaryHeaderColor,
                    ),
                    onPressed: () => null,
                    child: const Expanded(
                      child: Center(
                        child: Text('Buy'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, -.8),
          child: SizedBox(
            height: 132,
            width: 108,
            child: Container(color: Theme.of(context).primaryColorDark),
          ),
        ),
      ],
    );
  }
}
