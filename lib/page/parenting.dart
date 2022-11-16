import 'package:flutter/material.dart';
import 'package:flutter_12uiux/common/scaffold.dart';

const double sliderRadius = 36;

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

class _ParentingSliderState extends State<_ParentingSlider>
    with TickerProviderStateMixin {
  double _lightIntensity = 0.5;
  late AnimationController _animationController;
  String get displayLightIntensity =>
      (_lightIntensity * 100).round().toString();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      value: 0.5,
      vsync: this,
      duration: const Duration(microseconds: 100),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final meSize = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: meSize.height * 0.415,
            width: meSize.width,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return ClipPath(
                  clipper: SliderClipper(
                    lightIntensity: _animationController.value,
                  ),
                  child: child,
                );
              },
              child: Image.asset(
                'assets/parenting/beds.jpg',
                fit: BoxFit.fitWidth,
                colorBlendMode: BlendMode.darken,
                color: Colors.blue.withOpacity(1 - _lightIntensity),
                alignment: Alignment.bottomCenter,
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
              onChanged: (value) {},
            ),
          ),
        ),
        Positioned(
          bottom: 200,
          child: LightIntensityLabel(
            displayLightIntensity: displayLightIntensity,
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 0,
            thumbColor: Colors.blueGrey,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: sliderRadius,
            ),
          ),
          child: Slider(
            value: _lightIntensity,
            divisions: 100,
            onChanged: ((value) {
              _animationController.animateTo(
                value,
                curve: Curves.easeOutExpo,
              );
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

class LightIntensityLabel extends StatelessWidget {
  const LightIntensityLabel({
    super.key,
    required this.displayLightIntensity,
  });

  final String displayLightIntensity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              displayLightIntensity,
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              '%',
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
        Text(
          'Light Intensity',
          style: Theme.of(context).textTheme.caption?.copyWith(
                fontSize: 18,
              ),
        ),
      ],
    );
  }
}
