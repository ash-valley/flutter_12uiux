import 'package:flutter/material.dart';
import 'package:flutter_12uiux/common/scaffold.dart';

const sliderSize = 60.0;

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
            height: meSize.height * 0.4,
            width: meSize.width,
            child: ClipPath(
              clipper: SliderClipper(
                lightIntensity: _lightIntensity,
              ),
              child: Image.asset(
                'assets/parenting/beds.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        Slider(
          value: _lightIntensity,
          onChanged: ((value) {
            setState(() {
              _lightIntensity = value;
            });
          }),
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
    return Path()
      ..lineTo(0, height)
      ..lineTo(width * lightIntensity - sliderSize, height)
      ..cubicTo(
          width * lightIntensity - sliderSize / 1.5,
          height - sliderSize,
          width * lightIntensity + sliderSize / 1.5,
          height - sliderSize,
          width * lightIntensity + sliderSize,
          height)
      ..lineTo(width, height)
      ..lineTo(width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
