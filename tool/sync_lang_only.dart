import 'dart:convert';
import 'dart:io';

void main() async {
  final enFile = File('assets/translations/en.json');
  final arFile = File('assets/translations/ar.json');
  final filFile = File('assets/translations/fil.json');
  final siFile = File('assets/translations/si.json');

  final enMap = jsonDecode(await enFile.readAsString()) as Map<String, dynamic>;
  final encoder = JsonEncoder.withIndent('  ');

  // Sync other languages
  for (final file in [arFile, filFile, siFile]) {
    final otherMap = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
    final newMap = <String, dynamic>{};

    for (final sectionKey in enMap.keys) {
      final enSection = enMap[sectionKey] as Map<String, dynamic>;
      final otherSection = (otherMap[sectionKey] as Map<String, dynamic>?) ?? <String, dynamic>{};
      final newSection = <String, dynamic>{};

      for (final key in enSection.keys) {
        newSection[key] = otherSection[key] ?? enSection[key];
      }
      newMap[sectionKey] = newSection;
    }

    await file.writeAsString(encoder.convert(newMap) + '\n');
  }

  print('Sync only complete.');
}
