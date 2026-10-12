/// Centralized fixture payload for the parent bedtime story flow.
abstract final class BedtimeStoryDummyData {
  static const Map<String, Object?> story = {
    'child_name': 'Eve',
    'cover_asset': 'assets/images/activity_playground.png',
    'cover_title': "Eve story inspired by today's adventures.",
    'hero_label': 'Hero: Eve',
    'generated_track': {
      'id': 'alurei-story',
      'title': 'Listen to the story',
      'duration_seconds': 12,
      'position_seconds': 0,
      'can_delete': false,
      'asset_path': 'audio/bedtime_story_dummy.wav',
    },
    'transcript': 'Today Eve awoke excited for a new adventure. After enjoying her delicious honey-drizzled banana oat pancakes, she grabbed her trusty imaginary magnifying glass and discovered a magical forest filled with colorful, glowing treasures just past the play garden.\n\n'
        'The warm sun danced through the leafy canopies as Eve danced to sweet acoustic lullabies. For every peaceful spin and leap, a small golden light would appear, whispering stories of ancient trees and playful woodland friends who loved to hide tiny treasures.\n\n'
        'As twilight arrived, Eve completed her quiet care transitions beautifully. Wearing her cozy forest-green pajamas, she shared sweet blocks and organic toys generously with a playmate, showing wonderful kindness.\n\n'
        'Now, soft silver moonbeams wrap the magical forest in a peaceful slumber. The stars shine like warm nightlights, humming a gentle sleep song. Cuddled up under comfortable blankets, Eve drifts into beautiful dreams, deeply loved and safe.',
    'family_tracks': [
      {
        'id': 'dad-story',
        'title': "Dad's Story",
        'duration_seconds': 12,
        'position_seconds': 0,
        'can_delete': true,
        'asset_path': 'audio/bedtime_story_dummy.wav',
      },
      {
        'id': 'grandma-story',
        'title': "Grandma's Story",
        'duration_seconds': 12,
        'position_seconds': 0,
        'can_delete': false,
        'asset_path': 'audio/bedtime_story_dummy.wav',
      },
    ],
  };
}
