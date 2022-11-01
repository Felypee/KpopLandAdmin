import 'package:flutter/material.dart';
import 'package:sign_in/images.dart';

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with TickerProviderStateMixin {
  late Size size;
  late AnimationController _controller;
  late Animation<double> _animation;
  double offset = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
        reverseDuration: const Duration(seconds: 2));
    _animation = Tween<double>(
      begin: 0,
      end: 15,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
      ),
    )..addListener(animateListener);
    _controller.forward();
  }

  void animateListener() {
    if (_controller.isCompleted) {
      _controller.reverse();
    }
    if (_controller.isDismissed) {
      _controller.forward();
    }
    setState(() {
      offset = _animation.value;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animation.removeListener(animateListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Transform.translate(
      offset: Offset(0.0, offset),
      child: Image.asset(logo_sin_fondo,
          height: size.height * 0.4,
          width: size.width * 0.6,
          fit: BoxFit.contain),
    );
  }
}
