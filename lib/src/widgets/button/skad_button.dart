import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/motion/skad_motion.dart';
import '../../core/tokens/skad_tokens.dart';

/// Button variants matching shadcn/ui design system.
enum SkadButtonVariant {
  /// Solid primary button with brand color.
  primary,

  /// Subtle secondary button with muted background.
  secondary,

  /// Bordered outline button with transparent background.
  outline,

  /// Minimal ghost button — no background until hover.
  ghost,

  /// Red destructive button for dangerous actions.
  destructive,
}

/// Button sizes.
enum SkadButtonSize {
  /// Small button (height: 36, font: 13).
  sm,

  /// Default button (height: 40, font: 14).
  md,

  /// Large button (height: 44, font: 16).
  lg,

  /// Icon-only button (square, 40x40).
  icon,
}

/// A composable, theme-aware button widget.
///
/// Supports 5 variants, 4 sizes, loading states, and icon slots.
/// All styling comes from [SkadTokens] — no hardcoded colors.
///
/// ```dart
/// SkadButton(
///   variant: SkadButtonVariant.primary,
///   size: SkadButtonSize.md,
///   onPressed: () {},
///   child: Text('Click me'),
/// )
/// ```
class SkadButton extends StatefulWidget {
  /// The button's content (typically a [Text] widget).
  final Widget child;

  /// Called when the button is tapped. Null disables the button.
  final VoidCallback? onPressed;

  /// Visual variant of the button.
  final SkadButtonVariant variant;

  /// Size preset for the button.
  final SkadButtonSize size;

  /// Whether to show a loading spinner instead of child.
  final bool isLoading;

  /// Optional icon displayed before the child.
  final Widget? icon;

  /// Optional icon displayed after the child.
  final Widget? trailingIcon;

  /// Whether the button should take the full width.
  final bool fullWidth;

  const SkadButton({
    super.key,
    required this.child,
    this.onPressed,
    this.variant = SkadButtonVariant.primary,
    this.size = SkadButtonSize.md,
    this.isLoading = false,
    this.icon,
    this.trailingIcon,
    this.fullWidth = false,
  });

  @override
  State<SkadButton> createState() => _SkadButtonState();
}

class _SkadButtonState extends State<SkadButton> {
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  bool get _isDisabled => widget.onPressed == null || widget.isLoading;

  @override
  Widget build(BuildContext context) {
    final tokens =
        Theme.of(context).extension<SkadTokens>() ?? SkadTokens.light();
    final style = _resolveStyle(tokens);
    final sizing = _resolveSizing();

    return Semantics(
      button: true,
      enabled: !_isDisabled,
      child: FocusableActionDetector(
        onShowHoverHighlight: (hover) => setState(() => _isHovered = hover),
        onShowFocusHighlight: (focus) => setState(() => _isFocused = focus),
        mouseCursor: _isDisabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click,
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
          LogicalKeySet(LogicalKeyboardKey.space): const ActivateIntent(),
        },
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              if (!_isDisabled) widget.onPressed?.call();
              return null;
            },
          ),
        },
        child: GestureDetector(
          onTapDown:
              _isDisabled ? null : (_) => setState(() => _isPressed = true),
          onTapUp:
              _isDisabled ? null : (_) => setState(() => _isPressed = false),
          onTapCancel:
              _isDisabled ? null : () => setState(() => _isPressed = false),
          onTap: _isDisabled ? null : widget.onPressed,
          child: AnimatedContainer(
            duration: SkadMotion.fast,
            curve: SkadMotion.curve,
            width: widget.fullWidth ? double.infinity : null,
            height: sizing.height,
            padding: sizing.padding,
            decoration: BoxDecoration(
              color: _resolveBackground(style),
              borderRadius: BorderRadius.circular(tokens.radiusMd),
              border: style.border,
              boxShadow: _isFocused
                  ? [
                      BoxShadow(
                        color: tokens.ring.withValues(alpha: 0.5),
                        blurRadius: 0,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: AnimatedOpacity(
              duration: SkadMotion.fast,
              opacity: _isDisabled ? 0.5 : 1.0,
              child: Row(
                mainAxisSize:
                    widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.isLoading) ...[
                    SizedBox(
                      height: sizing.iconSize,
                      width: sizing.iconSize,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(style.foreground),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ] else if (widget.icon != null) ...[
                    IconTheme(
                      data: IconThemeData(
                        color: style.foreground,
                        size: sizing.iconSize,
                      ),
                      child: widget.icon!,
                    ),
                    if (widget.size != SkadButtonSize.icon)
                      const SizedBox(width: 8),
                  ],
                  if (widget.size != SkadButtonSize.icon)
                    DefaultTextStyle(
                      style: TextStyle(
                        color: style.foreground,
                        fontSize: sizing.fontSize,
                        fontWeight: FontWeight.w500,
                        height: 1.0,
                      ),
                      child: widget.child,
                    ),
                  if (widget.trailingIcon != null) ...[
                    const SizedBox(width: 8),
                    IconTheme(
                      data: IconThemeData(
                        color: style.foreground,
                        size: sizing.iconSize,
                      ),
                      child: widget.trailingIcon!,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _resolveBackground(_SkadButtonStyle style) {
    if (_isPressed) return style.pressedBackground;
    if (_isHovered) return style.hoverBackground;
    return style.background;
  }

  _SkadButtonStyle _resolveStyle(SkadTokens tokens) {
    switch (widget.variant) {
      case SkadButtonVariant.primary:
        return _SkadButtonStyle(
          background: tokens.primary,
          hoverBackground: tokens.primary.withValues(alpha: 0.9),
          pressedBackground: tokens.primary.withValues(alpha: 0.8),
          foreground: tokens.primaryForeground,
        );
      case SkadButtonVariant.secondary:
        return _SkadButtonStyle(
          background: tokens.secondary,
          hoverBackground: tokens.secondary.withValues(alpha: 0.8),
          pressedBackground: tokens.secondary.withValues(alpha: 0.7),
          foreground: tokens.secondaryForeground,
        );
      case SkadButtonVariant.outline:
        return _SkadButtonStyle(
          background: Colors.transparent,
          hoverBackground: tokens.secondary,
          pressedBackground: tokens.secondary.withValues(alpha: 0.8),
          foreground: tokens.foreground,
          border: Border.all(color: tokens.border),
        );
      case SkadButtonVariant.ghost:
        return _SkadButtonStyle(
          background: Colors.transparent,
          hoverBackground: tokens.secondary,
          pressedBackground: tokens.secondary.withValues(alpha: 0.8),
          foreground: tokens.foreground,
        );
      case SkadButtonVariant.destructive:
        return _SkadButtonStyle(
          background: tokens.destructive,
          hoverBackground: tokens.destructive.withValues(alpha: 0.9),
          pressedBackground: tokens.destructive.withValues(alpha: 0.8),
          foreground: tokens.destructiveForeground,
        );
    }
  }

  _SkadButtonSizing _resolveSizing() {
    switch (widget.size) {
      case SkadButtonSize.sm:
        return const _SkadButtonSizing(
          height: 36,
          padding: EdgeInsets.symmetric(horizontal: 12),
          fontSize: 13,
          iconSize: 14,
        );
      case SkadButtonSize.md:
        return const _SkadButtonSizing(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 16),
          fontSize: 14,
          iconSize: 16,
        );
      case SkadButtonSize.lg:
        return const _SkadButtonSizing(
          height: 44,
          padding: EdgeInsets.symmetric(horizontal: 24),
          fontSize: 16,
          iconSize: 18,
        );
      case SkadButtonSize.icon:
        return const _SkadButtonSizing(
          height: 40,
          padding: EdgeInsets.all(0),
          fontSize: 14,
          iconSize: 16,
        );
    }
  }
}

class _SkadButtonStyle {
  final Color background;
  final Color hoverBackground;
  final Color pressedBackground;
  final Color foreground;
  final Border? border;

  const _SkadButtonStyle({
    required this.background,
    required this.hoverBackground,
    required this.pressedBackground,
    required this.foreground,
    this.border,
  });
}

class _SkadButtonSizing {
  final double height;
  final EdgeInsets padding;
  final double fontSize;
  final double iconSize;

  const _SkadButtonSizing({
    required this.height,
    required this.padding,
    required this.fontSize,
    required this.iconSize,
  });
}
