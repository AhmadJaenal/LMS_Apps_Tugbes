import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatefulWidget {
  final Widget childWidget;
  double offsetY;
  double offsetX;
  FadeAnimation({
    Key? key,
    required this.childWidget,
    this.offsetY = 0,
    this.offsetX = 0,
  }) : super(key: key);

  @override
  State<FadeAnimation> createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    animationController.forward();

    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        widget.offsetY = 0;
        widget.offsetX = 0;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1500),
        transform: Matrix4.translationValues(widget.offsetX, widget.offsetY, 0),
        curve: Curves.easeOut,
        child: widget.childWidget,
      ),
    );
  }
}
