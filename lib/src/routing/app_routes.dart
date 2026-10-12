/// Centralized route name constants for named Navigator routes.
///
/// Use these constants with `Navigator.pushNamed(context, AppRoutes.onboarding)`
/// instead of inline strings to prevent typos and ease refactoring.
abstract final class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String home = '/';
  static const String main = '/main';
  static const String onboarding = '/onboarding';
  static const String roleSelection = '/role-selection';
  static const String login = '/login';
  static const String nannySignup = '/nanny-signup';
  static const String parentSignup = '/parent-signup';
  static const String forgotPassword = '/forgot-password';
  static const String verifyCode = '/verify-code';
  static const String changePassword = '/change-password';
  static const String passwordSuccess = '/password-success';
  static const String verificationSuccess = '/verification-success';
  static const String submitDocuments = '/submit-documents';
  static const String passportCapture = '/passport-capture';
  static const String nidCapture = '/nid-capture';
  static const String parentToday = '/parent/today';
  static const String nannyKitchen = '/nanny/kitchen';
  static const String parentRecipeDetails = '/parent/recipe-details';
  static const String childSetupGuide = '/parent/child-setup-guide';
  static const String aiSetupGuide = '/parent/ai-setup-guide';
  static const String buildDayFromLibrary =
      '/parent/today/build-day-from-library';
  static const String todaysChildProfile = '/parent/today/child-profile';
  static const String nannyProfile = '/parent/today/nanny-profile';
  static const String nannyActivityDetails =
      '/parent/today/nanny-activity-details';
  static const String nannyPortfolio = '/parent/today/nanny-portfolio';
  static const String bedtimeStory = '/parent/bedtime-story';
  static const String acceptInvitation = '/accept-invitation';
  static const String parentActivityDetails = '/parent/activity-details';
  static const String membershipAgreement = '/membership-agreement';
  static const String membershipTerms = '/membership-terms';
  static const String myShoppingList = '/parent/my-shopping-list';
  static const String shoppingVoucher = '/parent/shopping-voucher';
  static const String voucherSent = '/parent/voucher-sent';
  static const String trackStatus = '/parent/track-status';
  static const String checkout = '/parent/checkout';
  static const String paymentMethod = '/parent/payment-method';
  static const String orderConfirmed = '/parent/order-confirmed';
  static const String parentManageCaregivers = '/parent/manage-caregivers';
  static const String parentDocuments = '/parent/documents';
  static const String rewards = '/parent/rewards';
  static const String myOffer = '/parent/my-offer';
  static const String myOfferDetails = '/parent/my-offer-details';
  static const String redeemOfferSuccess = '/parent/redeem-offer-success';
  static const String parentAi = '/parent/ai';
  static const String parentNotification = '/parent/notification';
  static const String parentMessage = '/parent/message';
  static const String parentChatMessageThread = '/parent/message-thread';
  static const String cancelMembership = '/parent/cancel-membership';
  static const String cancelMembershipConfirm =
      '/parent/cancel-membership-confirm';
  static const String cancelMembershipSuccess =
      '/parent/cancel-membership-success';
  static const String pauseMembership = '/parent/pause-membership';
  static const String pauseMembershipSuccess =
      '/parent/pause-membership-success';
  static const String editProfile = '/profile/edit';
  static const String membership = '/membership';
  static const String myChildren = '/parent/my-children';
  static const String childProfile = '/parent/child-profile';
  static const String editChildProfile = '/parent/edit-child-profile';
  static const String language = '/language';
  static const String settings = '/parent/settings';
  static const String deleteAccount = '/parent/delete-account';
  static const String parentCareModuleDetails = '/parent/care-module-details';
  static const String nannyHome = '/nanny/home';
}
