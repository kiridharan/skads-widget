// Token system templates for `skad init`.

/// SkadTokens — Design tokens as ThemeExtension.
const tokensTemplate = r"""
import 'package:flutter/material.dart';

@immutable
class SkadTokens extends ThemeExtension<SkadTokens> {
  final Color background;
  final Color foreground;
  final Color primary;
  final Color primaryForeground;
  final Color secondary;
  final Color secondaryForeground;
  final Color muted;
  final Color mutedForeground;
  final Color destructive;
  final Color destructiveForeground;
  final Color border;
  final Color ring;
  final Color card;
  final Color cardForeground;
  final double radiusSm;
  final double radiusMd;
  final double radiusLg;
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
    Color? background, Color? foreground, Color? primary,
    Color? primaryForeground, Color? secondary, Color? secondaryForeground,
    Color? muted, Color? mutedForeground, Color? destructive,
    Color? destructiveForeground, Color? border, Color? ring,
    Color? card, Color? cardForeground,
    double? radiusSm, double? radiusMd, double? radiusLg, double? radiusFull,
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
      destructiveForeground: destructiveForeground ?? this.destructiveForeground,
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
      primaryForeground: Color.lerp(primaryForeground, other.primaryForeground, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      secondaryForeground: Color.lerp(secondaryForeground, other.secondaryForeground, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      mutedForeground: Color.lerp(mutedForeground, other.mutedForeground, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      destructiveForeground: Color.lerp(destructiveForeground, other.destructiveForeground, t)!,
      border: Color.lerp(border, other.border, t)!,
      ring: Color.lerp(ring, other.ring, t)!,
      card: Color.lerp(card, other.card, t)!,
      cardForeground: Color.lerp(cardForeground, other.cardForeground, t)!,
      radiusSm: radiusSm + (other.radiusSm - radiusSm) * t,
      radiusMd: radiusMd + (other.radiusMd - radiusMd) * t,
      radiusLg: radiusLg + (other.radiusLg - radiusLg) * t,
      radiusFull: radiusFull + (other.radiusFull - radiusFull) * t,
    );
  }
}
""";

/// SkadTheme — Theme helper.
const themeTemplate = r"""
import 'package:flutter/material.dart';
import 'skad_tokens.dart';

class SkadTheme {
  SkadTheme._();

  static SkadTokens of(BuildContext context) {
    final tokens = Theme.of(context).extension<SkadTokens>();
    assert(tokens != null, 'SkadTokens not found in Theme.');
    return tokens!;
  }

  static SkadTokens? maybeOf(BuildContext context) {
    return Theme.of(context).extension<SkadTokens>();
  }

  static ThemeData light({SkadTokens? tokens}) {
    final t = tokens ?? SkadTokens.light();
    return ThemeData.light().copyWith(
      extensions: [t],
      scaffoldBackgroundColor: t.background,
      colorScheme: ColorScheme.light(
        primary: t.primary,
        secondary: t.secondary,
        error: t.destructive,
        surface: t.card,
      ),
    );
  }

  static ThemeData dark({SkadTokens? tokens}) {
    final t = tokens ?? SkadTokens.dark();
    return ThemeData.dark().copyWith(
      extensions: [t],
      scaffoldBackgroundColor: t.background,
      colorScheme: ColorScheme.dark(
        primary: t.primary,
        secondary: t.secondary,
        error: t.destructive,
        surface: t.card,
      ),
    );
  }
}
""";

/// SkadMotion — Animation tokens.
const motionTemplate = r"""
import 'package:flutter/animation.dart';

class SkadMotion {
  SkadMotion._();

  static const Duration fast = Duration(milliseconds: 100);
  static const Duration normal = Duration(milliseconds: 200);
  static const Duration slow = Duration(milliseconds: 300);
  static const Duration extraSlow = Duration(milliseconds: 500);

  static const Curve curve = Curves.easeOut;
  static const Curve spring = Curves.elasticOut;
  static const Curve smooth = Curves.easeInOut;
  static const Curve decelerate = Curves.decelerate;
}
""";
