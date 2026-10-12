import 'dart:convert';
import 'dart:io';

const _sourcePath = 'assets/translations/en.json';
const _outputPath = 'lib/src/shared/localization/generated/lang_key.g.dart';
const _localePaths = <String>[
  'assets/translations/en.json',
  'assets/translations/ar.json',
  'assets/translations/fil.json',
  'assets/translations/si.json',
];

void main(List<String> arguments) {
  final localeTrees = <String, Map<String, Object?>>{};

  for (final path in _localePaths) {
    final decoded = jsonDecode(File(path).readAsStringSync());
    if (decoded is! Map<String, dynamic>) {
      throw FormatException('$path must contain a JSON object at its root.');
    }
    localeTrees[path] = decoded.cast<String, Object?>();
  }

  final sourceTree = localeTrees[_sourcePath]!;
  final sourceKeys = _leafPaths(sourceTree).toSet();

  for (final entry in localeTrees.entries) {
    final localeKeys = _leafPaths(entry.value).toSet();
    final missing = sourceKeys.difference(localeKeys).toList()..sort();
    final extra = localeKeys.difference(sourceKeys).toList()..sort();
    if (missing.isNotEmpty || extra.isNotEmpty) {
      throw StateError(
        '${entry.key} does not match $_sourcePath. '
        'Missing: $missing. Extra: $extra.',
      );
    }
  }

  final output = _generateFile(sourceTree);
  final outputFile = File(_outputPath);

  if (arguments.contains('--check')) {
    if (!outputFile.existsSync() || outputFile.readAsStringSync() != output) {
      stderr.writeln(
        'Generated localization keys are stale. Run: '
        'dart run tool/generate_lang_keys.dart',
      );
      exitCode = 1;
    }
    return;
  }

  outputFile.parent.createSync(recursive: true);
  outputFile.writeAsStringSync(output);
  stdout.writeln('Generated $_outputPath from $_sourcePath.');
}

Iterable<String> _leafPaths(
  Map<String, Object?> tree, [
  List<String> parents = const [],
]) sync* {
  for (final entry in tree.entries) {
    final path = [...parents, entry.key];
    final value = entry.value;
    if (value is Map<String, dynamic>) {
      yield* _leafPaths(value.cast<String, Object?>(), path);
    } else if (value is String) {
      yield path.join('.');
    } else {
      throw FormatException(
        'Translation ${path.join('.')} must be a string or nested object.',
      );
    }
  }
}

String _generateFile(Map<String, Object?> sourceTree) {
  final buffer = StringBuffer()
    ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND.')
    ..writeln('// Run: dart run tool/generate_lang_keys.dart')
    ..writeln()
    ..writeln(
      "import 'package:easy_localization/easy_localization.dart';",
    )
    ..writeln()
    ..writeln('abstract final class LangKey {');

  for (final entry in sourceTree.entries) {
    if (entry.value is! Map<String, dynamic>) {
      throw FormatException('Root key ${entry.key} must contain an object.');
    }
    buffer.writeln(
      '  static const ${_identifier(entry.key)} = '
      '${_className([entry.key])}();',
    );
  }
  buffer.writeln('}');

  for (final entry in sourceTree.entries) {
    _writeClass(
      buffer,
      [entry.key],
      (entry.value! as Map<String, dynamic>).cast<String, Object?>(),
    );
  }

  return buffer.toString();
}

void _writeClass(
  StringBuffer buffer,
  List<String> path,
  Map<String, Object?> tree,
) {
  buffer
    ..writeln()
    ..writeln('final class ${_className(path)} {')
    ..writeln('  const ${_className(path)}();');

  for (final entry in tree.entries) {
    final childPath = [...path, entry.key];
    final fieldName = _identifier(entry.key);
    if (entry.value is Map<String, dynamic>) {
      buffer.writeln(
        '  final $fieldName = const ${_className(childPath)}();',
      );
    } else if (entry.value is String) {
      buffer.writeln(
        '  String get $fieldName => '
        '${jsonEncode(childPath.join('.'))}.tr();',
      );
    } else {
      throw FormatException(
        'Translation ${childPath.join('.')} must be a string or nested object.',
      );
    }
  }
  buffer.writeln('}');

  for (final entry in tree.entries) {
    if (entry.value is Map<String, dynamic>) {
      _writeClass(
        buffer,
        [...path, entry.key],
        (entry.value! as Map<String, dynamic>).cast<String, Object?>(),
      );
    }
  }
}

String _className(List<String> path) {
  return '_${path.map(_pascalCase).join()}LangKeys';
}

String _identifier(String value) {
  final pascal = _pascalCase(value);
  var result = pascal[0].toLowerCase() + pascal.substring(1);
  if (RegExp(r'^\d').hasMatch(result)) {
    result = 'key$result';
  }
  if (_dartKeywords.contains(result)) {
    result = '${result}Key';
  }
  return result;
}

String _pascalCase(String value) {
  final parts =
      value.split(RegExp('[^A-Za-z0-9]+')).where((part) => part.isNotEmpty);
  final result =
      parts.map((part) => part[0].toUpperCase() + part.substring(1)).join();
  if (result.isEmpty) {
    throw FormatException('Translation key "$value" is not a Dart identifier.');
  }
  return result;
}

const _dartKeywords = <String>{
  'abstract',
  'as',
  'assert',
  'async',
  'await',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'default',
  'deferred',
  'do',
  'dynamic',
  'else',
  'enum',
  'export',
  'extends',
  'extension',
  'external',
  'factory',
  'false',
  'final',
  'finally',
  'for',
  'function',
  'get',
  'hide',
  'if',
  'implements',
  'import',
  'in',
  'interface',
  'is',
  'late',
  'library',
  'mixin',
  'new',
  'null',
  'on',
  'operator',
  'part',
  'required',
  'rethrow',
  'return',
  'sealed',
  'set',
  'show',
  'static',
  'super',
  'switch',
  'sync',
  'this',
  'throw',
  'true',
  'try',
  'typedef',
  'var',
  'void',
  'when',
  'while',
  'with',
  'yield',
};
