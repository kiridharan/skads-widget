import 'package:flutter/material.dart';

/// Design tokens for the skad design system.
///
/// Extend your [ThemeData] with [SkadTokens] to provide consistent
/// styling across all skad widgets.
///
/// ```dart
/// ThemeData(
///   extensions: [SkadTokens.light()],
/// )
/// ```
@immutable
class SkadTokens extends ThemeExtension<SkadTokens> {
  /// Background color for surfaces.
  final Color background;

  /// Primary text and icon color.
  final Color foreground;

  /// Primary brand color (buttons, links, accents).
  final Color primary;

  /// Foreground color on primary surfaces.
  final Color primaryForeground;

  /// Secondary/subtle accent color.
  final Color secondary;

  /// Foreground color on secondary surfaces.
  final Color secondaryForeground;

  /// Muted/disabled background color.
  final Color muted;

  /// Foreground color on muted surfaces.
  final Color mutedForeground;

  /// Destructive/error color.
  final Color destructive;

  /// Foreground color on destructive surfaces.
  final Color destructiveForeground;

  /// Border color.
  final Color border;

  /// Focus ring color.
  final Color ring;

  /// Card/surface background.
  final Color card;

  /// Foreground color on card surfaces.
  final Color cardForeground;

  /// Small border radius.
  final double radiusSm;

  /// Medium border radius.
  final double radiusMd;

  /// Large border radius.
  final double radiusLg;

  /// Full (pill) border radius.
  final double radiusFull;

  const SkadTokens({
    required this.background,
    required this.foreground,
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryForeground,
    required this.muted,
    required this.mutedForeground,
    required this.destructive,
    required this.destructiveForeground,
    required this.border,
    required this.ring,
    required this.card,
    required this.cardForeground,
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
    required this.radiusFull,
  });

  /// Light theme preset inspired by shadcn/ui zinc palette.
  factory SkadTokens.light() {
    return const SkadTokens(
      background: Color(0xFFFFFFFF),
      foreground: Color(0xFF09090B),
      primary: Color(0xFF18181B),
      primaryForeground: Color(0xFFFAFAFA),
      secondary: Color(0xFFF4F4F5),
      secondaryForeground: Color(0xFF18181B),
      muted: Color(0xFFF4F4F5),
      mutedForeground: Color(0xFF71717A),
      destructive: Color(0xFFEF4444),
      destructiveForeground: Color(0xFFFAFAFA),
      border: Color(0xFFE4E4E7),
      ring: Color(0xFF18181B),
      card: Color(0xFFFFFFFF),
      cardForeground: Color(0xFF09090B),
      radiusSm: 6.0,
      radiusMd: 8.0,
      radiusLg: 12.0,
      radiusFull: 9999.0,
    );
  }

  /// Dark theme preset inspired by shadcn/ui zinc palette.
  factory SkadTokens.dark() {
    return const SkadTokens(
      background: Color(0xFF09090B),
      foreground: Color(0xFFFAFAFA),
      primary: Color(0xFFFAFAFA),
      primaryForeground: Color(0xFF18181B),
      secondary: Color(0xFF27272A),
      secondaryForeground: Color(0xFFFAFAFA),
      muted: Color(0xFF27272A),
      mutedForeground: Color(0xFFA1A1AA),
      destructive: Color(0xFF7F1D1D),
      destructiveForeground: Color(0xFFFAFAFA),
      border: Color(0xFF27272A),
      ring: Color(0xFFD4D4D8),
      card: Color(0xFF09090B),
      cardForeground: Color(0xFFFAFAFA),
      radiusSm: 6.0,
      radiusMd: 8.0,
      radiusLg: 12.0,
      radiusFull: 9999.0,
    );
  }

  @override
  SkadTokens copyWith({
    Color? background,
    Color? foreground,
    Color? primary,
    Color? primaryForeground,
    Color? secondary,
    Color? secondaryForeground,
    Color? muted,
    Color? mutedForeground,
    Color? destructive,
    Color? destructiveForeground,
    Color? border,
    Color? ring,
    Color? card,
    Color? cardForeground,
    double? radiusSm,
    double? radiusMd,
    double? radiusLg,
    double? radiusFull,
  }) {
    return SkadTokens(
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      primary: primary ?? this.primary,
      primaryForeground: primaryForeground ?? this.primaryForeground,
      secondary: secondary ?? this.secondary,
      secondaryForeground: secondaryForeground ?? this.secondaryForeground,
      muted: muted ?? this.muted,
      mutedForeground: mutedForeground ?? this.mutedForeground,
      destructive: destructive ?? this.destructive,
      destructiveForeground:
          destructiveForeground ?? this.destructiveForeground,
      border: border ?? this.border,
      ring: ring ?? this.ring,
      card: card ?? this.card,
      cardForeground: cardForeground ?? this.cardForeground,
      radiusSm: radiusSm ?? this.radiusSm,
      radiusMd: radiusMd ?? this.radiusMd,
      radiusLg: radiusLg ?? this.radiusLg,
      radiusFull: radiusFull ?? this.radiusFull,
    );
  }

  @override
  SkadTokens lerp(ThemeExtension<SkadTokens>? other, double t) {
    if (other is! SkadTokens) return this;
    return SkadTokens(
      background: Color.lerp(background, other.background, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryForeground:
          Color.lerp(primaryForeground, other.primaryForeground, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      secondaryForeground:
          Color.lerp(secondaryForeground, other.secondaryForeground, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      mutedForeground: Color.lerp(mutedForeground, other.mutedForeground, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      destructiveForeground:
          Color.lerp(destructiveForeground, other.destructiveForeground, t)!,
      border: Color.lerp(border, other.border, t)!,
      ring: Color.lerp(ring, other.ring, t)!,
      card: Color.lerp(card, other.card, t)!,
      cardForeground: Color.lerp(cardForeground, other.cardForeground, t)!,
      radiusSm: lerpDouble(radiusSm, other.radiusSm, t) ?? radiusSm,
      radiusMd: lerpDouble(radiusMd, other.radiusMd, t) ?? radiusMd,
      radiusLg: lerpDouble(radiusLg, other.radiusLg, t) ?? radiusLg,
      radiusFull: lerpDouble(radiusFull, other.radiusFull, t) ?? radiusFull,
    );
  }
}

double? lerpDouble(double a, double b, double t) {
  return a + (b - a) * t;
}
