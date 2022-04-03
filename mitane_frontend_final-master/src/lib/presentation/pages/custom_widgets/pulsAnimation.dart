import 'package:flutter/material.dart';
import 'package:mitane_frontend/util/const.dart';
import 'package:easy_localization/easy_localization.dart';

class PulsAnimation extends StatefulWidget {
  PulsAnimation({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<PulsAnimation> createState() => _PulsAnimationState();
}

class _PulsAnimationState extends State<PulsAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 2.0, end: 15.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 27, 28, 30),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Constants.primary.withOpacity(.5),
                  blurRadius: _animation.value,
                  spreadRadius: _animation.value)
            ]),
        child: widget.child);
  }
}
