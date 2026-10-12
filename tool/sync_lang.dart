import 'dart:convert';
import 'dart:io';

void main() async {
  final enFile = File('assets/translations/en.json');
  final arFile = File('assets/translations/ar.json');
  final filFile = File('assets/translations/fil.json');
  final siFile = File('assets/translations/si.json');

  final enMap = jsonDecode(await enFile.readAsString()) as Map<String, dynamic>;

  // Add parentRewards
  enMap['parentRewards'] = {
    'alureiUnit': 'Alurei Unit',
    'availableBalance': 'Available Balance',
    'earn': 'Earn',
    'earnedLastWeek': 'Earned Last Week',
    'spend': 'Spend',
    'spentLastWeek': 'Spent Last Week',
    'useCareMoments': 'Use Care Moments',
    'viewOffer': 'View Offer',
    'visitAllOffers': 'Visit All Offers',
    'youGiveCare': 'You Give Care',
    'yourWellbeing': 'Your Wellbeing',
  };

  // Add parentMyOffer
  enMap['parentMyOffer'] = {
    'offerDetails': 'Offer Details',
    'availableLocations': 'Available Locations',
    'viewLocation': 'View Location',
    'visitWebsite': 'Visit Website',
    'redeemOffer': 'Redeem Offer',
    'termsAndConditions': 'Terms And Conditions',
    'whatsIncluded': 'Whats Included',
    'codeCopied': 'Code Copied',
    'copy': 'Copy',
    'inStore': 'In Store',
    'online': 'Online',
    'orTellVoucherCode': 'Or tell voucher code',
  };

  // Save en.json with pretty print
  final encoder = JsonEncoder.withIndent('  ');
  await enFile.writeAsString(encoder.convert(enMap) + '\n');

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

  print('Sync complete.');
}
