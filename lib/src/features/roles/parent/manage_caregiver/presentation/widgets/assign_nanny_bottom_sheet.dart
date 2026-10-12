import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import 'package:alurei/src/imports/imports.dart';

class AssignNannyBottomSheet extends HookWidget {
  const AssignNannyBottomSheet({
    super.key,
    required this.onInviteSent,
  });

  final ValueChanged<Map<String, dynamic>> onInviteSent;

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final searchController = useTextEditingController();

    final nannies = useState<List<dynamic>>([]);
    final isLoadingNannies = useState(false);
    final searchTimer = useRef<Timer?>(null);

    final fetchNannies = useCallback((String query) async {
      isLoadingNannies.value = true;
      final result = await ManageCaregiverService.instance.fetchNannies(search: query);
      result.fold(
        (l) => AppLogger.error('Failed to load nannies: ${l.message}'),
        (r) => nannies.value = r,
      );
      isLoadingNannies.value = false;
    }, []);

    useEffect(() {
      if (selectedTab.value == 1) {
        fetchNannies(searchController.text);
      }
      return null;
    }, [selectedTab.value]);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.appColors.primaryBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: context.appColors.bottomNavBorder,
                borderRadius: AppBorders.full,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  LangKey.parentToday.assignCaregiverNanny,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 18.sp,
                    height: 28 / 18,
                    fontWeight: FontWeight.w600,
                    color: context.appColors.primaryText,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  IconsaxPlusLinear.close_circle,
                  size: 24.sp,
                  color: context.appColors.mutedText,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            decoration: BoxDecoration(
              color: context.colors.primary.withValues(alpha: 0.1),
              borderRadius: AppBorders.md,
            ),
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => selectedTab.value = 0,
                    borderRadius: AppBorders.sm,
                    child: AnimatedContainer(
                      duration: AppDurations.fast,
                      height: 40.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedTab.value == 0
                            ? context.colors.primary
                            : AppColors.transparentColor,
                        borderRadius: AppBorders.sm,
                      ),
                      child: Text(
                        LangKey.parentToday.notOnAlurei,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          height: 20 / 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab.value == 0
                              ? context.colors.onPrimary
                              : context.appColors.mutedText,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: InkWell(
                    onTap: () => selectedTab.value = 1,
                    borderRadius: AppBorders.sm,
                    child: AnimatedContainer(
                      duration: AppDurations.fast,
                      height: 40.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedTab.value == 1
                            ? context.colors.primary
                            : AppColors.transparentColor,
                        borderRadius: AppBorders.sm,
                      ),
                      child: Text(
                        LangKey.parentToday.onAlurei,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          height: 20 / 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab.value == 1
                              ? context.colors.onPrimary
                              : context.appColors.mutedText,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          if (selectedTab.value == 0) ...[
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: context.colors.primary.withValues(alpha: 0.1),
                border: Border.all(
                  color: context.colors.primary.withValues(alpha: 0.3),
                ),
                borderRadius: AppBorders.lg,
              ),
              child: Row(
                children: [
                  Icon(
                    IconsaxPlusLinear.sms,
                    size: 20.sp,
                    color: context.colors.primary,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      LangKey.parentToday.inviteInfoNotice,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 12.sp,
                        height: 18 / 12,
                        fontWeight: FontWeight.w400,
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              LangKey.parentToday.sendViaEmail,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                height: 20 / 14,
                fontWeight: FontWeight.w600,
                color: context.appColors.primaryText,
              ),
            ),
            SizedBox(height: 6.h),
            AppFormTextInput(
              controller: emailController,
              hint: LangKey.parentToday.emailHintExample,
              prefixIcon: IconsaxPlusLinear.sms,
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                    child: Divider(color: context.appColors.bottomNavBorder)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    LangKey.parentToday.or,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: context.appColors.mutedText,
                    ),
                  ),
                ),
                Expanded(
                    child: Divider(color: context.appColors.bottomNavBorder)),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              LangKey.parentToday.sendViaWhatsapp,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                height: 20 / 14,
                fontWeight: FontWeight.w600,
                color: context.appColors.primaryText,
              ),
            ),
            SizedBox(height: 6.h),
            AppFormTextInput(
              controller: phoneController,
              hint: LangKey.parentToday.phoneHintExample,
              prefixIcon: IconsaxPlusLinear.call,
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  final email = emailController.text.trim();
                  final phone = phoneController.text.trim();
                  onInviteSent({
                    'invitedEmail': email.isNotEmpty ? email : null,
                    'invitedPhone': phone.isNotEmpty ? phone : null,
                    'inviteChannel': email.isNotEmpty ? 'EMAIL' : 'WHATSAPP',
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.primary,
                  foregroundColor: context.colors.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: AppBorders.lg),
                ),
                icon: Icon(IconsaxPlusLinear.send_2, size: 18.sp),
                label: Text(
                  LangKey.parentToday.sendInvite,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                    child: Divider(
                        color: context.colors.primary.withValues(alpha: 0.3))),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    LangKey.parentToday.orShareLinkDirectly,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: context.appColors.mutedText,
                    ),
                  ),
                ),
                Expanded(
                    child: Divider(
                        color: context.colors.primary.withValues(alpha: 0.3))),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  onInviteSent({
                    'inviteChannel': 'LINK',
                  });
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: context.colors.primary,
                  side: BorderSide(color: context.colors.primary),
                  shape: RoundedRectangleBorder(borderRadius: AppBorders.lg),
                ),
                icon: Icon(IconsaxPlusLinear.copy, size: 18.sp),
                label: Text(
                  LangKey.parentToday.copyInviteLink,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ] else ...[
            AppFormTextInput(
              controller: searchController,
              hint: LangKey.parentToday.searchNannyHint,
              prefixIcon: IconsaxPlusLinear.search_normal_1,
                            onChanged: (val) {
                searchTimer.value?.cancel();
                searchTimer.value = Timer(const Duration(milliseconds: 500), () {
                  fetchNannies(val);
                });
              },
            ),
            SizedBox(height: 16.h),
                        if (isLoadingNannies.value && nannies.value.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Center(child: CircularProgressIndicator(color: context.colors.primary)),
              )
            else if (nannies.value.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Center(
                  child: Text(
                    'No nannies found',
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      color: context.appColors.mutedText,
                    ),
                  ),
                ),
              )
            else
              ...nannies.value.map((nanny) {
                final imageUrl = nanny['image'] as String?;
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: context.appColors.elevatedBackground,
                      border: Border.all(
                        color: context.colors.primary.withValues(alpha: 0.2),
                      ),
                      borderRadius: AppBorders.lg,
                    ),
                    child: Row(
                      children: [
                        ClipOval(
                          child: imageUrl != null && imageUrl.isNotEmpty && imageUrl.startsWith('http')
                              ? CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  width: 48.w,
                                  height: 48.w,
                                  fit: BoxFit.cover,
                                  errorWidget: (_, __, ___) => Image.asset(
                                    AppAssets.parentTodayChildProfileAvatar,
                                    width: 48.w,
                                    height: 48.w,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.asset(
                                  AppAssets.parentTodayChildProfileAvatar,
                                  width: 48.w,
                                  height: 48.w,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nanny['fullName'] ?? nanny['name'] ?? '',
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 14.sp,
                                  height: 20 / 14,
                                  fontWeight: FontWeight.w600,
                                  color: context.appColors.primaryText,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                nanny['email'] ?? '',
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 12.sp,
                                  height: 18 / 12,
                                  fontWeight: FontWeight.w400,
                                  color: context.appColors.mutedText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            onInviteSent({
                              'invitedUserId': nanny['id'],
                              'invitedName': nanny['fullName'] ?? nanny['name'],
                              'inviteChannel': 'INTERNAL',
                            });
                          },
                          borderRadius: AppBorders.full,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: context.colors.primary.withValues(alpha: 0.1),
                              borderRadius: AppBorders.full,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  IconsaxPlusLinear.user_add,
                                  size: 14.sp,
                                  color: context.colors.primary,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  LangKey.parentToday.invite,
                                  style: GlobalTextStyles.interTextStyle(
                                    fontSize: 12.sp,
                                    height: 18 / 12,
                                    fontWeight: FontWeight.w500,
                                    color: context.colors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          ],
        ],
        ),
      ),
    );
  }
}

class InvitationSentDialog extends StatelessWidget {
  const InvitationSentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      backgroundColor: context.appColors.elevatedBackground,
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.primary,
              ),
              child: Icon(
                IconsaxPlusLinear.tick_circle,
                size: 40.sp,
                color: context.colors.onPrimary,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              LangKey.parentToday.invitationSent,
              textAlign: TextAlign.center,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 18.sp,
                height: 28 / 18,
                fontWeight: FontWeight.w600,
                color: context.appColors.primaryText,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              LangKey.parentToday.invitationSentDescription,
              textAlign: TextAlign.center,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                height: 20 / 14,
                fontWeight: FontWeight.w400,
                color: context.appColors.mutedText,
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: context.appColors.bottomNavBorder),
                  shape: RoundedRectangleBorder(borderRadius: AppBorders.lg),
                ),
                child: Text(
                  LangKey.parentToday.close,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    height: 20 / 14,
                    fontWeight: FontWeight.w600,
                    color: context.appColors.primaryText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
