import 'dart:ui';
import 'package:alurei/src/imports/imports.dart';
import 'package:alurei/src/features/role_selection/presentation/providers/role_selection_controller.dart';

/// Role selection screen shown after the splash welcome animation.
///
/// The user selects between "Parents/Family" and "Caregiver (Nanny)" before
/// proceeding to the auth flow.
class ChoosingScreen extends StatelessWidget {
  const ChoosingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RoleSelectionController>();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── 1. Background image ───────────────────────────────────────────
          // Figma spec: image is 204.2% wide, offset at −99.3% left,
          // filling the full height. OverflowBox replicates the zoom/crop.
          Positioned.fill(
            child: OverflowBox(
              maxWidth: MediaQuery.sizeOf(context).width * 2.042,
              alignment: Alignment.topRight,
              child: Image.asset(
                AppAssets.roleSelectionBg,
                fit: BoxFit.cover,
                width: MediaQuery.sizeOf(context).width * 2.042,
                height: double.infinity,
              ),
            ),
          ),

          // ── 2. Dark overlay (40% black per Figma) ─────────────────────────
          const Positioned.fill(
            child: ColoredBox(color: AppColors.black40),
          ),

          // ── 3. Content ────────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.pagePadding),
              child: Column(
                children: [
                  SizedBox(height: 74.h),
                  _buildLogoSection(),
                  SizedBox(height: 64.h),
                  _buildTextSection(),
                  SizedBox(height: AppSpacing.xxl),
                  _buildButtons(context, controller),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Logo + subtitle ─────────────────────────────────────────────────────
  Widget _buildLogoSection() {
    return Column(
      children: [
        _StaticLogo(logoWidth: 253.w),
        SizedBox(height: AppSpacing.sm),
        Text(
          LangKey.welcome.logoSubtitle.toUpperCase(),
          style: GlobalTextStyles.interTextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.brandTealIce,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ── Title + description ─────────────────────────────────────────────────
  Widget _buildTextSection() {
    return Column(
      children: [
        Text(
          LangKey.roleSelection.title,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 30.sp,
            fontWeight: FontWeight.w600,
            height: 38 / 30,
            color: AppColors.brandTealLight,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: 380.w,
          child: Text(
            LangKey.roleSelection.subtitle,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              height: 24 / 16,
              color: AppColors.brandGray50,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  // ── Role buttons ────────────────────────────────────────────────────────
  Widget _buildButtons(
      BuildContext context, RoleSelectionController controller) {
    return Column(
      children: [
        // Parents / Family — filled primary button
        SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: AppBorders.lg,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black05,
                  blurRadius: 4,
                ),
              ],
            ),
            child: Material(
              color: AppColors.transparentColor,
              borderRadius: AppBorders.lg,
              child: InkWell(
                borderRadius: AppBorders.lg,
                onTap: () => controller.selectRole('parent'),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: Text(
                    LangKey.roleSelection.parentOption,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      height: 28 / 18,
                      color: AppColors.brandTealSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: AppSpacing.lg),

        // Caregiver (Nanny) — glassmorphic outline button
        SizedBox(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: AppBorders.lg,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.brandTealGlassBg,
                  borderRadius: AppBorders.lg,
                  border: Border.all(color: AppColors.brandTealIce),
                ),
                child: Material(
                  color: AppColors.transparentColor,
                  borderRadius: AppBorders.lg,
                  child: InkWell(
                    borderRadius: AppBorders.lg,
                    onTap: () => controller.selectRole('nanny'),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      child: Text(
                        LangKey.roleSelection.caregiverOption,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          height: 28 / 18,
                          color: AppColors.brandTealIce,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Static logo (settled dot on the 'i') ──────────────────────────────────
class _StaticLogo extends StatelessWidget {
  final double logoWidth;

  const _StaticLogo({required this.logoWidth});

  @override
  Widget build(BuildContext context) {
    // SVG coordinate space is 253.367 × 77.4008
    final double scale = logoWidth / 253.367;
    final double logoHeight = 77.4008 * scale;
    final double dotWidth = 23 * scale;
    final double dotHeight = 22 * scale;

    // Dot settled on the 'i', shifted up slightly by 4 units to sit perfectly
    const double dotX = 242;
    const double dotY = -4;
    final double left = (dotX - 10.5) * scale;
    final double top = dotY * scale;

    const colorFilter = ColorFilter.mode(
      AppColors.brandLogoLight,
      BlendMode.srcIn,
    );

    return SizedBox(
      width: logoWidth,
      height: logoHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AppAssets.logoText,
              colorFilter: colorFilter,
            ),
          ),
          Positioned(
            left: left,
            top: top,
            width: dotWidth,
            height: dotHeight,
            child: SvgPicture.asset(
              AppAssets.logoDot,
              colorFilter: colorFilter,
            ),
          ),
        ],
      ),
    );
  }
}
