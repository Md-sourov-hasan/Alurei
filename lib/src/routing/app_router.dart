import 'package:alurei/src/features/auth/presentation/screens/nid_capture_screen.dart';
import 'package:alurei/src/features/auth/presentation/screens/passport_capture_screen.dart';
import 'package:alurei/src/features/auth/presentation/screens/submit_documents_screen.dart';
import 'package:alurei/src/features/roles/parent/activities/presentation/bindings/parent_activity_details_binding.dart';
import 'package:alurei/src/features/roles/parent/activities/presentation/screens/parent_activity_details_screen.dart';
import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/bindings/parent_recipe_details_binding.dart';
import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/screens/parent_recipe_details_screen.dart';
import 'package:alurei/src/features/roles/parent/care/presentation/bindings/care_module_details_binding.dart';
import 'package:alurei/src/features/roles/parent/care/presentation/screens/care_module_details_screen.dart';
import 'package:alurei/src/features/roles/parent/kitchen_grocery/presentation/screens/my_shopping_list_screen.dart';
import 'package:alurei/src/features/roles/parent/kitchen_grocery/presentation/screens/shopping_voucher_screen.dart';
import 'package:alurei/src/features/roles/parent/kitchen_grocery/presentation/screens/track_status_screen.dart';
import 'package:alurei/src/features/roles/parent/kitchen_grocery/presentation/screens/voucher_sent_screen.dart';
import 'package:alurei/src/features/roles/parent/kitchen_grocery/presentation/screens/checkout_screen.dart';
import 'package:alurei/src/features/roles/parent/kitchen_grocery/presentation/screens/payment_method_screen.dart';
import 'package:alurei/src/features/roles/parent/kitchen_grocery/presentation/screens/order_confirmed_screen.dart';
import 'package:alurei/src/features/roles/parent/rewards/presentation/screens/parent_rewards_screen.dart';
import 'package:alurei/src/features/roles/parent/my_offer/presentation/screens/my_offer_screen.dart';
import 'package:alurei/src/features/roles/parent/my_offer/presentation/screens/my_offer_details_screen.dart';
import 'package:alurei/src/features/roles/parent/my_offer/presentation/screens/redeem_offer_success_screen.dart';
import 'package:alurei/src/features/roles/parent/Ai/presentation/bindings/parent_ai_binding.dart';
import 'package:alurei/src/features/roles/parent/Ai/presentation/screens/parent_ai_screen.dart';
import 'package:alurei/src/features/roles/parent/notifiction/presentation/bindings/parent_notification_binding.dart';
import 'package:alurei/src/features/roles/parent/notifiction/presentation/screens/parent_notification_screen.dart';
import 'package:alurei/src/features/roles/parent/message/presentation/bindings/parent_message_binding.dart';
import 'package:alurei/src/features/roles/parent/message/presentation/bindings/parent_message_thread_binding.dart';
import 'package:alurei/src/features/roles/parent/message/presentation/screens/parent_message_screen.dart';
import 'package:alurei/src/features/roles/parent/message/presentation/screens/parent_message_thread_screen.dart';
import 'package:alurei/src/features/home/presentation/screens/cancel_membership_screen.dart';
import 'package:alurei/src/features/home/presentation/screens/cancel_membership_confirm_screen.dart';
import 'package:alurei/src/features/home/presentation/screens/cancel_membership_success_screen.dart';
import 'package:alurei/src/features/home/presentation/bindings/cancel_membership_binding.dart';
import 'package:alurei/src/features/edit_profile/presentation/bindings/edit_profile_binding.dart';
import 'package:alurei/src/features/edit_profile/presentation/screens/edit_profile_screen.dart';
import 'package:alurei/src/features/home/presentation/screens/membership_screen.dart';
import 'package:alurei/src/features/home/presentation/screens/pause_membership_screen.dart';
import 'package:alurei/src/features/home/presentation/bindings/pause_membership_binding.dart';
import 'package:alurei/src/features/home/presentation/screens/pause_membership_success_screen.dart';
import 'package:alurei/src/features/home/presentation/screens/my_children_screen.dart';
import 'package:alurei/src/features/home/presentation/bindings/my_children_binding.dart';
import 'package:alurei/src/features/home/presentation/screens/child_profile_screen.dart';
import 'package:alurei/src/features/home/presentation/screens/documents_screen.dart';
import 'package:alurei/src/features/home/presentation/bindings/documents_binding.dart';
import 'package:alurei/src/features/home/presentation/bindings/child_profile_binding.dart';
import 'package:alurei/src/features/home/presentation/screens/edit_child_profile_screen.dart';
import 'package:alurei/src/features/home/presentation/bindings/edit_child_profile_binding.dart';
import 'package:alurei/src/features/home/presentation/screens/language_screen.dart';
import 'package:alurei/src/features/home/presentation/bindings/language_binding.dart';
import 'package:alurei/src/features/settings/presentation/bindings/delete_account_binding.dart';
import 'package:alurei/src/features/settings/presentation/bindings/change_password_binding.dart';
import 'package:alurei/src/features/settings/presentation/bindings/settings_binding.dart';
import 'package:alurei/src/features/settings/presentation/screens/delete_account_screen.dart';
import 'package:alurei/src/features/settings/presentation/screens/settings_screen.dart';
import 'package:alurei/src/imports/imports.dart';
import 'package:alurei/src/features/roles/nanny/kitchen/presentation/bindings/nanny_kitchen_binding.dart';
import 'package:alurei/src/features/roles/nanny/kitchen/presentation/screens/nanny_kitchen_screen.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/bindings/parent_today_binding.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/screens/parent_today_screen.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/screens/child_setup_guide.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/screens/ai_setup_guide_screen.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/bindings/ai_setup_guide_binding.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/screens/build_day_from_library_screen.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/bindings/build_day_from_library_binding.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/bindings/bedtime_story_binding.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/bindings/nanny_activity_details_binding.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/bindings/nanny_portfolio_binding.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/bindings/nanny_profile_binding.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/bindings/todays_child_profile_binding.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/screens/bedtime_story_screen.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/screens/nanny_activity_details_screen.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/screens/nanny_portfolio_screen.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/screens/nanny_profile_screen.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/screens/todays_child_profile_screen.dart';
import 'package:alurei/src/features/auth/presentation/screens/accept_invitation_screen.dart';
import 'package:alurei/src/features/main_shell/presentation/bindings/role_main_binding.dart';
import 'package:alurei/src/features/main_shell/presentation/screens/role_main_shell.dart';
import 'package:alurei/src/features/auth/presentation/screens/verification_success_screen.dart';

import 'package:alurei/src/features/roles/parent/manage_caregiver/presentation/bindings/manage_caregiver_binding.dart';
import 'package:alurei/src/features/roles/parent/manage_caregiver/presentation/screens/manage_caregiver_screen.dart';
import 'package:alurei/src/features/home/presentation/bindings/home_binding.dart';

class AppRouter {
  static List<GetPage<dynamic>> get getPages => [
        GetPage(
          name: AppRoutes.splash,
          page: () => const SplashScreen(),
          // ignore: inference_failure_on_instance_creation
          binding: BindingsBuilder(() {
            Get.lazyPut<SplashController>(() => SplashController());
          }),
        ),
        GetPage(
          name: AppRoutes.roleSelection,
          page: () => const ChoosingScreen(),
        ),
        GetPage(
          name: AppRoutes.login,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: AppRoutes.nannySignup,
          page: () => const NannySignupScreen(),
        ),
        GetPage(
          name: AppRoutes.parentSignup,
          page: () => const ParentSignupScreen(),
        ),
        GetPage(
          name: AppRoutes.forgotPassword,
          page: () => const ForgotPasswordScreen(),
        ),
        GetPage(
          name: AppRoutes.verifyCode,
          page: () => const VerifyCodeScreen(),
        ),
        GetPage(
          name: AppRoutes.changePassword,
          page: () => const ChangePasswordScreen(),
          binding: ChangePasswordBinding(),
        ),
        GetPage(
          name: AppRoutes.passwordSuccess,
          page: () => const PasswordSuccessScreen(),
        ),
        GetPage(
          name: AppRoutes.verificationSuccess,
          page: () => const VerificationSuccessScreen(),
        ),
        GetPage(
          name: AppRoutes.submitDocuments,
          page: () => const SubmitDocumentsScreen(),
        ),
        GetPage(
          name: AppRoutes.passportCapture,
          page: () => const PassportCaptureScreen(),
        ),
        GetPage(
          name: AppRoutes.nidCapture,
          page: () => const NidCaptureScreen(),
        ),
        GetPage(
          name: AppRoutes.home,
          page: () => const HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: AppRoutes.main,
          page: () => const RoleMainShell(),
          binding: RoleMainBinding(),
        ),
        GetPage(
          name: AppRoutes.parentToday,
          page: () => const ParentTodayScreen(),
          binding: ParentTodayBinding(),
        ),
        GetPage(
          name: AppRoutes.nannyKitchen,
          page: () => const NannyKitchenScreen(),
          binding: NannyKitchenBinding(),
        ),
        GetPage(
          name: AppRoutes.parentRecipeDetails,
          page: () => const ParentRecipeDetailsScreen(),
          binding: ParentRecipeDetailsBinding(),
        ),
        GetPage(
          name: AppRoutes.acceptInvitation,
          page: () => const AcceptInvitationScreen(),
        ),
        GetPage(
          name: AppRoutes.membershipAgreement,
          page: () => const MembershipAgreementScreen(),
        ),
        GetPage(
          name: AppRoutes.membershipTerms,
          page: () => const MembershipTermsScreen(),
        ),
        GetPage(
          name: AppRoutes.childSetupGuide,
          page: () => const ChildSetupGuide(),
        ),
        GetPage(
          name: AppRoutes.aiSetupGuide,
          page: () => const AiSetupGuideScreen(),
          binding: AiSetupGuideBinding(),
        ),
        GetPage(
          name: AppRoutes.buildDayFromLibrary,
          page: () => const BuildDayFromLibraryScreen(),
          binding: BuildDayFromLibraryBinding(),
        ),
        GetPage(
          name: AppRoutes.todaysChildProfile,
          page: () => const TodaysChildProfileScreen(),
          binding: TodaysChildProfileBinding(),
        ),
        GetPage(
          name: AppRoutes.nannyProfile,
          page: () => const NannyProfileScreen(),
          binding: NannyProfileBinding(),
        ),
        GetPage(
          name: AppRoutes.nannyActivityDetails,
          page: () => const NannyActivityDetailsScreen(),
          binding: NannyActivityDetailsBinding(),
        ),
        GetPage(
          name: AppRoutes.nannyPortfolio,
          page: () => const NannyPortfolioScreen(),
          binding: NannyPortfolioBinding(),
        ),
        GetPage(
          name: AppRoutes.myShoppingList,
          page: () => const MyShoppingListScreen(),
        ),
        GetPage(
          name: AppRoutes.shoppingVoucher,
          page: () => const ShoppingVoucherScreen(),
        ),
        GetPage(
          name: AppRoutes.voucherSent,
          page: () => const VoucherSentScreen(),
        ),
        GetPage(
          name: AppRoutes.trackStatus,
          page: () => const TrackStatusScreen(),
        ),
        GetPage(
          name: AppRoutes.checkout,
          page: () => const CheckoutScreen(),
        ),
        GetPage(
          name: AppRoutes.paymentMethod,
          page: () => const PaymentMethodScreen(),
        ),
        GetPage(
          name: AppRoutes.orderConfirmed,
          page: () => const OrderConfirmedScreen(),
        ),
        GetPage(
          name: AppRoutes.parentCareModuleDetails,
          page: () => const CareModuleDetailsScreen(),
          binding: CareModuleDetailsBinding(),
        ),
        GetPage(
          name: AppRoutes.bedtimeStory,
          page: () => const BedtimeStoryScreen(),
          binding: BedtimeStoryBinding(),
        ),
        GetPage(
          name: AppRoutes.parentActivityDetails,
          page: () => const ParentActivityDetailsScreen(),
          binding: ParentActivityDetailsBinding(),
        ),
        GetPage(
          name: AppRoutes.parentManageCaregivers,
          page: () => const ManageCaregiverScreen(),
          binding: ManageCaregiverBinding(),
        ),
        GetPage(
          name: AppRoutes.parentDocuments,
          page: () => const DocumentsScreen(),
          binding: DocumentsBinding(),
        ),
        GetPage(
          name: AppRoutes.rewards,
          page: () => const ParentRewardsScreen(),
        ),
        GetPage(
          name: AppRoutes.myOffer,
          page: () => const MyOfferScreen(),
        ),
        GetPage(
          name: AppRoutes.myOfferDetails,
          page: () => const MyOfferDetailsScreen(),
        ),
        GetPage(
          name: AppRoutes.redeemOfferSuccess,
          page: () => const RedeemOfferSuccessScreen(),
        ),
        GetPage(
          name: AppRoutes.parentAi,
          page: () => ParentAiScreen(),
          binding: ParentAiBinding(),
        ),
        GetPage(
          name: AppRoutes.parentNotification,
          page: () => const ParentNotificationScreen(),
          binding: ParentNotificationBinding(),
        ),
        GetPage(
          name: AppRoutes.parentMessage,
          page: () => const ParentMessageScreen(),
          binding: ParentMessageBinding(),
        ),
        GetPage(
          name: AppRoutes.parentChatMessageThread,
          page: () => const ParentMessageThreadScreen(),
          binding: ParentMessageThreadBinding(),
        ),
        GetPage(
          name: AppRoutes.cancelMembership,
          page: () => const CancelMembershipScreen(),
          binding: CancelMembershipBinding(),
        ),
        GetPage(
          name: AppRoutes.cancelMembershipConfirm,
          page: () => const CancelMembershipConfirmScreen(),
          binding: CancelMembershipBinding(),
        ),
        GetPage(
          name: AppRoutes.cancelMembershipSuccess,
          page: () => const CancelMembershipSuccessScreen(),
          binding: CancelMembershipBinding(),
        ),
        GetPage(
          name: AppRoutes.pauseMembership,
          page: () => const PauseMembershipScreen(),
          binding: PauseMembershipBinding(),
        ),
        GetPage(
          name: AppRoutes.pauseMembershipSuccess,
          page: () => const PauseMembershipSuccessScreen(),
          binding: PauseMembershipBinding(),
        ),
        GetPage(
          name: AppRoutes.editProfile,
          page: () => const EditProfileScreen(),
          binding: EditProfileBinding(),
        ),
        GetPage(
          name: AppRoutes.membership,
          page: () => const MembershipScreen(),
        ),
        GetPage(
          name: AppRoutes.myChildren,
          page: () => const MyChildrenScreen(),
          binding: MyChildrenBinding(),
        ),
        GetPage(
          name: AppRoutes.childProfile,
          page: () => const ChildProfileScreen(),
          binding: ChildProfileBinding(),
        ),
        GetPage(
          name: AppRoutes.editChildProfile,
          page: () => const EditChildProfileScreen(),
          binding: EditChildProfileBinding(),
        ),
        GetPage(
          name: AppRoutes.language,
          page: () => const LanguageScreen(),
          binding: LanguageBinding(),
        ),
        GetPage(
          name: AppRoutes.settings,
          page: () => const SettingsScreen(),
          binding: SettingsBinding(),
        ),
        GetPage(
          name: AppRoutes.deleteAccount,
          page: () => const DeleteAccountScreen(),
          binding: DeleteAccountBinding(),
        ),
      ];
}
