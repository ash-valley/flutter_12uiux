import 'package:flutter/material.dart';
import 'package:flutter_12uiux/common/scaffold.dart';

class ContentData {
  const ContentData({
    required this.name,
    required this.price,
    required this.detail,
    required this.colors,
  });
  final String name;
  final int price;
  final String detail;
  final List<Color> colors;
}

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
  static const List<ContentData> contents = [
    ContentData(
      name: "Janet",
      price: 10000,
      detail: """
detaildetaildetaildetaildetaildetail
detaildetaildetaildetail
detaildetail
""",
      colors: [
        Colors.redAccent,
        Colors.blueAccent,
      ],
    ),
    ContentData(
      name: "Morgen",
      price: 10002,
      detail: """detail""",
      colors: [
        Colors.redAccent,
        Colors.blueAccent,
        Colors.yellowAccent,
      ],
    ),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: contents.length,
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
            children: contents
                .map(
                  (e) => Content(content: e),
                )
                .toList(),
          ),
        ),
        // SizedBox(
        //   height: 32,
        //   child: TabBar(
        //     indicatorColor: Theme.of(context).secondaryHeaderColor,
        //     labelColor: Theme.of(context).primaryColor,
        //     tabs: contents
        //         .map((e) => Tab(
        //               text: e.name,
        //             ))
        //         .toList(),
        //     controller: _tabController,
        //   ),
        // ),
      ],
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    super.key,
    required this.content,
  });

  final ContentData content;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 98, left: 24, right: 24, bottom: 24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox.square(
                    dimension: 100,
                  ),
                  Text(
                    content.name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    '￥${content.price}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      content.detail,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const Spacer(),
                  ColorSelector(colors: content.colors),
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

class ColorSelector extends StatefulWidget {
  const ColorSelector({
    super.key,
    required this.colors,
  });

  final List<Color> colors;

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late Color selectedColor;
  @override
  void initState() {
    selectedColor = widget.colors.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: widget.colors.map(
        (e) {
          final color = GestureDetector(
            onTap: () => setState(() {
              selectedColor = e;
            }),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: e,
                shape: BoxShape.circle,
              ),
            ),
          );
          return e == selectedColor ? color.withSelectedCircle(48, 48) : color;
        },
      ).toList(),
    );
  }
}

extension ContainerEx on Widget {
  Stack withSelectedCircle(double width, double height) {
    return Stack(
      alignment: Alignment.center,
      children: [
        this,
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2,
              strokeAlign: StrokeAlign.inside,
            ),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
