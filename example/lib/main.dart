import 'package:flutter/material.dart';
import 'package:skad/skad.dart';

void main() {
  runApp(const SkadExampleApp());
}

class SkadExampleApp extends StatefulWidget {
  const SkadExampleApp({super.key});

  @override
  State<SkadExampleApp> createState() => _SkadExampleAppState();
}

class _SkadExampleAppState extends State<SkadExampleApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'skad Example',
      debugShowCheckedModeBanner: false,
      theme: SkadTheme.light(),
      darkTheme: SkadTheme.dark(),
      themeMode: _themeMode,
      home: ExamplePage(onToggleTheme: _toggleTheme),
    );
  }
}

class ExamplePage extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const ExamplePage({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    final tokens = SkadTheme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'skad',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: tokens.foreground,
                      ),
                    ),
                    SkadButton(
                      variant: SkadButtonVariant.outline,
                      size: SkadButtonSize.icon,
                      icon: Icon(
                        Theme.of(context).brightness == Brightness.dark
                            ? Icons.light_mode
                            : Icons.dark_mode,
                      ),
                      onPressed: onToggleTheme,
                      child: const SizedBox.shrink(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'A composable, copy-first Flutter design system.',
                  style: TextStyle(
                    fontSize: 16,
                    color: tokens.mutedForeground,
                  ),
                ),
                const SizedBox(height: 32),

                // CLI quick start section
                const _SectionTitle('CLI Init & Add Widgets'),
                const SizedBox(height: 16),
                const _CommandCard(
                  title: '1. Initialize skad in your Flutter app',
                  command: 'skad init',
                ),
                const SizedBox(height: 12),
                const _CommandCard(
                  title: '2. Add widgets after init',
                  command: 'skad add button\nskad add input\nskad add dialog',
                ),
                const SizedBox(height: 16),
                const _WidgetBulletList(),
                const SizedBox(height: 40),

                // Buttons section
                const _SectionTitle('Button Variants'),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    SkadButton(
                      variant: SkadButtonVariant.primary,
                      onPressed: () {},
                      child: const Text('Primary'),
                    ),
                    SkadButton(
                      variant: SkadButtonVariant.secondary,
                      onPressed: () {},
                      child: const Text('Secondary'),
                    ),
                    SkadButton(
                      variant: SkadButtonVariant.outline,
                      onPressed: () {},
                      child: const Text('Outline'),
                    ),
                    SkadButton(
                      variant: SkadButtonVariant.ghost,
                      onPressed: () {},
                      child: const Text('Ghost'),
                    ),
                    SkadButton(
                      variant: SkadButtonVariant.destructive,
                      onPressed: () {},
                      child: const Text('Destructive'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Button sizes
                const _SectionTitle('Button Sizes'),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SkadButton(
                      size: SkadButtonSize.sm,
                      onPressed: () {},
                      child: const Text('Small'),
                    ),
                    SkadButton(
                      size: SkadButtonSize.md,
                      onPressed: () {},
                      child: const Text('Medium'),
                    ),
                    SkadButton(
                      size: SkadButtonSize.lg,
                      onPressed: () {},
                      child: const Text('Large'),
                    ),
                    SkadButton(
                      size: SkadButtonSize.icon,
                      icon: const Icon(Icons.add),
                      onPressed: () {},
                      child: const SizedBox.shrink(),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Button with icon + loading
                const _SectionTitle('Icon & Loading'),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    SkadButton(
                      icon: const Icon(Icons.mail),
                      onPressed: () {},
                      child: const Text('Login with Email'),
                    ),
                    SkadButton(
                      isLoading: true,
                      onPressed: () {},
                      child: const Text('Loading'),
                    ),
                    const SkadButton(
                      onPressed: null,
                      child: Text('Disabled'),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Input section
                const _SectionTitle('Input'),
                const SizedBox(height: 16),
                const SkadInput(
                  label: 'Email',
                  hint: 'you@example.com',
                  prefix: Icon(Icons.email_outlined),
                ),
                const SizedBox(height: 16),
                const SkadInput(
                  label: 'Password',
                  hint: 'Enter your password',
                  obscureText: true,
                  prefix: Icon(Icons.lock_outline),
                ),
                const SizedBox(height: 16),
                const SkadInput(
                  label: 'Error State',
                  hint: 'Enter value',
                  errorText: 'This field is required',
                ),
                const SizedBox(height: 16),
                const SkadInput(
                  label: 'With helper',
                  hint: 'Enter URL',
                  helperText: 'Must start with https://',
                  prefix: Icon(Icons.link),
                ),
                const SizedBox(height: 40),

                // Dialog section
                const _SectionTitle('Dialog'),
                const SizedBox(height: 16),
                SkadButton(
                  variant: SkadButtonVariant.outline,
                  onPressed: () {
                    showSkadDialog(
                      context: context,
                      title: 'Are you sure?',
                      description:
                          'This action cannot be undone. This will permanently delete your account and remove your data.',
                      actions: [
                        SkadButton(
                          variant: SkadButtonVariant.outline,
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        SkadButton(
                          variant: SkadButtonVariant.destructive,
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                  child: const Text('Open Dialog'),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    final tokens = SkadTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: tokens.foreground,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 40,
          height: 2,
          color: tokens.primary,
        ),
      ],
    );
  }
}

class _CommandCard extends StatelessWidget {
  final String title;
  final String command;

  const _CommandCard({
    required this.title,
    required this.command,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = SkadTheme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tokens.muted,
        borderRadius: BorderRadius.circular(tokens.radiusMd),
        border: Border.all(color: tokens.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: tokens.foreground,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            command,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              color: tokens.foreground,
            ),
          ),
        ],
      ),
    );
  }
}

class _WidgetBulletList extends StatelessWidget {
  const _WidgetBulletList();

  @override
  Widget build(BuildContext context) {
    final tokens = SkadTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available widgets from the CLI:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: tokens.foreground,
          ),
        ),
        const SizedBox(height: 8),
        const _WidgetBullet(
          command: 'button',
          description: 'SkadButton - 5 variants and 4 sizes.',
        ),
        const _WidgetBullet(
          command: 'input',
          description: 'SkadInput - label, hint, helper, and error states.',
        ),
        const _WidgetBullet(
          command: 'dialog',
          description: 'SkadDialog - animated dialog with custom actions.',
        ),
      ],
    );
  }
}

class _WidgetBullet extends StatelessWidget {
  final String command;
  final String description;

  const _WidgetBullet({
    required this.command,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = SkadTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14,
            color: tokens.mutedForeground,
          ),
          children: [
            const TextSpan(text: '• '),
            TextSpan(
              text: '$command: ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: tokens.foreground,
              ),
            ),
            TextSpan(text: description),
          ],
        ),
      ),
    );
  }
}
