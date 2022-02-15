import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

enum SharedAxis { x, y, z }

class MotionAnimator {
  static final MotionAnimator _instance = MotionAnimator._internal();

  MotionAnimator._internal();

  factory MotionAnimator() {
    return _instance;
  }

  /// Container Transform Page Transition
  Widget containerTransformTransition({
    required Widget Function(BuildContext, VoidCallback) closedBuilder,
    required Widget Function(BuildContext, VoidCallback) openBuilder,
    ShapeBorder? closedShape,
  }) {
    return OpenContainer(
      closedBuilder: closedBuilder,
      openBuilder: openBuilder,
      closedShape: closedShape ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide.none,
          ),
      transitionDuration: const Duration(seconds: 1),
    );
  }

  /// Shared Axis Page Transition
  PageRouteBuilder sharedAxisPageTranisition({
    required Widget screen,
    SharedAxis axis = SharedAxis.z,
  }) {
    return PageRouteBuilder(
      opaque: true,
      transitionDuration: const Duration(seconds: 1),
      reverseTransitionDuration: const Duration(seconds: 1),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          fillColor: Colors.transparent,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: _sharedAxisTransitionType(axis),
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return screen;
      },
    );
  }

  /// Shared Axis Widget Transition
  PageTransitionSwitcher sharedAxisWidgetTransition({
    required Widget child,
    bool reverse = false,
    SharedAxis axis = SharedAxis.x,
  }) {
    return PageTransitionSwitcher(
      reverse: reverse,
      duration: const Duration(seconds: 1),
      transitionBuilder: (child, animation, secondaryAnimation) => SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: _sharedAxisTransitionType(axis),
        child: child,
      ),
      child: child,
    );
  }

  /// Fade-through Page Transition
  PageRouteBuilder fadeThroughPageTranisition({required Widget screen}) {
    return PageRouteBuilder(
      opaque: false,
      transitionDuration: const Duration(seconds: 1),
      reverseTransitionDuration: const Duration(seconds: 1),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeThroughTransition(
          fillColor: Colors.white,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return screen;
      },
    );
  }

  /// Fade-through Widget Transition
  PageTransitionSwitcher fadeThroughWidgetTransition({
    required Widget child,
    bool reverse = false,
  }) {
    return PageTransitionSwitcher(
      reverse: reverse,
      duration: const Duration(seconds: 1),
      transitionBuilder: (child, animation, secondaryAnimation) => FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      ),
      child: child,
    );
  }

  SharedAxisTransitionType _sharedAxisTransitionType(SharedAxis axis) {
    switch (axis) {
      case SharedAxis.x:
        return SharedAxisTransitionType.horizontal;
      case SharedAxis.y:
        return SharedAxisTransitionType.vertical;
      case SharedAxis.z:
        return SharedAxisTransitionType.scaled;
    }
  }
}
