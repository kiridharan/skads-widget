// Input widget template for `skad add input`.

const inputTemplateFiles = {
  'skad_input.dart': _inputSource,
};

const _inputSource = r"""
import 'package:flutter/material.dart';
import '../core/skad_tokens.dart';
import '../core/skad_motion.dart';

class SkadInput extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? errorText;
  final String? helperText;
  final Widget? prefix;
  final Widget? suffix;
  final bool enabled;
  final bool obscureText;
  final int maxLines;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
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

  bool get _hasError => widget.errorText != null && widget.errorText!.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) _focusNode.dispose();
    else _focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() => setState(() => _isFocused = _focusNode.hasFocus);

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<SkadTokens>() ?? SkadTokens.light();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: TextStyle(color: tokens.foreground, fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
        ],
        AnimatedContainer(
          duration: SkadMotion.fast,
          curve: SkadMotion.curve,
          decoration: BoxDecoration(
            color: widget.enabled ? tokens.background : tokens.muted,
            borderRadius: BorderRadius.circular(tokens.radiusMd),
            border: Border.all(
              color: _hasError ? tokens.destructive : _isFocused ? tokens.ring : tokens.border,
              width: _isFocused ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              if (widget.prefix != null) Padding(padding: const EdgeInsets.only(left: 12), child: IconTheme(data: IconThemeData(color: tokens.mutedForeground, size: 16), child: widget.prefix!)),
              Expanded(
                child: TextField(
                  controller: widget.controller, focusNode: _focusNode, enabled: widget.enabled,
                  obscureText: widget.obscureText, maxLines: widget.maxLines, autofocus: widget.autofocus,
                  keyboardType: widget.keyboardType, onChanged: widget.onChanged,
                  onEditingComplete: widget.onEditingComplete, onSubmitted: widget.onSubmitted,
                  style: TextStyle(color: tokens.foreground, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: widget.hint, hintStyle: TextStyle(color: tokens.mutedForeground, fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: widget.prefix != null ? 8 : 12, vertical: 10),
                    isDense: true,
                  ),
                ),
              ),
              if (widget.suffix != null) Padding(padding: const EdgeInsets.only(right: 12), child: IconTheme(data: IconThemeData(color: tokens.mutedForeground, size: 16), child: widget.suffix!)),
            ],
          ),
        ),
        if (_hasError) ...[const SizedBox(height: 6), Text(widget.errorText!, style: TextStyle(color: tokens.destructive, fontSize: 12))]
        else if (widget.helperText != null) ...[const SizedBox(height: 6), Text(widget.helperText!, style: TextStyle(color: tokens.mutedForeground, fontSize: 12))],
      ],
    );
  }
}
""";
