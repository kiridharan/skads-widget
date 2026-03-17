// Dialog widget template for `skad add dialog`.

const dialogTemplateFiles = {
  'skad_dialog.dart': _dialogSource,
};

const _dialogSource = r"""
import 'package:flutter/material.dart';
import '../core/skad_tokens.dart';
import '../core/skad_motion.dart';

Future<T?> showSkadDialog<T>({
  required BuildContext context,
  String? title,
  String? description,
  Widget? content,
  List<Widget>? actions,
  bool barrierDismissible = true,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: SkadMotion.normal,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: SkadMotion.curve),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.95, end: 1.0).animate(CurvedAnimation(parent: animation, curve: SkadMotion.curve)),
          child: child,
        ),
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      return SkadDialog(title: title, description: description, content: content, actions: actions);
    },
  );
}

class SkadDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final Widget? content;
  final List<Widget>? actions;
  final double maxWidth;

  const SkadDialog({super.key, this.title, this.description, this.content, this.actions, this.maxWidth = 420});

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<SkadTokens>() ?? SkadTokens.light();

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: tokens.card,
              borderRadius: BorderRadius.circular(tokens.radiusLg),
              border: Border.all(color: tokens.border),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 8))],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null) Text(title!, style: TextStyle(color: tokens.cardForeground, fontSize: 18, fontWeight: FontWeight.w600, height: 1.3)),
                  if (description != null) ...[const SizedBox(height: 8), Text(description!, style: TextStyle(color: tokens.mutedForeground, fontSize: 14, height: 1.5))],
                  if (content != null) ...[const SizedBox(height: 16), content!],
                  if (actions != null && actions!.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [for (int i = 0; i < actions!.length; i++) ...[if (i > 0) const SizedBox(width: 8), actions![i]]]),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
""";
