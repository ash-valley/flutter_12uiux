import 'package:flutter/material.dart';
import 'package:flutter_12uiux/common/scaffold.dart';

const sliderRadius = 40.0;

class Parenting extends StatelessWidget {
  const Parenting({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: title,
      body: const _ParentingSlider(),
    );
  }
}

class _ParentingSlider extends StatefulWidget {
  const _ParentingSlider();

  @override
  State<_ParentingSlider> createState() => _ParentingSliderState();
}

class _ParentingSliderState extends State<_ParentingSlider> {
  double _lightIntensity = 0.5;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final meSize = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: meSize.height * 0.41,
            width: meSize.width,
            child: ClipPath(
              clipper: SliderClipper(
                lightIntensity: _lightIntensity,
              ),
              child: Image.asset(
                'assets/parenting/beds.jpg',
                fit: BoxFit.fitWidth,
                colorBlendMode: BlendMode.darken,
                color: Colors.blue.withOpacity(1 - _lightIntensity),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 20,
            ),
            child: Slider(
              value: _lightIntensity,
              divisions: 100,
              onChanged: ((value) {}),
            ),
          ),
        ),
        Positioned(
          bottom: 200,
          child: Text(
            '${(_lightIntensity * 100).round().toString()}%',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 0,
            thumbColor: Colors.blueGrey,
            thumbShape:
                const RoundSliderThumbShape(enabledThumbRadius: sliderRadius),
          ),
          child: Slider(
            value: _lightIntensity,
            divisions: 100,
            onChanged: ((value) {
              setState(() {
                _lightIntensity = value;
              });
            }),
          ),
        ),
      ],
    );
  }
}

class SliderClipper extends CustomClipper<Path> {
  const SliderClipper({
    required this.lightIntensity,
  });

  final double lightIntensity;

  @override
  Path getClip(Size size) {
    final height = size.height;
    final width = size.width;
    const clipRadius = sliderRadius + 18;
    final adjustSliderValue =
        (width - sliderRadius * 2) * lightIntensity + sliderRadius;
    return Path()
      ..lineTo(0, height)
      ..lineTo(adjustSliderValue - clipRadius - 40, height)
      ..quadraticBezierTo(
        adjustSliderValue - clipRadius - 10,
        height,
        adjustSliderValue - clipRadius,
        height - 20,
      )
      ..arcToPoint(
        Offset(
          adjustSliderValue + clipRadius,
          height - 20,
        ),
        radius: const Radius.circular(clipRadius * 1.1),
      )
      ..quadraticBezierTo(
        adjustSliderValue + clipRadius + 10,
        height,
        adjustSliderValue + clipRadius + 40,
        height,
      )
      ..lineTo(width, height)
      ..lineTo(width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
