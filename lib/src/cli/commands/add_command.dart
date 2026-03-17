import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as p;

import '../templates/button_template.dart';
import '../templates/input_template.dart';
import '../templates/dialog_template.dart';

/// Available widgets that can be added via CLI.
const _availableWidgets = {
  'button': 'SkadButton — Composable button with 5 variants and 4 sizes.',
  'input': 'SkadInput — Text input with label, error, helper, prefix/suffix.',
  'dialog': 'SkadDialog — Animated dialog with title, description, actions.',
};

/// `skad add <widget>` — Copy a widget into the user's project.
///
/// This is the core differentiator — copy-first ownership.
class AddCommand extends Command<void> {
  @override
  final name = 'add';

  @override
  final description = 'Add a widget to your Flutter project.';

  AddCommand() {
    argParser.addOption(
      'directory',
      abbr: 'd',
      help: 'Target Flutter project directory.',
      defaultsTo: '.',
    );
  }

  @override
  String get invocation => 'skad add <widget>';

  @override
  Future<void> run() async {
    if (argResults!.rest.isEmpty) {
      print('❌ Please specify a widget to add.\n');
      print('Available widgets:');
      _availableWidgets.forEach((name, desc) {
        print('  • $name — $desc');
      });
      print('\nUsage: skad add <widget>');
      return;
    }

    final widgetName = argResults!.rest.first.toLowerCase();
    final projectDir = argResults!['directory'] as String;

    if (!_availableWidgets.containsKey(widgetName)) {
      print('❌ Unknown widget: "$widgetName"\n');
      print('Available widgets:');
      _availableWidgets.forEach((name, desc) {
        print('  • $name — $desc');
      });
      return;
    }

    // Verify project structure
    final pubspecFile = File(p.join(projectDir, 'pubspec.yaml'));
    if (!pubspecFile.existsSync()) {
      print('❌ No pubspec.yaml found. Run from your Flutter project root.');
      return;
    }

    // Check if init has been run
    final coreDir = Directory(p.join(projectDir, 'lib', 'core'));
    if (!coreDir.existsSync()) {
      print('⚠️  skad not initialized. Running init first...\n');
      // Auto-init is handled by the user running `skad init`
      print('Please run: skad init');
      return;
    }

    print('📦 Adding $widgetName widget...\n');

    final widgetDir = p.join(projectDir, 'lib', 'widgets', widgetName);
    await Directory(widgetDir).create(recursive: true);

    final template = _getTemplate(widgetName);
    final files = template.entries.toList();

    for (final entry in files) {
      final filePath = p.join(widgetDir, entry.key);
      final file = File(filePath);

      if (file.existsSync()) {
        print(
            '  ⏭  ${p.relative(filePath, from: projectDir)} already exists, skipping.');
        continue;
      }

      await file.writeAsString(entry.value);
      print('  📄 Created ${p.relative(filePath, from: projectDir)}');
    }

    print('\n✅ Added $widgetName widget!\n');
    _printUsageExample(widgetName);
  }

  Map<String, String> _getTemplate(String widgetName) {
    switch (widgetName) {
      case 'button':
        return buttonTemplateFiles;
      case 'input':
        return inputTemplateFiles;
      case 'dialog':
        return dialogTemplateFiles;
      default:
        return {};
    }
  }

  void _printUsageExample(String widgetName) {
    switch (widgetName) {
      case 'button':
        print('Usage:');
        print('  SkadButton(');
        print('    variant: SkadButtonVariant.primary,');
        print('    onPressed: () {},');
        print("    child: Text('Click me'),");
        print('  )');
        break;
      case 'input':
        print('Usage:');
        print('  SkadInput(');
        print("    label: 'Email',");
        print("    hint: 'Enter your email',");
        print('    onChanged: (value) {},');
        print('  )');
        break;
      case 'dialog':
        print('Usage:');
        print('  showSkadDialog(');
        print('    context: context,');
        print("    title: 'Confirm',");
        print("    description: 'Are you sure?',");
        print('    actions: [...],');
        print('  )');
        break;
    }
  }
}
