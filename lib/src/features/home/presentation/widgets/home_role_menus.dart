import 'package:alurei/src/features/auth/domain/entities/user.dart';
import 'package:alurei/src/features/home/presentation/controllers/home_controller.dart';
import 'package:alurei/src/features/home/presentation/widgets/home_menu_item_tile.dart';
import 'package:alurei/src/features/home/presentation/widgets/home_menu_section.dart';
import 'package:alurei/src/imports/imports.dart';

class HomeRoleMenus extends StatelessWidget {
  const HomeRoleMenus({
    super.key,
    required this.role,
    required this.controller,
  });

  final AppUserRole role;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final isParent = role == AppUserRole.parent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HomeMenuSection(
          title: isParent
              ? LangKey.parentHome.general
              : LangKey.nannyHome.general,
          children: isParent
              ? _buildParentGeneralItems()
              : _buildNannyGeneralItems(),
        ),
        SizedBox(height: AppSpacing.lg.h),
        HomeMenuSection(
          children: [
            HomeMenuItemTile(
              icon: IconsaxPlusLinear.setting_2,
              title: isParent
                  ? LangKey.parentHome.settings
                  : LangKey.nannyHome.settings,
              showBadgeBackground: false,
              onTap: controller.onSettingsTapped,
            ),
            HomeMenuItemTile(
              icon: IconsaxPlusLinear.global,
              title: isParent
                  ? LangKey.parentHome.language
                  : LangKey.nannyHome.language,
              showBadgeBackground: false,
              showDivider: false,
              onTap: controller.onLanguageTapped,
            ),
          ],
        ),
        SizedBox(height: AppSpacing.lg.h),
        HomeMenuSection(
          children: [
            HomeMenuItemTile(
              icon: IconsaxPlusLinear.message_question,
              title: isParent
                  ? LangKey.parentHome.helpCenter
                  : LangKey.nannyHome.helpCenter,
              showBadgeBackground: false,
              showDivider: false,
              onTap: controller.onHelpCenterTapped,
            ),
          ],
        ),
        SizedBox(height: AppSpacing.lg.h),
        HomeMenuSection(
          children: [
            HomeMenuItemTile(
              icon: IconsaxPlusLinear.logout_1,
              title: isParent
                  ? LangKey.parentHome.signOut
                  : LangKey.nannyHome.signOut,
              showBadgeBackground: false,
              showDivider: false,
              titleColor: context.colors.error,
              iconColor: context.colors.error,
              onTap: () => controller.onSignOutTapped(context),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildParentGeneralItems() {
    return [
      HomeMenuItemTile(
        icon: IconsaxPlusLinear.user_octagon,
        title: LangKey.parentHome.myChildren,
        onTap: controller.onMyChildrenTapped,
      ),
      HomeMenuItemTile(
        icon: IconsaxPlusLinear.gift,
        title: LangKey.parentHome.rewards,
        onTap: controller.onRewardsTapped,
      ),
      HomeMenuItemTile(
        icon: IconsaxPlusLinear.shop,
        title: LangKey.parentHome.alureiRewards,
        onTap: controller.onAlureiRewardsTapped,
      ),
      HomeMenuItemTile(
        icon: IconsaxPlusLinear.document,
        title: LangKey.parentHome.documents,
        onTap: controller.onDocumentsTapped,
      ),
      HomeMenuItemTile(
        icon: IconsaxPlusLinear.profile_2user,
        title: LangKey.parentHome.myCaregivers,
        showDivider: false,
        onTap: controller.onMyCaregiversTapped,
      ),
    ];
  }

  List<Widget> _buildNannyGeneralItems() {
    return [
      HomeMenuItemTile(
        icon: IconsaxPlusLinear.award,
        title: LangKey.nannyHome.rewards,
        onTap: controller.onRewardsTapped,
      ),
      HomeMenuItemTile(
        icon: IconsaxPlusLinear.discount_shape,
        title: LangKey.nannyHome.myOffers,
        onTap: controller.onMyOffersTapped,
      ),
      HomeMenuItemTile(
        icon: IconsaxPlusLinear.personalcard,
        title: LangKey.nannyHome.myPortfolio,
        onTap: controller.onMyPortfolioTapped,
      ),
      HomeMenuItemTile(
        icon: IconsaxPlusLinear.document_text,
        title: LangKey.nannyHome.documents,
        showDivider: false,
        onTap: controller.onDocumentsTapped,
      ),
    ];
  }
}
