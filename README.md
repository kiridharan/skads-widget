# skad

A composable, copy-first Flutter design system inspired by [shadcn/ui](https://ui.shadcn.com).

[![pub package](https://img.shields.io/pub/v/skad.svg)](https://pub.dev/packages/skad)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

> **You own the code.** Use as a package dependency or copy widgets directly into your project via CLI.

## ✨ Features

- 🎨 **Token-based theming** — Design tokens via `ThemeExtension`, light/dark presets
- 📋 **Copy-first CLI** — `skad add button` copies source into your project
- 🧩 **Composable widgets** — Button (5 variants), Input, Dialog
- 🎬 **Motion system** — Consistent animation tokens across all widgets
- ♿ **Accessible** — Focus rings, keyboard navigation, semantic labels
- 🖥 **Cross-platform** — Hover/focus for desktop/web, tap for mobile

## 🚀 Quick Start

### Option 1: As a dependency

```yaml
dependencies:
  skad: ^0.1.0
```

```dart
import 'package:skad/skad.dart';

MaterialApp(
  theme: SkadTheme.light(),
  darkTheme: SkadTheme.dark(),
  home: Scaffold(
    body: SkadButton(
      onPressed: () {},
      child: Text('Hello skad'),
    ),
  ),
)
```

### Option 2: Copy-first (CLI)

```bash
# Install CLI
dart pub global activate skad

# Initialize in your Flutter project
skad init

# Add widgets you need
skad add button
skad add input
skad add dialog
```

## 🎨 Theming

All widgets use `SkadTokens` — a `ThemeExtension` with colors and radii:

```dart
// Use built-in presets
theme: SkadTheme.light(),

// Or customize tokens
theme: SkadTheme.light(
  tokens: SkadTokens.light().copyWith(
    primary: Colors.indigo,
    radiusMd: 12,
  ),
),
```

## 📦 Widgets

### Button

```dart
SkadButton(
  variant: SkadButtonVariant.primary,  // primary, secondary, outline, ghost, destructive
  size: SkadButtonSize.md,             // sm, md, lg, icon
  isLoading: false,
  icon: Icon(Icons.add),
  onPressed: () {},
  child: Text('Create'),
)
```

### Input

```dart
SkadInput(
  label: 'Email',
  hint: 'you@example.com',
  errorText: isValid ? null : 'Invalid email',
  prefix: Icon(Icons.email),
  onChanged: (value) {},
)
```

### Dialog

```dart
final confirmed = await showSkadDialog<bool>(
  context: context,
  title: 'Delete item?',
  description: 'This action cannot be undone.',
  actions: [
    SkadButton(
      variant: SkadButtonVariant.outline,
      onPressed: () => Navigator.pop(context, false),
      child: Text('Cancel'),
    ),
    SkadButton(
      variant: SkadButtonVariant.destructive,
      onPressed: () => Navigator.pop(context, true),
      child: Text('Delete'),
    ),
  ],
);
```

## 🎬 Motion

Consistent animations via `SkadMotion`:

```dart
AnimatedContainer(
  duration: SkadMotion.fast,    // 100ms
  curve: SkadMotion.curve,      // easeOut
)
```

| Token       | Duration | Use Case                   |
| ----------- | -------- | -------------------------- |
| `fast`      | 100ms    | Hover, micro-interactions  |
| `normal`    | 200ms    | Default transitions        |
| `slow`      | 300ms    | Overlays, page transitions |
| `extraSlow` | 500ms    | Dramatic reveals           |

## 📄 License

MIT — see [LICENSE](LICENSE).
