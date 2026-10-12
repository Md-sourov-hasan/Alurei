import 'package:alurei/src/features/auth/domain/entities/user.dart';
import 'package:alurei/src/features/home/domain/entities/home_profile.dart';
import 'package:alurei/src/imports/imports.dart';

class HomeProfileCard extends StatelessWidget {
  const HomeProfileCard({
    super.key,
    required this.profile,
    required this.onEditTapped,
    required this.onMembershipTapped,
  });

  final HomeProfile profile;
  final VoidCallback onEditTapped;
  final VoidCallback onMembershipTapped;

  @override
  Widget build(BuildContext context) {
    final user = profile.user;
    final subtitle = _subtitleForProfile(profile);
    final detail = _detailForProfile(profile);
    final isNanny = user.role == AppUserRole.nanny;
    final careScore = profile.nannyProfile?.careScore ?? 90;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg.w),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: AppBorders.lg,
        border: Border.all(
          color: context.colors.primary.withValues(alpha: 0.1),
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HomeAvatar(photoUrl: user.photoUrl),
              SizedBox(width: AppSpacing.md.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name ?? user.email,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: context.colors.onSurface,
                      ),
                    ),
                    SizedBox(height: AppSpacing.xs.h),
                    if (isNanny)
                      Row(
                        children: [
                          Text(
                            subtitle,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: context.colors.primary,
                            ),
                          ),
                          SizedBox(width: AppSpacing.sm.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  context.colors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: context.colors.primary
                                    .withValues(alpha: 0.25),
                              ),
                            ),
                            child: Text(
                              'Care score: $careScore',
                              style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                color: context.colors.primary,
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      Text(
                        subtitle,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: context.colors.primary,
                        ),
                      ),
                    if (detail != null) ...[
                      SizedBox(height: AppSpacing.xs.h),
                      Text(
                        detail,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                          color: context.appColors.secondaryText,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                onPressed: onEditTapped,
                icon: Icon(
                  IconsaxPlusLinear.edit,
                  color: context.appColors.secondaryText,
                  size: 24.sp,
                ),
              ),
            ],
          ),
          if (user.role == AppUserRole.parent) ...[
            SizedBox(height: AppSpacing.lg.h),
            _MembershipBanner(onTap: onMembershipTapped),
          ],
        ],
      ),
    );
  }

  String _subtitleForProfile(HomeProfile profile) {
    if (profile.user.role == AppUserRole.nanny) {
      return LangKey.nannyHome.nanny;
    }

    final relationship =
        profile.parentProfile?.relationship ?? profile.user.relationship;
    switch (relationship?.toUpperCase()) {
      case 'MOTHER':
        return LangKey.editProfile.mother;
      case 'FATHER':
        return LangKey.editProfile.father;
      case 'GUARDIAN':
      case 'GURDIAN':
        return LangKey.editProfile.guardian;
      case 'SIBLING':
        return LangKey.editProfile.sibling;
      case 'GRANDFATHER':
        return LangKey.editProfile.grandfather;
      case 'GRANDMOTHER':
        return LangKey.editProfile.grandmother;
      case 'UNCLE':
        return LangKey.editProfile.uncle;
      case 'AUNT':
        return LangKey.editProfile.aunt;
      default:
        return LangKey.editProfile.relative;
    }
  }

  String? _detailForProfile(HomeProfile profile) {
    if (profile.user.role == AppUserRole.parent) {
      return profile.parentProfile?.address ??
          profile.user.address ??
          profile.user.phoneNumber;
    }

    return profile.user.email.isNotEmpty ? profile.user.email : null;
  }
}

class _HomeAvatar extends StatelessWidget {
  const _HomeAvatar({required this.photoUrl});

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62.w,
      height: 62.h,
      padding: EdgeInsets.all(AppSpacing.xxs),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: context.colors.primary.withValues(alpha: 0.25),
          width: 2.w,
        ),
      ),
      child: ClipRRect(
        borderRadius: AppBorders.full,
        child: photoUrl != null && photoUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: photoUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => const _HomeAvatarFallback(),
                errorWidget: (context, url, error) =>
                    const _HomeAvatarFallback(),
              )
            : const _HomeAvatarFallback(),
      ),
    );
  }
}

class _HomeAvatarFallback extends StatelessWidget {
  const _HomeAvatarFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.primaryContainer,
      alignment: Alignment.center,
      child: Icon(
        IconsaxPlusLinear.user,
        color: context.colors.onPrimaryContainer,
        size: 32.sp,
      ),
    );
  }
}

class _MembershipBanner extends StatelessWidget {
  const _MembershipBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg.w),
      decoration: BoxDecoration(
        color: context.colors.primary,
        borderRadius: AppBorders.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    IconsaxPlusLinear.crown,
                    color: context.colors.onPrimary,
                    size: 24.sp,
                  ),
                  SizedBox(width: AppSpacing.xs.w),
                  Text(
                    LangKey.parentHome.familyMembership,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.onPrimary,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              Text(
                '99 AED',
                style: context.textTheme.titleLarge?.copyWith(
                  color: context.colors.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm.h),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LangKey.parentHome.manageMembership,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.onPrimary,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(width: AppSpacing.xxs.w),
                  Icon(
                    IconsaxPlusLinear.arrow_right_3,
                    color: context.colors.onPrimary,
                    size: 20.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
