import 'package:flutter/animation.dart';

/// Consistent animation tokens for the skad design system.
///
/// Use these across all widgets for a cohesive motion identity.
///
/// ```dart
/// AnimatedContainer(
///   duration: SkadMotion.fast,
///   curve: SkadMotion.curve,
/// )
/// ```
class SkadMotion {
  SkadMotion._();

  /// Fast animation (100ms) — micro-interactions, hover states.
  static const Duration fast = Duration(milliseconds: 100);

  /// Normal animation (200ms) — default transitions.
  static const Duration normal = Duration(milliseconds: 200);

  /// Slow animation (300ms) — page transitions, overlays.
  static const Duration slow = Duration(milliseconds: 300);

  /// Extra slow animation (500ms) — dramatic reveals.
  static const Duration extraSlow = Duration(milliseconds: 500);

  /// Default easing curve — ease out for natural deceleration.
  static const Curve curve = Curves.easeOut;

  /// Spring-like curve for bouncy interactions.
  static const Curve spring = Curves.elasticOut;

  /// Ease-in-out for symmetric transitions.
  static const Curve smooth = Curves.easeInOut;

  /// Deceleration curve for enter animations.
  static const Curve decelerate = Curves.decelerate;
}
