import 'dart:convert';
import 'dart:io';

/// Usage:
/// dart run tools/launch_with_defines.dart --json=defines.dev.json --cmd="flutter run"
/// The tool reads the JSON (map of key->value) and appends --dart-define=KEY=VALUE for each entry.

void main(List<String> args) async {
  final Map<String, String> argMap = {};
  for (final a in args) {
    if (a.startsWith('--json=')) {
      argMap['json'] = a.substring('--json='.length);
    } else if (a.startsWith('--cmd=')) {
      argMap['cmd'] = a.substring('--cmd='.length);
    }
  }

  final jsonPath = argMap['json'] ?? 'defines.dev.json';
  final cmdArg = argMap['cmd'] ?? 'flutter run';

  final file = File(jsonPath);
  if (!await file.exists()) {
    stderr.writeln('Defines file not found: $jsonPath');
    exit(2);
  }

  final content = await file.readAsString();
  final Map<String, dynamic> map = jsonDecode(content) as Map<String, dynamic>;

  final defines = <String>[];
  map.forEach((key, value) {
    final v = value?.toString() ?? '';
    // escape single quotes inside value
    final safe = v.replaceAll("'", "\\'");
    defines.add('--dart-define=$key=$safe');
  });

  // Build final command
  final parts = _splitCommand(cmdArg);
  final cmd = [...parts, ...defines];

  stdout.writeln('Running: ${cmd.join(' ')}');

  final process = await Process.start(cmd.first, cmd.sublist(1), runInShell: true);
  // pipe streams
  stdout.addStream(process.stdout);
  stderr.addStream(process.stderr);
  final exitCode = await process.exitCode;
  exit(exitCode);
}

List<String> _splitCommand(String cmd) {
  // naive split respecting quoted segments
  final List<String> parts = [];
  final buffer = StringBuffer();
  var inSingle = false;
  var inDouble = false;
  for (var i = 0; i < cmd.length; i++) {
    final ch = cmd[i];
    if (ch == "'" && !inDouble) {
      inSingle = !inSingle;
      continue;
    }
    if (ch == '"' && !inSingle) {
      inDouble = !inDouble;
      continue;
    }
    if (ch == ' ' && !inSingle && !inDouble) {
      if (buffer.isNotEmpty) {
        parts.add(buffer.toString());
        buffer.clear();
      }
      continue;
    }
    buffer.write(ch);
  }
  if (buffer.isNotEmpty) parts.add(buffer.toString());
  return parts;
}
