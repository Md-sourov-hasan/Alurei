/// Development-only options rendered by the Parent AI day setup flow.
abstract final class AiSetupGuideDummyData {
  static const genders = ['Girl', 'Boy', 'Other'];
  static const weights = [
    '0 to 6 kg',
    '6 to 9 kg',
    '9 to 12 kg',
    '12 to 20 kg',
    'Above 20 kg',
  ];
  static const activityGroups = <AiSetupActivityGroupFixture>[
    AiSetupActivityGroupFixture(
      title: 'Creative Activities',
      activities: [
        'Arts & crafts',
        'Painting',
        'Music practice',
        'Singing sessions',
        'Building blocks',
        'Puzzle time',
      ],
    ),
    AiSetupActivityGroupFixture(
      title: 'Health & Care',
      activities: [
        'Pediatrician appointments',
        'Vaccinations',
        'Physiotherapy',
        'Speech therapy',
        'Occupational therapy',
        'Regular health check-ups',
        'Dental appointments',
      ],
    ),
    AiSetupActivityGroupFixture(
      title: 'Learning & Development',
      activities: [
        'Story time',
        'Sensory play',
        'Reading sessions',
        'Flashcard practice',
        'Montessori activities',
        'Language classes',
        'Music lessons',
      ],
    ),
    AiSetupActivityGroupFixture(
      title: 'Physical Activities',
      activities: [
        'Swimming lessons',
        'Baby gym',
        'Gymnastics',
        'Dance class',
        'Playground visits',
        'Outdoor walks',
        'Tennis',
        'Rugby',
        'Soccer',
        'Basketball',
      ],
    ),
    AiSetupActivityGroupFixture(
      title: 'Social Activities',
      activities: [
        'Playdates',
        'Parent & toddler groups',
        'Library sessions',
        'Community events',
        'Birthday parties',
      ],
    ),
    AiSetupActivityGroupFixture(
      title: 'Religious & Family Activities',
      activities: [
        'Family visits',
        'Religious classes',
        'Weekend gatherings',
        'Cultural events',
      ],
    ),
  ];
}

class AiSetupActivityGroupFixture {
  const AiSetupActivityGroupFixture({
    required this.title,
    required this.activities,
  });

  final String title;
  final List<String> activities;
}
