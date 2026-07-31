import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FadeSlideTransition extends CustomTransitionPage {
  const FadeSlideTransition({
    required super.child,
    required super.name,
    super.arguments,
    super.key,
  }) : super(
          transitionsBuilder: _transitionsBuilder,
          transitionDuration: const Duration(milliseconds: 400),
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
    final slide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(curved);
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(position: slide, child: child),
    );
  }
}

class PremiumTransition extends CustomTransitionPage {
  const PremiumTransition({
    required super.child,
    super.name,
    super.key,
  }) : super(
          transitionsBuilder: _premiumBuilder,
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 400),
        );

  static Widget _premiumBuilder(BuildContext context, Animation<double> a, Animation<double> s, Widget child) {
    final scale = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(parent: a, curve: Curves.easeOutExpo),
    );
    final fade = CurvedAnimation(parent: a, curve: Curves.easeOut);
    final slide = Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero).animate(
      CurvedAnimation(parent: a, curve: Curves.easeOutCubic),
    );
    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: slide,
        child: ScaleTransition(scale: scale, child: child),
      ),
    );
  }
}
