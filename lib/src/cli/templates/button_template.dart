// Button widget template for `skad add button`.

const buttonTemplateFiles = {
  'skad_button.dart': _buttonSource,
};

const _buttonSource = r"""
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/skad_tokens.dart';
import '../core/skad_motion.dart';

enum SkadButtonVariant { primary, secondary, outline, ghost, destructive }
enum SkadButtonSize { sm, md, lg, icon }

class SkadButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final SkadButtonVariant variant;
  final SkadButtonSize size;
  final bool isLoading;
  final Widget? icon;
  final Widget? trailingIcon;
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
    final tokens = Theme.of(context).extension<SkadTokens>() ?? SkadTokens.light();
    final style = _resolveStyle(tokens);
    final sizing = _resolveSizing();

    return Semantics(
      button: true,
      enabled: !_isDisabled,
      child: FocusableActionDetector(
        onShowHoverHighlight: (hover) => setState(() => _isHovered = hover),
        onShowFocusHighlight: (focus) => setState(() => _isFocused = focus),
        mouseCursor: _isDisabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
          LogicalKeySet(LogicalKeyboardKey.space): const ActivateIntent(),
        },
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) { if (!_isDisabled) widget.onPressed?.call(); return null; },
          ),
        },
        child: GestureDetector(
          onTapDown: _isDisabled ? null : (_) => setState(() => _isPressed = true),
          onTapUp: _isDisabled ? null : (_) => setState(() => _isPressed = false),
          onTapCancel: _isDisabled ? null : () => setState(() => _isPressed = false),
          onTap: _isDisabled ? null : widget.onPressed,
          child: AnimatedContainer(
            duration: SkadMotion.fast,
            curve: SkadMotion.curve,
            width: widget.fullWidth ? double.infinity : null,
            height: sizing.height,
            padding: sizing.padding,
            decoration: BoxDecoration(
              color: _isPressed ? style.pressedBg : _isHovered ? style.hoverBg : style.bg,
              borderRadius: BorderRadius.circular(tokens.radiusMd),
              border: style.border,
              boxShadow: _isFocused ? [BoxShadow(color: tokens.ring.withValues(alpha: 0.5), blurRadius: 0, spreadRadius: 2)] : null,
            ),
            child: AnimatedOpacity(
              duration: SkadMotion.fast,
              opacity: _isDisabled ? 0.5 : 1.0,
              child: Row(
                mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.isLoading) ...[
                    SizedBox(height: sizing.iconSize, width: sizing.iconSize, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(style.fg))),
                    const SizedBox(width: 8),
                  ] else if (widget.icon != null) ...[
                    IconTheme(data: IconThemeData(color: style.fg, size: sizing.iconSize), child: widget.icon!),
                    if (widget.size != SkadButtonSize.icon) const SizedBox(width: 8),
                  ],
                  if (widget.size != SkadButtonSize.icon)
                    DefaultTextStyle(style: TextStyle(color: style.fg, fontSize: sizing.fontSize, fontWeight: FontWeight.w500, height: 1.0), child: widget.child),
                  if (widget.trailingIcon != null) ...[
                    const SizedBox(width: 8),
                    IconTheme(data: IconThemeData(color: style.fg, size: sizing.iconSize), child: widget.trailingIcon!),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _BtnStyle _resolveStyle(SkadTokens tokens) {
    switch (widget.variant) {
      case SkadButtonVariant.primary:
        return _BtnStyle(bg: tokens.primary, hoverBg: tokens.primary.withValues(alpha: 0.9), pressedBg: tokens.primary.withValues(alpha: 0.8), fg: tokens.primaryForeground);
      case SkadButtonVariant.secondary:
        return _BtnStyle(bg: tokens.secondary, hoverBg: tokens.secondary.withValues(alpha: 0.8), pressedBg: tokens.secondary.withValues(alpha: 0.7), fg: tokens.secondaryForeground);
      case SkadButtonVariant.outline:
        return _BtnStyle(bg: Colors.transparent, hoverBg: tokens.secondary, pressedBg: tokens.secondary.withValues(alpha: 0.8), fg: tokens.foreground, border: Border.all(color: tokens.border));
      case SkadButtonVariant.ghost:
        return _BtnStyle(bg: Colors.transparent, hoverBg: tokens.secondary, pressedBg: tokens.secondary.withValues(alpha: 0.8), fg: tokens.foreground);
      case SkadButtonVariant.destructive:
        return _BtnStyle(bg: tokens.destructive, hoverBg: tokens.destructive.withValues(alpha: 0.9), pressedBg: tokens.destructive.withValues(alpha: 0.8), fg: tokens.destructiveForeground);
    }
  }

  _BtnSizing _resolveSizing() {
    switch (widget.size) {
      case SkadButtonSize.sm: return const _BtnSizing(height: 36, padding: EdgeInsets.symmetric(horizontal: 12), fontSize: 13, iconSize: 14);
      case SkadButtonSize.md: return const _BtnSizing(height: 40, padding: EdgeInsets.symmetric(horizontal: 16), fontSize: 14, iconSize: 16);
      case SkadButtonSize.lg: return const _BtnSizing(height: 44, padding: EdgeInsets.symmetric(horizontal: 24), fontSize: 16, iconSize: 18);
      case SkadButtonSize.icon: return const _BtnSizing(height: 40, padding: EdgeInsets.all(0), fontSize: 14, iconSize: 16);
    }
  }
}

class _BtnStyle {
  final Color bg, hoverBg, pressedBg, fg;
  final Border? border;
  const _BtnStyle({required this.bg, required this.hoverBg, required this.pressedBg, required this.fg, this.border});
}

class _BtnSizing {
  final double height, fontSize, iconSize;
  final EdgeInsets padding;
  const _BtnSizing({required this.height, required this.padding, required this.fontSize, required this.iconSize});
}
""";
