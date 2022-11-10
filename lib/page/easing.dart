import 'package:flutter/material.dart';
import 'package:flutter_12uiux/common/scaffold.dart';

class _ContentData {
  const _ContentData({
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
        child: _EasingBody(),
      ),
    );
  }
}

class _EasingBody extends StatefulWidget {
  const _EasingBody();

  @override
  State<_EasingBody> createState() => _EasingBodyState();
}

class _EasingBodyState extends State<_EasingBody>
    with SingleTickerProviderStateMixin {
  static const List<_ContentData> contents = [
    _ContentData(
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
    _ContentData(
      name: "Morgen",
      price: 10002,
      detail: """detail""",
      colors: [
        Colors.redAccent,
        Colors.blueAccent,
        Colors.yellowAccent,
      ],
    ),
    _ContentData(
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
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: .85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: contents.length,
      itemBuilder: (context, index) {
        final content = contents[index];
        return _Content(content: content);
      },
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.content,
  });

  final _ContentData content;

  @override
  Widget build(BuildContext context) {
    const imageSize = Size(108, 132);
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: LayoutBuilder(builder: (context, constraints) {
        final cardHeight = constraints.maxHeight - imageSize.height / 1.8;
        return Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: cardHeight,
                child: _Card(
                  content: content,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox.fromSize(
                size: imageSize,
                child: Container(color: Theme.of(context).primaryColorDark),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.content,
  });

  final _ContentData content;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox.square(dimension: 100),
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
            _ColorSelector(colors: content.colors),
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _ColorSelector extends StatefulWidget {
  const _ColorSelector({
    required this.colors,
  });

  final List<Color> colors;

  @override
  State<_ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<_ColorSelector> {
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

extension on Widget {
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
