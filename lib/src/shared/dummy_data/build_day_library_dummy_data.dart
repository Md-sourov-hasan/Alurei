enum BuildDaySearchResultType { recipe, activity }

class BuildDayLibrarySearchResultItem {
  const BuildDayLibrarySearchResultItem({
    required this.id,
    required this.type,
    required this.title,
    required this.category,
    required this.subtitle,
    required this.tags,
    this.isReady = true,
    this.imageAsset,
    this.imageUrl,
    this.description,
  });

  factory BuildDayLibrarySearchResultItem.fromActivityMap(
    Map<String, dynamic> map,
  ) {
    final location = _stringList(map['location']);
    return BuildDayLibrarySearchResultItem(
      id: _stringValue(map['id'], fallback: map['title']),
      type: BuildDaySearchResultType.activity,
      title: _stringValue(map['title'], fallback: 'Activity'),
      category: _friendlyLabel(_stringValue(map['category'])),
      subtitle: _stringValue(map['ageSuitability']),
      tags: [
        _stringValue(map['duration']),
        _friendlyLabel(_stringValue(map['energyLevel'])),
        ...location.map(_friendlyLabel),
      ].where((value) => value.isNotEmpty).toList(growable: false),
      imageUrl: _nullableString(map['imageUrl']),
      description: _nullableString(map['connectionMoment']),
    );
  }

  factory BuildDayLibrarySearchResultItem.fromRecipeMap(
    Map<String, dynamic> map,
  ) {
    final prepTime = map['prepTimeMin'];
    final cookTime = map['cookTimeMin'];
    final totalTime = (prepTime is num ? prepTime.toInt() : 0) +
        (cookTime is num ? cookTime.toInt() : 0);
    final focus = _stringList(map['nutritionalFocus']);
    return BuildDayLibrarySearchResultItem(
      id: _stringValue(map['id'], fallback: map['title']),
      type: BuildDaySearchResultType.recipe,
      title: _stringValue(map['title'], fallback: 'Recipe'),
      category: _friendlyLabel(_stringValue(map['category'])),
      subtitle: _stringValue(map['ageSuitability']),
      tags: [
        if (totalTime > 0) '$totalTime min',
        _friendlyLabel(_stringValue(map['difficulty'])),
        if (_stringValue(map['servings']).isNotEmpty)
          '${_stringValue(map['servings'])} servings',
        ...focus,
      ].where((value) => value.isNotEmpty).toList(growable: false),
      imageUrl: _nullableString(map['imageUrl']),
      description: _nullableString(map['shortDescription']),
    );
  }

  final String id;
  final BuildDaySearchResultType type;
  final String title;
  final String category;
  final String subtitle;
  final List<String> tags;
  final bool isReady;
  final String? imageAsset;
  final String? imageUrl;
  final String? description;
}

class BuildDayLibraryResult {
  const BuildDayLibraryResult({
    required this.recipes,
    required this.activities,
    this.recipesMeta = const BuildDayLibraryPageMeta.empty(),
    this.activitiesMeta = const BuildDayLibraryPageMeta.empty(),
  });

  factory BuildDayLibraryResult.fromMap(Map<String, dynamic> map) {
    final data =
        map['data'] is Map ? (map['data'] as Map).cast<String, dynamic>() : map;
    final meta = map['meta'] is Map
        ? (map['meta'] as Map).cast<String, dynamic>()
        : null;
    return BuildDayLibraryResult(
      recipes: _mapItems(
        data['recipes'],
        BuildDayLibrarySearchResultItem.fromRecipeMap,
      ),
      activities: _mapItems(
        data['activities'],
        BuildDayLibrarySearchResultItem.fromActivityMap,
      ),
      recipesMeta: BuildDayLibraryPageMeta.fromMap(meta?['recipes']),
      activitiesMeta: BuildDayLibraryPageMeta.fromMap(meta?['activities']),
    );
  }

  static const empty = BuildDayLibraryResult(recipes: [], activities: []);

  final List<BuildDayLibrarySearchResultItem> recipes;
  final List<BuildDayLibrarySearchResultItem> activities;
  final BuildDayLibraryPageMeta recipesMeta;
  final BuildDayLibraryPageMeta activitiesMeta;

  List<BuildDayLibrarySearchResultItem> get items => [
        ...recipes,
        ...activities,
      ];

  bool get isEmpty => recipes.isEmpty && activities.isEmpty;

  bool hasNextPage({required int currentPage, required int limit}) {
    if (recipesMeta.totalPages > currentPage ||
        activitiesMeta.totalPages > currentPage) {
      return true;
    }
    return items.length >= limit &&
        recipesMeta.totalPages == 0 &&
        activitiesMeta.totalPages == 0;
  }

  static List<BuildDayLibrarySearchResultItem> _mapItems(
    Object? value,
    BuildDayLibrarySearchResultItem Function(Map<String, dynamic>) mapper,
  ) {
    if (value is! List) return const [];
    return value
        .whereType<Map<dynamic, dynamic>>()
        .map((item) => mapper(item.cast<String, dynamic>()))
        .toList(growable: false);
  }
}

class BuildDayLibraryPageMeta {
  const BuildDayLibraryPageMeta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  const BuildDayLibraryPageMeta.empty()
      : total = 0,
        page = 0,
        limit = 0,
        totalPages = 0;

  factory BuildDayLibraryPageMeta.fromMap(Object? value) {
    if (value is! Map) return const BuildDayLibraryPageMeta.empty();
    final map = value.cast<String, dynamic>();
    return BuildDayLibraryPageMeta(
      total: _intValue(map['total']),
      page: _intValue(map['page']),
      limit: _intValue(map['limit']),
      totalPages: _intValue(map['totalPages']),
    );
  }

  final int total;
  final int page;
  final int limit;
  final int totalPages;
}

abstract final class BuildDayLibraryDummyData {
  static const List<BuildDayLibrarySearchResultItem> defaultItems = [
    BuildDayLibrarySearchResultItem(
      id: 'res-1',
      type: BuildDaySearchResultType.recipe,
      title: 'Blueberry Oat Porridge',
      category: 'BREAKFAST',
      subtitle: '6-12m',
      tags: ['ENERGY', 'GROWTH', 'IMMUNITY'],
      isReady: true,
      imageAsset: 'assets/images/parent_today_child_profile_avatar.png',
    ),
    BuildDayLibrarySearchResultItem(
      id: 'res-2',
      type: BuildDaySearchResultType.activity,
      title: 'Magical Bubble Trail',
      category: 'INDOOR',
      subtitle: '1 - Year Old',
      description:
          'Follow a bubble trail created at different heights, Encourages tracking, reaching, and anticipation.',
      tags: ['MOTOR SKILLS', 'COGNITIVE'],
      imageAsset: 'assets/images/child_setup_guide_bg.png',
    ),
    BuildDayLibrarySearchResultItem(
      id: 'res-3',
      type: BuildDaySearchResultType.recipe,
      title: 'Avocado Toast & Egg',
      category: 'BREAKFAST',
      subtitle: '12-24m',
      tags: ['HEALTHY FATS', 'PROTEIN'],
      isReady: true,
    ),
    BuildDayLibrarySearchResultItem(
      id: 'res-4',
      type: BuildDaySearchResultType.activity,
      title: 'Finger Painting Adventure',
      category: 'INDOOR',
      subtitle: '2 - Year Old',
      description:
          'Exploration with edible paints to boost creativity and sensory motor control.',
      tags: ['CREATIVITY', 'SENSORY'],
    ),
  ];

  static List<BuildDayLibrarySearchResultItem> search(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return defaultItems;
    final lower = trimmed.toLowerCase();
    return defaultItems.where((item) {
      return item.title.toLowerCase().contains(lower) ||
          item.category.toLowerCase().contains(lower) ||
          item.subtitle.toLowerCase().contains(lower) ||
          item.tags.any((tag) => tag.toLowerCase().contains(lower));
    }).toList();
  }

  static BuildDayLibraryResult searchGrouped(String query) {
    final items = search(query);
    return BuildDayLibraryResult(
      recipes: items
          .where((item) => item.type == BuildDaySearchResultType.recipe)
          .toList(growable: false),
      activities: items
          .where((item) => item.type == BuildDaySearchResultType.activity)
          .toList(growable: false),
    );
  }

  static BuildDayLibraryResult get defaultResult {
    return BuildDayLibraryResult(
      recipes: defaultItems
          .where((item) => item.type == BuildDaySearchResultType.recipe)
          .toList(growable: false),
      activities: defaultItems
          .where((item) => item.type == BuildDaySearchResultType.activity)
          .toList(growable: false),
    );
  }
}

String _stringValue(Object? value, {Object? fallback}) {
  final text = value?.toString().trim();
  if (text != null && text.isNotEmpty) return text;
  return fallback?.toString().trim() ?? '';
}

String? _nullableString(Object? value) {
  final text = value?.toString().trim();
  return text == null || text.isEmpty ? null : text;
}

int _intValue(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

List<String> _stringList(Object? value) {
  if (value is! List) return const [];
  return value
      .map((item) => item.toString().trim())
      .where((item) => item.isNotEmpty)
      .toList(growable: false);
}

String _friendlyLabel(String value) {
  final clean = value.trim();
  if (clean.isEmpty) return '';
  return clean.split('_').where((part) => part.isNotEmpty).map((part) {
    final lower = part.toLowerCase();
    return '${lower[0].toUpperCase()}${lower.substring(1)}';
  }).join(' ');
}
