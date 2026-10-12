import 'dart:convert';
import 'dart:io';

void main() async {
  final enFile = File('assets/translations/en.json');
  final enMap = jsonDecode(await enFile.readAsString()) as Map<String, dynamic>;

  // Add missing keys to membership
  final membership = enMap['membership'] as Map<String, dynamic>;
  membership['what_happens_when_you_cancel'] = 'What happens when you cancel?';
  membership['access_continues_until'] = 'Access continues until...';
  membership['saved_stories_downloadable'] = 'Saved stories downloadable';
  membership['household_lose_access'] = 'Household loses access';
  membership['keep_my_membership'] = 'Keep my membership';
  membership['before_you_go'] = 'Before you go...';
  membership['cancel_reason_desc'] = 'Cancel reason description';
  membership['reason_not_using'] = 'Not using enough';
  membership['reason_switching'] = 'Switching to another service';
  membership['reason_something_else'] = 'Something else';
  membership['describe_issue_hint'] = 'Describe the issue...';
  membership['continue_button'] = 'Continue';
  membership['membership_cancelled'] = 'Membership Cancelled';

  // Add missing keys to parentMyOffer
  final parentMyOffer = enMap['parentMyOffer'] as Map<String, dynamic>;
  parentMyOffer['exclusiveFamilyDiscount'] = 'Exclusive Family Discount';

  final encoder = JsonEncoder.withIndent('  ');
  await enFile.writeAsString(encoder.convert(enMap) + '\n');
  print('Added missing keys to en.json');
}
