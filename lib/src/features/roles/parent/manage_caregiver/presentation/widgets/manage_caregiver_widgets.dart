import 'package:alurei/src/imports/imports.dart';
import 'package:alurei/src/shared/helpers/dotted_border_painter.dart';
import 'package:alurei/src/features/roles/parent/manage_caregiver/domain/entities/caregiver_member.dart';

class CaregiverSectionHeader extends StatelessWidget {
  const CaregiverSectionHeader({
    super.key,
    required this.title,
    required this.isSecondary,
  });

  final String title;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    final headerColor = isSecondary
        ? context.appColors.secondaryText
        : context.colors.primary;

    return Row(
      children: [
        Container(
          width: 6.w,
          height: 24.h,
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: AppBorders.full,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 14.sp,
            height: 20 / 14,
            fontWeight: FontWeight.w600,
            color: headerColor,
          ),
        ),
      ],
    );
  }
}

class CaregiverCard extends StatelessWidget {
  const CaregiverCard({
    super.key,
    required this.caregiver,
    required this.onManagePermissions,
    required this.onRemove,
  });

  final CaregiverMember caregiver;
  final VoidCallback onManagePermissions;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final isAccountOwner = caregiver.roleCategory == 'account_owner';
    final isPending = caregiver.status == 'pending';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: AppBorders.lg,
        boxShadow: AppShadows.subtle,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: context.colors.primary, width: 2.w),
            ),
            child: ClipOval(
              child: caregiver.avatarAsset.startsWith('http')
                  ? CachedNetworkImage(
                      imageUrl: caregiver.avatarAsset,
                      width: 36.w,
                      height: 36.w,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 36.w,
                        height: 36.w,
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 16.w,
                          height: 16.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: context.colors.primary,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        AppAssets.parentTodayParentAvatar,
                        width: 36.w,
                        height: 36.w,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      caregiver.avatarAsset.isNotEmpty
                          ? caregiver.avatarAsset
                          : AppAssets.parentTodayParentAvatar,
                      width: 36.w,
                      height: 36.w,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  caregiver.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 18.sp,
                    height: 28 / 18,
                    fontWeight: FontWeight.w600,
                    color: context.appColors.primaryText,
                  ),
                ),
                SizedBox(height: 2.h),
                RichText(
                  text: TextSpan(
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      height: 20 / 14,
                      fontWeight: FontWeight.w400,
                      color: context.appColors.mutedText,
                    ),
                    children: [
                      TextSpan(
                        text: LangKey.parentToday.caringFor
                            .tr(args: [caregiver.caringFor]),
                      ),
                      if (caregiver.familyRelation != null &&
                          caregiver.familyRelation!.isNotEmpty) ...[
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: '(${caregiver.familyRelation})',
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 12.sp,
                            height: 18 / 12,
                            fontWeight: FontWeight.w700,
                            color: context.colors.primary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          if (!isAccountOwner) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isPending)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF79009).withValues(alpha: 0.1),
                      borderRadius: AppBorders.full,
                    ),
                    child: Text(
                      LangKey.parentToday.pending,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 12.sp,
                        height: 18 / 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFDC6803),
                      ),
                    ),
                  )
                else
                  IconButton(
                    onPressed: onRemove,
                    icon: Icon(
                      IconsaxPlusLinear.user_remove,
                      size: 18.sp,
                      color: const Color(0xFFF04438),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints.tight(Size(32.w, 32.w)),
                  ),
                SizedBox(height: 6.h),
                InkWell(
                  onTap: onManagePermissions,
                  child: Text(
                    LangKey.parentToday.managePermissions,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      height: 20 / 14,
                      fontWeight: FontWeight.w600,
                      color: context.appColors.secondaryText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class AssignCaregiverDashedButton extends StatelessWidget {
  const AssignCaregiverDashedButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedBorderPainter(
        color: context.colors.primary.withValues(alpha: 0.5),
        strokeWidth: 1.2,
        dash: 6,
        gap: 4,
        radius: 24.r,
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 18.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                IconsaxPlusLinear.user_add,
                size: 22.sp,
                color: context.colors.primary,
              ),
              SizedBox(height: 6.h),
              Text(
                LangKey.parentToday.assignCaregiverNannyAction,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  height: 20 / 14,
                  fontWeight: FontWeight.w500,
                  color: context.colors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
