import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_12uiux/common/scaffold.dart';
import 'package:flutter_12uiux/extensions/list_map_with_index.dart';

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
    ContentData(
      name: "Carven",
      price: 100020,
      detail: """detail""",
      colors: [
        Colors.redAccent,
        Colors.blueAccent,
        Colors.yellowAccent,
      ],
    ),
  ];
  late TabController _tabController;
  double _animationValue = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: contents.length,
    );
    _animationValue = _tabController.animation?.value ?? 0;
    _tabController.animation?.addListener(() {
      setState(() {
        _animationValue = _tabController.animation?.value ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: contents
          .mapWithIndex(
            (e, i) => Transform(
              transform: Matrix4.identity()
                ..rotateY((_animationValue - i) * pi / 2),
              alignment: FractionalOffset(-(_animationValue - i) * .5, 0),
              child: Content(content: e),
            ),
          )
          .toList(),
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
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 98,
            left: 24,
            right: 24,
            bottom: 24,
          ),
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
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    '￥${content.price}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    content.detail,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  ColorSelector(colors: content.colors),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Theme.of(context).secondaryHeaderColor,
                    ),
                    onPressed: () {
                      return;
                    },
                    child: const Center(
                      child: Text('Buy'),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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
    const double circleDiameter = 40;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: widget.colors
          .map(
            (e) => GestureDetector(
              onTap: () => setState(() {
                selectedColor = e;
              }),
              child: Container(
                width: circleDiameter,
                height: circleDiameter,
                decoration: BoxDecoration(
                  color: e,
                  shape: BoxShape.circle,
                ),
              ),
            ).withSelectedCircle(e == selectedColor, circleDiameter + 8),
          )
          .toList(),
    );
  }
}

extension ContainerEx on Widget {
  Widget withSelectedCircle(bool selected, double diameter) {
    return selected
        ? Stack(
            alignment: Alignment.center,
            children: [
              this,
              Container(
                width: diameter,
                height: diameter,
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
          )
        : SizedBox.square(
            dimension: diameter,
            child: this,
          );
  }
}
