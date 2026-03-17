import 'package:args/command_runner.dart';

import 'package:skad/src/cli/commands/init_command.dart';
import 'package:skad/src/cli/commands/add_command.dart';

/// skad CLI — copy-first Flutter design system.
///
/// Usage:
///   skad init            Initialize skad in your Flutter project
///   skad add [widget]    Add a widget to your project
void main(List<String> args) {
  final runner = CommandRunner<void>(
    'skad',
    'A composable, copy-first Flutter design system.\n'
        'Add beautiful, production-ready widgets to your Flutter project.',
  )
    ..addCommand(InitCommand())
    ..addCommand(AddCommand());

  runner.run(args).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
  });
}
