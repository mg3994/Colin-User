// ignore_for_file: avoid_print

// TODO: Change full logic and lets redesign this fully as and Global Executable

import 'dart:io';

Future<void> main(List<String> arguments) async {
  // Define the path to the target directory
  const targetDirectory = 'shared/l10n';

  // Change the current working directory
  try {
    Directory.current = targetDirectory;

    print('Changed directory to: $targetDirectory');
  } catch (e) {
    print('Error changing directory: $e');
    exit(1);
  }

  // Execute the intl_utils:generate command
  final result = await Process.run(
    'dart',
    ['run', 'intl_utils:generate'],
    runInShell: true,
  );

  // Print the output and handle errors
  if (result.exitCode == 0) {
    print('intl_utils:generate executed successfully.');
    print(result.stdout);

    // Optionally return to the original directory
    Directory.current = Directory.current.parent.path;
    Directory.current = Directory.current.parent.path;
    print(Directory.current);
  } else {
    print('Error executing intl_utils:generate:');
    print(result.stderr);

    // Optionally return to the original directory
    Directory.current = Directory.current.parent.path;
    Directory.current = Directory.current.parent.path;
    print(Directory.current);

    exit(result.exitCode);
  }
}
