import 'package:flutter/material.dart';

import '../tokens/skad_tokens.dart';

/// Helper to access [SkadTokens] from the current [BuildContext].
///
/// ```dart
/// final tokens = SkadTheme.of(context);
/// Container(color: tokens.primary);
/// ```
class SkadTheme {
  SkadTheme._();

  /// Returns the [SkadTokens] from the nearest [Theme].
  ///
  /// Throws if [SkadTokens] is not found in the theme extensions.
  static SkadTokens of(BuildContext context) {
    final tokens = Theme.of(context).extension<SkadTokens>();
    assert(
        tokens != null,
        'SkadTokens not found in Theme. '
        'Wrap your app with a Theme that includes SkadTokens in extensions.');
    return tokens!;
  }

  /// Returns [SkadTokens] or null if not present.
  static SkadTokens? maybeOf(BuildContext context) {
    return Theme.of(context).extension<SkadTokens>();
  }

  /// Creates a [ThemeData] with [SkadTokens] baked in.
  ///
  /// ```dart
  /// MaterialApp(
  ///   theme: SkadTheme.light(),
  ///   darkTheme: SkadTheme.dark(),
  /// )
  /// ```
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

  /// Creates a dark [ThemeData] with [SkadTokens] baked in.
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
