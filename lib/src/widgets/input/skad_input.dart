import 'package:flutter/material.dart';

import '../../core/motion/skad_motion.dart';
import '../../core/tokens/skad_tokens.dart';

/// A composable, theme-aware text input widget.
///
/// Supports labels, error messages, helper text, prefix/suffix widgets,
/// focus ring, and disabled states. All styling from [SkadTokens].
///
/// ```dart
/// SkadInput(
///   label: 'Email',
///   hint: 'Enter your email',
///   errorText: 'Invalid email',
///   prefixIcon: Icon(Icons.email),
/// )
/// ```
class SkadInput extends StatefulWidget {
  /// Label text displayed above the input.
  final String? label;

  /// Placeholder text when empty.
  final String? hint;

  /// Error message displayed below the input (turns border red).
  final String? errorText;

  /// Helper text displayed below the input.
  final String? helperText;

  /// Widget displayed before the input text (e.g., icon).
  final Widget? prefix;

  /// Widget displayed after the input text (e.g., icon, button).
  final Widget? suffix;

  /// Whether the input is disabled.
  final bool enabled;

  /// Whether to obscure text (for passwords).
  final bool obscureText;

  /// Max lines for the input (1 = single line).
  final int maxLines;

  /// Text controller.
  final TextEditingController? controller;

  /// Called when the text changes.
  final ValueChanged<String>? onChanged;

  /// Called when editing is complete.
  final VoidCallback? onEditingComplete;

  /// Called when submitted.
  final ValueChanged<String>? onSubmitted;

  /// The type of keyboard to use.
  final TextInputType? keyboardType;

  /// Focus node for this input.
  final FocusNode? focusNode;

  /// Whether to autofocus.
  final bool autofocus;

  const SkadInput({
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.helperText,
    this.prefix,
    this.suffix,
    this.enabled = true,
    this.obscureText = false,
    this.maxLines = 1,
    this.controller,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.keyboardType,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  State<SkadInput> createState() => _SkadInputState();
}

class _SkadInputState extends State<SkadInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  bool get _hasError =>
      widget.errorText != null && widget.errorText!.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final tokens =
        Theme.of(context).extension<SkadTokens>() ?? SkadTokens.light();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(
              color: tokens.foreground,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 6),
        ],

        // Input field
        AnimatedContainer(
          duration: SkadMotion.fast,
          curve: SkadMotion.curve,
          decoration: BoxDecoration(
            color: widget.enabled ? tokens.background : tokens.muted,
            borderRadius: BorderRadius.circular(tokens.radiusMd),
            border: Border.all(
              color: _hasError
                  ? tokens.destructive
                  : _isFocused
                      ? tokens.ring
                      : tokens.border,
              width: _isFocused ? 2 : 1,
            ),
            boxShadow: _isFocused && !_hasError
                ? [
                    BoxShadow(
                      color: tokens.ring.withValues(alpha: 0.2),
                      blurRadius: 0,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              // Prefix
              if (widget.prefix != null)
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: IconTheme(
                    data: IconThemeData(
                      color: tokens.mutedForeground,
                      size: 16,
                    ),
                    child: widget.prefix!,
                  ),
                ),

              // TextField
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  obscureText: widget.obscureText,
                  maxLines: widget.maxLines,
                  autofocus: widget.autofocus,
                  keyboardType: widget.keyboardType,
                  onChanged: widget.onChanged,
                  onEditingComplete: widget.onEditingComplete,
                  onSubmitted: widget.onSubmitted,
                  style: TextStyle(
                    color: tokens.foreground,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      color: tokens.mutedForeground,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: widget.prefix != null ? 8 : 12,
                      vertical: 10,
                    ),
                    isDense: true,
                  ),
                ),
              ),

              // Suffix
              if (widget.suffix != null)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: IconTheme(
                    data: IconThemeData(
                      color: tokens.mutedForeground,
                      size: 16,
                    ),
                    child: widget.suffix!,
                  ),
                ),
            ],
          ),
        ),

        // Error or Helper text
        if (_hasError) ...[
          const SizedBox(height: 6),
          Text(
            widget.errorText!,
            style: TextStyle(
              color: tokens.destructive,
              fontSize: 12,
            ),
          ),
        ] else if (widget.helperText != null) ...[
          const SizedBox(height: 6),
          Text(
            widget.helperText!,
            style: TextStyle(
              color: tokens.mutedForeground,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}
