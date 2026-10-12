/// Relative paths for every HTTP endpoint currently used by the application.
///
/// Keep the API host in `API_BASE_URL`; [AppConfig] supplies it to Dio. Endpoint
/// constants must therefore start with `/` and must not contain a host name.
abstract final class ApiEndpoints {
  // Authentication
  static const String login = '/auth/signin';
  static const String signIn = '/auth/signin';
  static const String signUp = '/auth/signup';
  static const String forgotPassword = '/auth/forgot-password';
  static const String logout = '/auth/logout';
  static const String currentUser = '/user/me';
  static const String userProfile = '/user/me';
  static const String changePassword = '/setting/change-password';
  static const String deleteAccount = '/setting/delete-account';
  static const String languages = '/language';
  static const String preferredLanguage = '/language/preferred';

  // Kitchen & Groceries
  static const String parentKitchenItems = '/parent/kitchen/items';

  // Care
  static const String careModules = '/care/modules';
  static const String careHome = '/care/home';
  static const String careHomeTabs = '/care/home/tabs';
  static String careChildSuggestedModules(String childId) =>
      '/care/children/$childId/suggested-modules';
  static const String careAssignments = '/care/assignments';
  static const String manageCaregivers = '/caregivers/manage';
  static const String caregiversChildren = '/caregivers/children';
  static String inviteCaregiver(String childId) => '/caregivers/children/$childId/invitations';
  static String updateCaregiverPermissions(String accessId) =>
      '/caregivers/access/$accessId/permissions';
  static String caregiversNannies({int page = 1, int limit = 20, String? search}) {
    String url = '/caregivers/nannies?page=$page&limit=$limit';
    if (search != null && search.isNotEmpty) {
      url += '&search=$search';
    }
    return url;
  }
  static String careModuleSave(String moduleId) =>
      '/care/modules/$moduleId/save';
  static String careModuleDetail(String moduleId) => '/care/modules/$moduleId';
  static const String parentKitchenShopping = '/parent/kitchen/shopping';
  static const String recipeSuggestions = '/library/recipes/suggestions';
  static const String allRecipes = '/library/recipes';
  static const String allActivities = '/library/activities';
  static String recipeDetails(String id) => '/library/recipes/$id';
  static String deleteKitchenItem(String id) => '/parent/kitchen/items/$id';
  static String updateKitchenItem(String id) => '/parent/kitchen/items/$id';
  static String deleteKitchenShoppingItem(String id) =>
      '/parent/kitchen/shopping/$id';
  static const String addKitchenShopping = parentKitchenShopping;

  // Schedules
  static const String addScheduleLibrary = '/parent/schedules/library';

  // Parent children
  static const String parentChildren = '/parent/children';
  static String parentChild(String childId) => '$parentChildren/$childId';
  static String parentChildDailyTimeline(String childId) =>
      '${parentChild(childId)}/daily-timeline';
  static String parentChildRecurringActivities(String childId) =>
      '${parentChild(childId)}/recurring-activities';
  static String parentChildRecurringActivity(
          String childId, String activityId) =>
      '${parentChildRecurringActivities(childId)}/$activityId';

  // Library
  static const String library = '/library';

  // Parent schedules
  static const String parentSchedules = '/parent/schedules';
  static const String parentScheduleLibrary = '/parent/schedules/library';
  static const String parentScheduleManual = '/parent/schedules/manual';
}
