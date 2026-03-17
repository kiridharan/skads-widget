import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as p;

import '../templates/tokens_template.dart';

/// `skad init` — Initialize skad in a Flutter project.
///
/// Creates the widget directory structure and copies token files
/// so the user owns the design system code.
class InitCommand extends Command<void> {
  @override
  final name = 'init';

  @override
  final description = 'Initialize skad in your Flutter project.';

  InitCommand() {
    argParser.addOption(
      'directory',
      abbr: 'd',
      help: 'Target Flutter project directory.',
      defaultsTo: '.',
    );
  }

  @override
  Future<void> run() async {
    final projectDir = argResults!['directory'] as String;
    final libDir = p.join(projectDir, 'lib');

    // Verify this is a Flutter project
    final pubspecFile = File(p.join(projectDir, 'pubspec.yaml'));
    if (!pubspecFile.existsSync()) {
      print('❌ No pubspec.yaml found in $projectDir');
      print('   Run this command from the root of your Flutter project.');
      return;
    }

    print('🚀 Initializing skad...\n');

    // Create directory structure
    final dirs = [
      p.join(libDir, 'widgets'),
      p.join(libDir, 'core'),
    ];

    for (final dir in dirs) {
      await Directory(dir).create(recursive: true);
      print('  📁 Created ${p.relative(dir, from: projectDir)}');
    }

    // Write token files
    final tokensFile = File(p.join(libDir, 'core', 'skad_tokens.dart'));
    if (!tokensFile.existsSync()) {
      await tokensFile.writeAsString(tokensTemplate);
      print('  📄 Created core/skad_tokens.dart');
    } else {
      print('  ⏭  core/skad_tokens.dart already exists, skipping.');
    }

    final themeFile = File(p.join(libDir, 'core', 'skad_theme.dart'));
    if (!themeFile.existsSync()) {
      await themeFile.writeAsString(themeTemplate);
      print('  📄 Created core/skad_theme.dart');
    } else {
      print('  ⏭  core/skad_theme.dart already exists, skipping.');
    }

    final motionFile = File(p.join(libDir, 'core', 'skad_motion.dart'));
    if (!motionFile.existsSync()) {
      await motionFile.writeAsString(motionTemplate);
      print('  📄 Created core/skad_motion.dart');
    } else {
      print('  ⏭  core/skad_motion.dart already exists, skipping.');
    }

    print('\n✅ skad initialized!\n');
    print('Next steps:');
    print('  1. Add SkadTokens to your ThemeData:');
    print('');
    print("     import 'package:your_app/core/skad_tokens.dart';");
    print("     import 'package:your_app/core/skad_theme.dart';");
    print('');
    print('     MaterialApp(');
    print('       theme: SkadTheme.light(),');
    print('       darkTheme: SkadTheme.dark(),');
    print('     )');
    print('');
    print('  2. Add widgets:');
    print('     skad add button');
    print('     skad add input');
    print('     skad add dialog');
  }
}
