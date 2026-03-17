/// skad — A composable, copy-first Flutter design system.
///
/// Inspired by shadcn/ui. Provides theme-aware widgets with a token-based
/// design system and a CLI for copy-paste component ownership.
///
/// ## Quick Start
///
/// ```dart
/// import 'package:skad/skad.dart';
///
/// MaterialApp(
///   theme: SkadTheme.light(),
///   darkTheme: SkadTheme.dark(),
///   home: Scaffold(
///     body: SkadButton(
///       onPressed: () {},
///       child: Text('Hello skad'),
///     ),
///   ),
/// )
/// ```
library;

// Core — Tokens & Theme
export 'src/core/tokens/skad_tokens.dart';
export 'src/core/theme/skad_theme.dart';
export 'src/core/motion/skad_motion.dart';

// Widgets
export 'src/widgets/button/skad_button.dart';
export 'src/widgets/input/skad_input.dart';
export 'src/widgets/dialog/skad_dialog.dart';
