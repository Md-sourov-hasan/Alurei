/// Centralized fixture payload consumed by the Parent Today dummy data source.
abstract final class ParentTodayDummyData {
  static Map<String, Object?> addedChild(int sequence) => {
        'id': 'new-child-$sequence',
        'name': 'Child $sequence',
        'has_allergy': false,
        'avatar_asset': 'assets/images/parent_today_child_profile_avatar.png',
      };

  static Map<String, Object?> childProfile(String childId) {
    return _childProfiles[childId] ?? _childProfiles['child-eve']!;
  }

  static Map<String, Object?> nannyProfile(String nannyId) {
    return _nannyProfiles[nannyId] ?? _nannyProfiles['nanny-deepa']!;
  }

  static Map<String, Object?> nannyActivityDetails(String taskId) {
    return _nannyActivityDetails[taskId] ?? _nannyActivityDetails['default']!;
  }

  static Map<String, Object?> nannyPortfolio(String nannyId) {
    return _nannyPortfolios[nannyId] ?? _nannyPortfolios['nanny-deepa']!;
  }

  static const List<Map<String, Object?>> _eveRoutine = [
    {'id': 'wake', 'kind': 'wake', 'start': '07:00', 'state': 'past'},
    {
      'id': 'breakfast',
      'kind': 'breakfast',
      'start': '08:00',
      'end': '08:30',
      'state': 'past',
    },
    {
      'id': 'school',
      'kind': 'school',
      'start': '09:00',
      'end': '13:00',
      'state': 'past',
    },
    {
      'id': 'nap',
      'kind': 'nap',
      'start': '13:30',
      'end': '14:30',
      'state': 'current',
    },
    {
      'id': 'outdoor',
      'kind': 'outdoor',
      'start': '15:00',
      'end': '16:00',
      'state': 'upcoming',
    },
    {
      'id': 'pasta',
      'kind': 'pasta',
      'start': '17:30',
      'end': '18:00',
      'state': 'upcoming',
    },
    {
      'id': 'nap',
      'kind': 'nap',
      'start': '18:00',
      'end': '18:30',
      'state': 'current',
    },
    {
      'id': 'study',
      'kind': 'study',
      'start': '18:30',
      'end': '19:30',
      'state': 'upcoming',
    },
    {
      'id': 'football',
      'kind': 'external',
      'start': '16:00',
      'state': 'upcoming',
      'title': 'Little Kickers Football',
      'description': 'Safa Park - coach-led',
      'item_type_label': 'External',
    },
    {
      'id': 'story',
      'kind': 'story',
      'start': '20:00',
      'end': '20:30',
      'state': 'upcoming',
    },
    {
      'id': 'bedtime',
      'kind': 'bedtime',
      'start': '21:00',
      'state': 'upcoming',
    },
  ];

  static const List<Map<String, Object?>> _roseRoutine = [
    {'id': 'rose-wake', 'kind': 'wake', 'start': '06:45', 'state': 'past'},
    {
      'id': 'rose-breakfast',
      'kind': 'breakfast',
      'start': '07:20',
      'end': '07:45',
      'state': 'past',
    },
    {
      'id': 'rose-nap',
      'kind': 'nap',
      'start': '12:00',
      'end': '13:00',
      'state': 'current',
    },
    {
      'id': 'rose-story',
      'kind': 'story',
      'start': '19:30',
      'end': '19:45',
      'state': 'upcoming',
    },
    {
      'id': 'rose-bedtime',
      'kind': 'bedtime',
      'start': '20:00',
      'state': 'upcoming',
    },
  ];

  static const Map<String, Object?> dashboard = {
    'parent_name': 'Monica Steve',
    'avatar_asset': 'assets/images/parent_today_parent_avatar.png',
    'notification_count': 1,
    'message_count': 1,
    'children': [
      {
        'id': '388c0fd2-8869-4ef3-96ec-bc6f293805bc',
        'name': 'Ava',
        'has_allergy': false,
        'avatar_asset':
            'https://images.unsplash.com/photo-1516627145497-ae6968895b74',
        'routine': _eveRoutine,
      },
      {
        'id': '23b101aa-4efa-45df-bcdc-bd39f6f10b18',
        'name': 'Liam',
        'has_allergy': false,
        'avatar_asset':
            'https://images.unsplash.com/photo-1503919545889-aef636e10ad4',
        'routine': _roseRoutine,
      },
      {
        'id': '4637c032-3169-4f1a-b09c-36e2240845e4',
        'name': 'Noah',
        'has_allergy': false,
        'avatar_asset':
            'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4',
        'routine': _eveRoutine,
      },
      {
        'id': '84663d79-9904-40c2-a1c1-cc336e9ab6b7',
        'name': 'Maya',
        'has_allergy': true,
        'avatar_asset':
            'https://images.unsplash.com/photo-1542810634-71277d95dcbb',
        'routine': _roseRoutine,
      },
      {
        'id': 'f807ff9a-593a-46db-b97a-79e5f8813202',
        'name': 'Eve',
        'has_allergy': false,
        'avatar_asset':
            'https://images.unsplash.com/photo-1503454537195-1dcabb73ffb9',
        'routine': _eveRoutine,
      },
    ],
    'routine': _eveRoutine,
  };

  static const Map<String, Map<String, Object?>> _childProfiles = {
    'child-eve': {
      'id': 'child-eve',
      'name': 'Eve',
      'avatar_asset': 'assets/images/parent_today_child_profile_avatar.png',
      'gender': 'Girl',
      'birth_date': '2021-04-12',
      'weight': '20 kg',
      'school_days': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
      'school_start_time': '08:30',
      'school_end_time': '14:30',
      'recurring_activities': [
        {
          'id': 'eve-story',
          'name': 'Story time',
          'days': ['Mon'],
          'start_time': '08:30',
          'end_time': '09:30',
        },
      ],
      'wake_time': '07:00',
      'nap_windows': [
        {
          'id': 'eve-nap-1',
          'title': 'Nap Window',
          'subtitle': 'Afternoon rest period',
          'start_time': '13:00',
          'end_time': '15:00',
        },
      ],
      'bedtime': '19:00',
      'safety_option': 'None',
      'safety_details': '',
      'favorite_foods':
          'Little triangle crackers or spoonfuls of pasta and boiled berries.',
      'favorite_activities':
          'Big building blocks, drawing with crayons, outdoor swings, singing songs.',
      'current_challenges':
          'Settling down for nap can require a little bedtime story structure.',
      'notes':
          'Eve has homework after school, enjoys sensory play, and should avoid sugary snacks today.',
      'assigned_nannies': [
        {
          'id': 'nanny-deepa',
          'name': 'Deepa Sanjana',
          'status': 'Active',
          'since': "With Monica's family since Jan 2024",
          'avatar_asset': 'assets/images/nanny_profile_deepa_sanjana.png',
          'email': 'sarah.j@email.com',
          'phone': '+1 (555) 012-3456',
        },
      ],
    },
    'child-rose': {
      'id': 'child-rose',
      'name': 'Rose',
      'avatar_asset': 'assets/images/Monica_child1.png',
      'gender': 'Girl',
      'birth_date': '2022-09-03',
      'weight': '15 kg',
      'school_days': ['Mon', 'Wed', 'Thu'],
      'school_start_time': '09:00',
      'school_end_time': '12:30',
      'recurring_activities': [
        {
          'id': 'rose-music',
          'name': 'Music Class',
          'days': ['Tue'],
          'start_time': '16:00',
          'end_time': '16:45',
        },
      ],
      'wake_time': '06:45',
      'nap_windows': [
        {
          'id': 'rose-nap-1',
          'title': 'Nap Window',
          'subtitle': 'Afternoon rest period',
          'start_time': '12:00',
          'end_time': '13:00',
        },
      ],
      'bedtime': '20:00',
      'safety_option': 'Food allergies',
      'safety_details': 'Avoid peanuts and peanut butter.',
      'favorite_foods': 'Banana yogurt, soft rice, and sliced berries.',
      'favorite_activities': 'Picture books, music, and sorting games.',
      'current_challenges': 'Needs gentle transitions after play time.',
      'notes': 'Rose likes a quieter wind-down before bedtime.',
      'assigned_nannies': [],
    },
  };

  static const List<Map<String, Object?>> _nannyTasks = [
    {
      'id': 'task-outdoor-1',
      'title': 'Outdoor Play Time',
      'subtitle': 'Today · 9:32 AM',
      'kind': 'activity',
      'proof_count': 2,
      'status': 'complete',
    },
    {
      'id': 'task-meal-1',
      'title': 'Outdoor Play Time',
      'subtitle': 'Today · 9:32 AM',
      'kind': 'meal',
      'proof_count': 1,
      'status': 'warning',
    },
    {
      'id': 'task-care-1',
      'title': 'Outdoor Play Time',
      'subtitle': 'Today · 9:32 AM',
      'kind': 'care',
      'proof_count': 3,
      'status': 'complete',
    },
  ];

  static const List<Map<String, Object?>> _nannyWeekTasks = [
    {
      'id': 'week-education-1',
      'title': 'Home education',
      'subtitle': 'Today · 9:32 AM',
      'kind': 'education',
      'proof_count': 2,
      'status': 'complete',
    },
    {
      'id': 'week-care-1',
      'title': 'Outdoor Play Time',
      'subtitle': 'Today · 9:32 AM',
      'kind': 'care',
      'proof_count': 1,
      'status': 'missing',
    },
    {
      'id': 'week-activity-1',
      'title': 'Outdoor Play Time',
      'subtitle': 'Today · 9:32 AM',
      'kind': 'activity',
      'proof_count': 1,
      'status': 'warning',
    },
    {
      'id': 'week-meal-1',
      'title': 'Outdoor Play Time',
      'subtitle': 'Today · 9:32 AM',
      'kind': 'meal',
      'proof_count': 1,
      'status': 'warning',
      'proof_missing': true,
    },
    {
      'id': 'week-education-2',
      'title': 'Home education',
      'subtitle': 'Today · 9:32 AM',
      'kind': 'education',
      'proof_count': 2,
      'status': 'complete',
    },
    {
      'id': 'week-meal-2',
      'title': 'Outdoor Play Time',
      'subtitle': 'Today · 9:32 AM',
      'kind': 'meal',
      'proof_count': 1,
      'status': 'warning',
    },
    {
      'id': 'week-care-2',
      'title': 'Outdoor Play Time',
      'subtitle': 'Today · 9:32 AM',
      'kind': 'care',
      'proof_count': 1,
      'status': 'missing',
    },
    {
      'id': 'week-activity-2',
      'title': 'Outdoor Play Time',
      'subtitle': 'Today · 9:32 AM',
      'kind': 'activity',
      'proof_count': 3,
      'status': 'complete',
      'proof_missing': true,
    },
  ];

  static const Map<String, Map<String, Object?>> _nannyProfiles = {
    'nanny-deepa': {
      'id': 'nanny-deepa',
      'name': 'Deepa Sanjana',
      'status': 'Active',
      'since': "With Monica's family since Jan 2024",
      'avatar_asset': 'assets/images/nanny_profile_deepa_sanjana.png',
      'email': 'sarah.j@email.com',
      'phone': '+1 (555) 012-3456',
      'caring_for': ['Eve'],
      'care_score': '90',
      'overview_metrics': [
        {
          'id': 'activities',
          'label': 'Activities done',
          'value': '84',
          'icon': 'activity',
        },
        {'id': 'meals', 'label': 'Meals served', 'value': '312', 'icon': 'pasta'},
        {
          'id': 'care',
          'label': 'Care moments done',
          'value': '14',
          'icon': 'nap',
        },
        {'id': 'days', 'label': 'Days on duty', 'value': '61', 'icon': 'wake'},
      ],
      'recent_tasks': _nannyTasks,
      'week_summary': [
        {'id': 'total', 'label': 'Total tasks', 'value': '36', 'icon': 'task'},
        {
          'id': 'proofs',
          'label': 'With proofs',
          'value': '08',
          'icon': 'task',
        },
        {
          'id': 'missing',
          'label': 'Proof Missing',
          'value': '08',
          'icon': 'task',
        },
      ],
      'week_tasks': _nannyWeekTasks,
      'month_summary': [
        {'id': 'total', 'label': 'Total tasks', 'value': '36', 'icon': 'task'},
        {
          'id': 'proofs',
          'label': 'With proofs',
          'value': '08',
          'icon': 'task',
        },
        {
          'id': 'missing',
          'label': 'Proof Missing',
          'value': '08',
          'icon': 'task',
        },
      ],
      'month_tasks': _nannyWeekTasks,
      'highlights': [
        'assets/images/nanny_profile_highlight_running_garden.png',
        'assets/images/nanny_profile_highlight_bubble_chase.png',
        'assets/images/nanny_profile_highlight_fruit_smoothie.png',
        'assets/images/nanny_profile_highlight_rainbow_painting.png',
        'assets/images/nanny_profile_highlight_canvas_focus.png',
        'assets/images/nanny_profile_highlight_finished_artwork.png',
        'assets/images/nanny_profile_highlight_lunchtime.png',
        'assets/images/nanny_profile_highlight_blocks.png',
        'assets/images/nanny_profile_highlight_story_time.png',
      ],
    },
  };

  static const Map<String, Map<String, Object?>> _nannyActivityDetails = {
    'default': {
      'id': 'activity-breakfast',
      'title': 'Breakfast',
      'category': 'Meal',
      'subtitle': 'Banana Oat Pancakes',
      'time_range': '10:30 AM - 10:45 AM',
      'completed_at': 'Done at 10:48 AM',
      'proof_images': [
        'assets/images/nanny_profile_highlight_fruit_smoothie.png',
      ],
      'proof_times': ['10:40 AM'],
      'focus_tags': [
        'Growth & Energy',
        'Finger Food Friendly',
        'Balanced',
      ],
      'feedback_date': '21th July 2026',
      'enjoyment': 'Loved it',
      'mood': 'Happy',
      'completion': 'Full plate',
      'nanny_note':
          'Eve was cheerful through breakfast and finished the pancakes with little support.',
    },
    'task-meal-1': {
      'id': 'activity-breakfast',
      'title': 'Breakfast',
      'category': 'Meal',
      'subtitle': 'Banana Oat Pancakes',
      'time_range': '10:30 AM - 10:45 AM',
      'completed_at': 'Done at 10:48 AM',
      'proof_images': [
        'assets/images/nanny_profile_highlight_fruit_smoothie.png',
      ],
      'proof_times': ['10:40 AM'],
      'focus_tags': [
        'Growth & Energy',
        'Finger Food Friendly',
        'Balanced',
      ],
      'feedback_date': '21th July 2026',
      'enjoyment': 'Loved it',
      'mood': 'Happy',
      'completion': 'Full plate',
      'nanny_note':
          'Eve was cheerful through breakfast and finished the pancakes with little support.',
    },
  };

  static const Map<String, Map<String, Object?>> _nannyPortfolios = {
    'nanny-deepa': {
      'id': 'nanny-deepa',
      'name': 'Deepa Sanjana',
      'avatar_asset': 'assets/images/nanny_profile_deepa_sanjana.png',
      'since': 'With Alurei since Jan 2024',
      'experience': '8 Years Experience',
      'languages': 'English & Spanish',
      'perks': [
        {'label': 'Total Earned', 'value': '250', 'accent': 'pasta'},
        {'label': 'Redeemed', 'value': '230', 'accent': 'task'},
      ],
      'skills': [
        'First Aid',
        'Behavioral Support',
        'Infant Care',
        'Nutrition Planning',
        'Early Childhood Dev',
      ],
      'more_skills_label': '+4 More',
      'experiences': [
        {
          'family': 'The Miller Family',
          'period': 'Jan 2021 - Present',
          'children': '2 infants',
          'duration': '3 years duration',
        },
        {
          'family': 'The Chen Household',
          'period': 'Jan 2021 - Present',
          'children': '2 infants',
          'duration': '3 years duration',
        },
      ],
      'age_groups': ['Babies (0-12m)', 'Toddlers (12-24m)'],
      'insights': [
        {
          'title': '65 meals served',
          'subtitle': 'Supported nutrition & development',
          'icon': 'meal',
          'highlighted': true,
          'rows': [
            {'label': 'Growth & Energy', 'value': '18', 'accent': 'task'},
            {'label': 'Brain Development', 'value': '18', 'accent': 'task'},
            {'label': 'Gut Immunity', 'value': '15', 'accent': 'task'},
            {'label': 'Exploration & Learning', 'value': '10', 'accent': 'task'},
            {
              'label': 'Routine & Mealtime Calm',
              'value': '10',
              'accent': 'task',
            },
          ],
        },
        {
          'title': '87 care layers completed',
          'subtitle': 'Supporting everyday wellbeing',
          'icon': 'care',
          'rows': [
            {'label': 'Nutrition & Mealtimes', 'value': '14', 'accent': 'task'},
            {'label': 'Behaviour & Regulation', 'value': '16', 'accent': 'task'},
            {'label': 'Language Development', 'value': '16', 'accent': 'task'},
            {'label': 'Safety & Awareness', 'value': '10', 'accent': 'task'},
          ],
        },
        {
          'title': '78 activities completed',
          'subtitle': 'Across developmental domains',
          'icon': 'activity',
          'highlighted': true,
          'rows': [
            {'label': 'Physical Development', 'value': '14', 'accent': 'task'},
            {'label': 'Cognitive Development', 'value': '16', 'accent': 'task'},
            {'label': 'Language Development', 'value': '12', 'accent': 'task'},
            {'label': 'Social Development', 'value': '10', 'accent': 'task'},
            {'label': 'Sensory Development', 'value': '18', 'accent': 'task'},
          ],
        },
      ],
    },
  };

  static const List<Map<String, String>> availableNannies = [
    {
      'id': 'nanny-1',
      'name': 'Deepa Sanjana',
      'email': 'emily.c@alurei.app',
      'avatar': 'assets/images/parent_today_child_profile_avatar.png',
    },
    {
      'id': 'nanny-2',
      'name': 'Sarah Connor',
      'email': 'sarah.c@alurei.app',
      'avatar': 'assets/images/Monica_child1.png',
    },
    {
      'id': 'nanny-3',
      'name': 'Maria Garcia',
      'email': 'maria.g@alurei.app',
      'avatar': 'assets/images/monioka_child2.png',
    },
    {
      'id': 'nanny-4',
      'name': 'Aisha Rahman',
      'email': 'aisha.r@alurei.app',
      'avatar': 'assets/images/monika_child3.png',
    },
  ];

  static const List<Map<String, String>> manageCaregivers = [
    {
      'id': 'caregiver-1',
      'name': 'Monica Steve',
      'role_category': 'account_owner',
      'status': 'active',
      'caring_for': 'Eve, Maya',
      'avatar': 'assets/images/parent_today_parent_avatar.png',
    },
    {
      'id': 'caregiver-2',
      'name': 'Monica Steve',
      'role_category': 'nanny',
      'status': 'pending',
      'caring_for': 'Eve',
      'avatar': 'assets/images/parent_today_parent_avatar.png',
    },
    {
      'id': 'caregiver-3',
      'name': 'Monica Steve',
      'role_category': 'parent',
      'status': 'active',
      'caring_for': 'Eve',
      'avatar': 'assets/images/parent_today_parent_avatar.png',
    },
    {
      'id': 'caregiver-4',
      'name': 'Monica Steve',
      'role_category': 'family_member',
      'family_relation': 'Aunt',
      'status': 'active',
      'caring_for': 'Eve',
      'avatar': 'assets/images/parent_today_parent_avatar.png',
    },
  ];
}
