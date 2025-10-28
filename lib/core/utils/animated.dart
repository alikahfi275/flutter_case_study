import 'package:flutter/material.dart';

enum AnimationType { fade, slide, slideFade }

class AnimatedSlideFade extends StatefulWidget {
  final Widget child;
  final int delay;
  final Duration duration;
  final Offset offset;
  final Curve curve;
  final AnimationType type;

  const AnimatedSlideFade({
    super.key,
    required this.child,
    this.delay = 0,
    this.duration = const Duration(milliseconds: 600),
    this.offset = const Offset(0, 0.1),
    this.curve = Curves.easeOut,
    this.type = AnimationType.slideFade,
  });

  @override
  State<AnimatedSlideFade> createState() => _AnimatedSlideFadeState();
}

class _AnimatedSlideFadeState extends State<AnimatedSlideFade>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.duration, vsync: this);
    final curved = CurvedAnimation(parent: _controller, curve: widget.curve);

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(curved);
    _slideAnimation = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(curved);

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget animatedChild = widget.child;

    switch (widget.type) {
      case AnimationType.fade:
        animatedChild = FadeTransition(
          opacity: _fadeAnimation,
          child: widget.child,
        );
        break;

      case AnimationType.slide:
        animatedChild = SlideTransition(
          position: _slideAnimation,
          child: widget.child,
        );
        break;

      case AnimationType.slideFade:
        animatedChild = FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: widget.child,
          ),
        );
        break;
    }

    return animatedChild;
  }
}
