import 'package:flutter/material.dart';

import 'color_widget.dart';

class CustomProgressIndicator extends StatefulWidget {
  final Color colors;
  final double value;

  const CustomProgressIndicator(this.colors, this.value, {Key? key}) : super(key: key);

  @override
  _CustomProgressIndicatorState createState() => _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> {
  double _value = 0.0;

  @override
  void didUpdateWidget(CustomProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final widthToApply = availableWidth * _value;

        return Container(
          height: 18,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 0),
                color: grayColor,
                blurRadius: 2,
                blurStyle: BlurStyle.inner,
              ),
            ],
            color: progressColor,
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(5, 0),
                      color: grayColor.withOpacity(.3),
                      blurRadius: 10,
                    ),
                  ],
                ),
                curve: Curves.linear,
                duration: const Duration(seconds: 1),
                width: widthToApply,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  child: _GradientProgressInternal(
                    widget.colors,
                    _value,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GradientProgressInternal extends StatelessWidget {
  static const double _kLinearProgressIndicatorHeight = 18.0;
  final Color colors;
  final double value;

  const _GradientProgressInternal(this.colors, this.value);

  @override
  Widget build(BuildContext context) {
    final colorsToApply = colors;

    return Container(
      constraints: const BoxConstraints.tightFor(
        width: double.infinity,
        height: _kLinearProgressIndicatorHeight,
      ),
      decoration: BoxDecoration(
        color: colorsToApply,
      ),
    );
  }
}
