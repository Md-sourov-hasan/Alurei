import '../../imports/imports.dart';

/// One destination displayed by [AppBottomNavBar].
@immutable
class AppBottomNavDestination {
  const AppBottomNavDestination({
    required this.label,
    required this.assetPath,
  });

  final String label;
  final String assetPath;
}

/// Role-neutral main navigation shared by Parent and Nanny app shells.
///
/// Pixel-accurate to the Figma "Bottom Nav Bar" component.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.destinations,
  }) : assert(selectedIndex >= 0);

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<AppBottomNavDestination>? destinations;

  static List<AppBottomNavDestination> get mainDestinations => [
        AppBottomNavDestination(
          label: LangKey.shared.navigation.today,
          assetPath: AppAssets.navToday,
        ),
        AppBottomNavDestination(
          label: LangKey.shared.navigation.kitchen,
          assetPath: AppAssets.navKitchen,
        ),
        AppBottomNavDestination(
          label: LangKey.shared.navigation.activities,
          assetPath: AppAssets.navActivities,
        ),
        AppBottomNavDestination(
          label: LangKey.shared.navigation.care,
          assetPath: AppAssets.navCare,
        ),
        AppBottomNavDestination(
          label: LangKey.shared.navigation.home,
          assetPath: AppAssets.navHome,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final items = destinations ?? mainDestinations;
    assert(items.isNotEmpty, 'AppBottomNavBar needs at least one destination.');
    assert(
      selectedIndex < items.length,
      'selectedIndex must identify an available destination.',
    );

    final appColors = context.appColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: appColors.bottomNavBackground,
        border: Border(
          top: BorderSide(
            color: const Color(0xFFE0E8E8),
            width: 1.h,
          ),
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        child: Material(
          color: AppColors.transparentColor,
          child: SafeArea(
            top: false,
            minimum: EdgeInsets.only(bottom: 12.h),
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                start: 12.w,
                top: 10.h,
                end: 12.w,
              ),
              child: Row(
                children: [
                  for (var index = 0; index < items.length; index++)
                    Expanded(
                      child: _BottomNavItem(
                        destination: items[index],
                        selected: index == selectedIndex,
                        selectedBackground:
                            appColors.bottomNavSelectedBackground,
                        onTap: () => onDestinationSelected(index),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.destination,
    required this.selected,
    required this.selectedBackground,
    required this.onTap,
  });

  final AppBottomNavDestination destination;
  final bool selected;
  final Color selectedBackground;
  final VoidCallback onTap;

  static const String _kitchenAsset = AppAssets.navKitchen;

  @override
  Widget build(BuildContext context) {
    final bool isKitchen = destination.assetPath == _kitchenAsset;
    final iconColor = selected ? const Color(0xFF004D54) : const Color(0xFF6C7E80);

    return Semantics(
      button: true,
      selected: selected,
      label: destination.label,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        curve: AppCurves.standard,
        height: 56.h,
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEBF4F4) : AppColors.transparentColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox.square(
                dimension: 22.w,
                child: Center(
                  child: SvgPicture.asset(
                    destination.assetPath,
                    width: isKitchen ? 18.w : 22.w,
                    height: isKitchen ? 18.w : 22.w,
                    colorFilter: ColorFilter.mode(
                      iconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              AnimatedDefaultTextStyle(
                duration: AppDurations.fast,
                curve: AppCurves.standard,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                  height: 1.2,
                  letterSpacing: 0,
                  color: iconColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    destination.label,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
