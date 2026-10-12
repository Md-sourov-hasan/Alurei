import 'package:dio/dio.dart';
import '../config/api_endpoints.dart';
import '../config/app_config.dart';
import '../utils/utils.dart';
import 'auth_session_storage_service.dart';

class KitchenService {
  KitchenService._();
  static final KitchenService instance = KitchenService._();

  Dio get _dio => AppConfig.dio;

  /// Fetches kitchen items for the current user from backend with optional filters.
  FutureEither<List<Map<String, dynamic>>> getKitchenItems({
    String? status,
    String ownerStatus = 'PARENT',
    int limit = 20,
  }) async {
    return runTask(() async {
      final queryParams = <String, dynamic>{
        'limit': limit,
        'ownerStatus': ownerStatus,
        if (status != null && status.isNotEmpty) 'status': status,
      };

      final response = await _dio.get<dynamic>(
        ApiEndpoints.parentKitchenItems,
        queryParameters: queryParams,
      );

      final data = response.data;
      if (data is Map) {
        final map = data.cast<String, dynamic>();
        if (map['data'] is List) {
          final list = (map['data'] as List)
              .whereType<Map<dynamic, dynamic>>()
              .map((item) => item.cast<String, dynamic>())
              .toList();
          return list;
        }
      } else if (data is List) {
        return data
            .whereType<Map<dynamic, dynamic>>()
            .map((item) => item.cast<String, dynamic>())
            .toList();
      }
      return <Map<String, dynamic>>[];
    }, requiresNetwork: true);
  }

  /// Creates a new kitchen item on the backend.
  FutureEither<Map<String, dynamic>> createKitchenItem({
    required String name,
    required String unit,
    required String category,
    required int currentStockPercent,
    String? notes,
    String? adminStatus,
    String? userId,
  }) async {
    return runTask(() async {
      final activeUserId = (userId != null && userId.isNotEmpty)
          ? userId
          : (AuthSessionStorageService.instance.userId ?? 'user-uuid-1234');

      final payload = <String, dynamic>{
        'userId': activeUserId,
        'name': name,
        'unit': unit,
        'category': category,
        'currentStockPercent': currentStockPercent,
        if (notes != null && notes.isNotEmpty) 'notes': notes,
      };

      final response = await _dio.post<dynamic>(
        ApiEndpoints.parentKitchenItems,
        data: payload,
      );

      final body = response.data;
      if (body is Map) {
        final map = body.cast<String, dynamic>();
        if (map['data'] is Map) {
          return (map['data'] as Map).cast<String, dynamic>();
        }
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  /// Updates an existing kitchen item.
  FutureEither<Map<String, dynamic>> updateKitchenItem(
    String id,
    Map<String, dynamic> updateData,
  ) async {
    return runTask(() async {
      final activeUserId = (AuthSessionStorageService.instance.userId != null &&
              AuthSessionStorageService.instance.userId!.isNotEmpty)
          ? AuthSessionStorageService.instance.userId!
          : 'user-uuid-1234';

      final payload = <String, dynamic>{
        'userId': activeUserId,
        ...updateData,
      };

      final response = await _dio.patch<dynamic>(
        ApiEndpoints.updateKitchenItem(id),
        data: payload,
      );

      final body = response.data;
      if (body is Map) {
        final map = body.cast<String, dynamic>();
        if (map['data'] is Map) {
          return (map['data'] as Map).cast<String, dynamic>();
        }
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  /// Deletes a kitchen item by ID.
  FutureEither<void> deleteKitchenItem(String id) async {
    return runTask(() async {
      await _dio.delete<void>(
        ApiEndpoints.deleteKitchenItem(id),
      );
    }, requiresNetwork: true);
  }

  /// Fetches recipe suggestions dynamically based on age group.
  FutureEither<List<Map<String, dynamic>>> getRecipeSuggestions({
    required String ageGroup,
  }) async {
    return runTask(() async {
      final response = await _dio.get<dynamic>(
        ApiEndpoints.recipeSuggestions,
        queryParameters: {
          'ageGroup': ageGroup,
        },
      );

      final data = response.data;
      if (data is Map) {
        final map = data.cast<String, dynamic>();
        if (map['data'] is List) {
          final list = (map['data'] as List)
              .whereType<Map<dynamic, dynamic>>()
              .map((item) => item.cast<String, dynamic>())
              .toList();
          return list;
        }
      } else if (data is List) {
        return data
            .whereType<Map<dynamic, dynamic>>()
            .map((item) => item.cast<String, dynamic>())
            .toList();
      }
      return <Map<String, dynamic>>[];
    }, requiresNetwork: true);
  }

  /// Fetches all recipes from backend (/library/recipes).
  FutureEither<List<Map<String, dynamic>>> getAllRecipes() async {
    return runTask(() async {
      final response = await _dio.get<dynamic>(
        ApiEndpoints.allRecipes,
      );

      final data = response.data;
      if (data is Map) {
        final map = data.cast<String, dynamic>();
        final innerData = map['data'];
        if (innerData is Map && innerData['recipes'] is List) {
          final list = (innerData['recipes'] as List)
              .whereType<Map<dynamic, dynamic>>()
              .map((item) => item.cast<String, dynamic>())
              .toList();
          return list;
        } else if (innerData is List) {
          final list = innerData
              .whereType<Map<dynamic, dynamic>>()
              .map((item) => item.cast<String, dynamic>())
              .toList();
          return list;
        }
      }
      return <Map<String, dynamic>>[];
    }, requiresNetwork: true);
  }
  /// Fetches single recipe details by ID (/library/recipes/{id}).
  FutureEither<Map<String, dynamic>> getRecipeById(String id) async {
    return runTask(() async {
      final response = await _dio.get<dynamic>(
        ApiEndpoints.recipeDetails(id),
      );

      final data = response.data;
      if (data is Map) {
        final map = data.cast<String, dynamic>();
        if (map['data'] is Map) {
          return (map['data'] as Map).cast<String, dynamic>();
        }
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  /// Adds a library item (recipe/activity) to a schedule (/parent/schedules/library).
  FutureEither<Map<String, dynamic>> addScheduleFromLibrary({
    required String childId,
    required String date,
    required String libraryItemId,
    String libraryItemType = 'recipe',
    String startTime = '09:15',
    String endTime = '10:00',
    String? description,
  }) async {
    return runTask(() async {
      final payload = <String, dynamic>{
        'childId': childId,
        'date': date,
        'libraryItemId': libraryItemId,
        'libraryItemType': libraryItemType,
        'startTime': startTime,
        'endTime': endTime,
        if (description != null && description.isNotEmpty)
          'description': description,
      };

      final response = await _dio.post<dynamic>(
        ApiEndpoints.addScheduleLibrary,
        data: payload,
      );

      final body = response.data;
      if (body is Map) {
        final map = body.cast<String, dynamic>();
        if (map['data'] is Map) {
          return (map['data'] as Map).cast<String, dynamic>();
        }
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  /// Fetches shopping list items for the current user from backend (/parent/kitchen/shopping).
  FutureEither<List<Map<String, dynamic>>> getKitchenShoppingItems({
    String ownerStatus = 'PARENT',
  }) async {
    return runTask(() async {
      final response = await _dio.get<dynamic>(
        ApiEndpoints.parentKitchenShopping,
        queryParameters: {
          'ownerStatus': ownerStatus,
        },
      );

      final data = response.data;
      if (data is Map) {
        final map = data.cast<String, dynamic>();
        if (map['data'] is List) {
          final list = (map['data'] as List)
              .whereType<Map<dynamic, dynamic>>()
              .map((item) => item.cast<String, dynamic>())
              .toList();
          return list;
        }
      } else if (data is List) {
        return data
            .whereType<Map<dynamic, dynamic>>()
            .map((item) => item.cast<String, dynamic>())
            .toList();
      }
      return <Map<String, dynamic>>[];
    }, requiresNetwork: true);
  }

  /// Adds a kitchen item to shopping list (/parent/kitchen/shopping).
  FutureEither<Map<String, dynamic>> addKitchenShoppingItem({
    required String name,
    required String unit,
    required String category,
    String quantity = '1',
    String? note,
    bool isCustomOrder = true,
    bool addToKitchen = true,
    String ownerStatus = 'PARENT',
    String? userId,
  }) async {
    return runTask(() async {
      final activeUserId = (userId != null && userId.isNotEmpty)
          ? userId
          : (AuthSessionStorageService.instance.userId ??
              '74424fe6-492c-481f-92ab-6d2b10d1dfd8');

      final payload = <String, dynamic>{
        'userId': activeUserId,
        'name': name,
        'unit': unit,
        'quantity': quantity,
        'category': category,
        if (note != null && note.isNotEmpty) 'note': note,
        'isCustomOrder': isCustomOrder,
        'addToKitchen': addToKitchen,
        'ownerStatus': ownerStatus,
      };

      final response = await _dio.post<dynamic>(
        ApiEndpoints.addKitchenShopping,
        data: payload,
      );

      final body = response.data;
      if (body is Map) {
        final map = body.cast<String, dynamic>();
        if (map['data'] is Map) {
          return (map['data'] as Map).cast<String, dynamic>();
        }
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  /// Deletes a shopping list item by ID (/parent/kitchen/shopping/{id}).
  FutureEither<void> deleteKitchenShoppingItem(String id) async {
    return runTask(() async {
      await _dio.delete<void>(
        ApiEndpoints.deleteKitchenShoppingItem(id),
      );
    }, requiresNetwork: true);
  }
}
