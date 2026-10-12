import 'package:alurei/src/features/auth/presentation/providers/session_controller.dart';

import '../../imports/imports.dart';

/// Figma-aligned application bar for detail, profile, and form screens.
///
/// Supply already-localized text (normally a `LangKey` getter). Navigation,
/// submission, sharing, and other business actions remain owned by the calling
/// controller or screen composition.
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    required this.title,
    this.titleWidget,
    this.actions,
    this.centerTitle = true,
    this.onPressed,
    this.isTransparent = false,
    this.showBackButton = true,
    this.showDivider = false,
    this.titleColor,
    this.titleFontSize = 20,
    this.titleFontWeight = FontWeight.w700,
    this.toolbarHeight = 66,
    this.horizontalPadding = 10,
    this.submitLabel,
    this.onSubmit,
    this.submitEnabled = true,
    this.showSubmitButton = true,
    this.showCurrentUser = false,
    this.currentUserName,
    this.currentUserAvatarUrl,
  }) : assert(
          (submitLabel == null) == (onSubmit == null),
          'submitLabel and onSubmit must be provided together.',
        );

  /// Creates the larger profile header with the Figma submit-button treatment.
  const AppTopBar.withSubmit({
    super.key,
    this.title = '',
    required this.submitLabel,
    required this.onSubmit,
    this.titleWidget,
    this.centerTitle = true,
    this.onPressed,
    this.isTransparent = false,
    this.showBackButton = true,
    this.showDivider = false,
    this.titleColor,
    this.submitEnabled = true,
    this.showSubmitButton = true,
    this.showCurrentUser = false,
    this.currentUserName,
    this.currentUserAvatarUrl,
  })  : actions = null,
        titleFontSize = 24,
        titleFontWeight = FontWeight.w700,
        toolbarHeight = 72,
        horizontalPadding = 16;

  final String title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool centerTitle;
  final VoidCallback? onPressed;
  final bool isTransparent;
  final bool showBackButton;
  final bool showDivider;
  final Color? titleColor;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final double toolbarHeight;
  final double horizontalPadding;
  final String? submitLabel;
  final VoidCallback? onSubmit;
  final bool submitEnabled;
  final bool showSubmitButton;
  final bool showCurrentUser;
  final String? currentUserName;
  final String? currentUserAvatarUrl;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final appColors = context.appColors;
    final trailing = <Widget>[
      ...?actions,
      if (submitLabel != null && showSubmitButton)
        Padding(
          padding: EdgeInsetsDirectional.only(end: horizontalPadding.w),
          child: _AppBarSubmitButton(
            label: submitLabel!,
            onPressed: submitEnabled ? onSubmit : null,
          ),
        ),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isTransparent
            ? AppColors.transparentColor
            : appColors.bottomNavBackground,
        border: showDivider
            ? Border(bottom: BorderSide(color: appColors.bottomNavBorder))
            : null,
        boxShadow: submitLabel != null && showSubmitButton
            ? AppShadows.subtle
            : AppShadows.none,
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: centerTitle,
        toolbarHeight: toolbarHeight.h,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.transparentColor,
        surfaceTintColor: AppColors.transparentColor,
        titleSpacing: 0,
        leadingWidth: showBackButton ? 56.w : horizontalPadding.w,
        leading: showBackButton
            ? Padding(
                padding: EdgeInsetsDirectional.only(start: horizontalPadding.w),
                child: _AppBarBackButton(onPressed: onPressed),
              )
            : null,
        title: titleWidget ??
            (showCurrentUser
                ? _CurrentUserAppBarTitle(
                    name: currentUserName,
                    avatarUrl: currentUserAvatarUrl,
                  )
                : Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: titleFontSize.sp,
                      height: titleFontSize >= 24 ? 32 / 24 : 30 / 20,
                      fontWeight: titleFontWeight,
                      letterSpacing: 0,
                      color: titleColor ?? colors.onSurface,
                    ),
                  )),
        actions: trailing,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight.h);
}

class _CurrentUserAppBarTitle extends StatelessWidget {
  const _CurrentUserAppBarTitle({
    this.name,
    this.avatarUrl,
  });

  final String? name;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SessionController>()) {
      return _CurrentUserIdentityRow(
        name: _displayName(name),
        avatarUrl: avatarUrl,
      );
    }

    final session = Get.find<SessionController>();
    return Obx(() {
      final user = session.user.value;
      return SkeletonWrapper(
        isLoading: session.isProfileLoading.value,
        child: _CurrentUserIdentityRow(
          name: _displayName(name ?? user?.fullName),
          avatarUrl: _displayAvatar(avatarUrl ?? user?.profilePictureUrl),
        ),
      );
    });
  }

  String _displayName(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? 'User' : trimmed;
  }

  String? _displayAvatar(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}

class _CurrentUserIdentityRow extends StatelessWidget {
  const _CurrentUserIdentityRow({
    required this.name,
    required this.avatarUrl,
  });

  final String name;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _AppBarAvatar(imageUrl: avatarUrl, size: 38),
        SizedBox(width: 8.w),
        Flexible(
          child: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 16.sp,
              height: 24 / 16,
              fontWeight: FontWeight.w600,
              color: context.appColors.primaryText,
            ),
          ),
        ),
      ],
    );
  }
}

/// Dashboard app bar with identity, greeting, notification, and message actions.
class AppDashboardTopBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AppDashboardTopBar({
    super.key,
    required this.greeting,
    required this.userName,
    required this.onNotifications,
    required this.onMessages,
    this.avatarUrl,
    this.notificationCount = 0,
    this.messageCount = 0,
    this.toolbarHeight = 80,
  });

  final String greeting;
  final String userName;
  final String? avatarUrl;
  final int notificationCount;
  final int messageCount;
  final double toolbarHeight;
  final VoidCallback onNotifications;
  final VoidCallback onMessages;

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: appColors.bottomNavBackground,
        border: Border(bottom: BorderSide(color: appColors.bottomNavBorder)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Expanded(
                child: _DashboardUserIdentity(
                  greeting: greeting,
                  userName: userName,
                  avatarUrl: avatarUrl,
                ),
              ),
              SizedBox(width: 8.w),
              AppTopBarIconAction(
                icon: IconsaxPlusLinear.notification,
                svg: AppAssets.icNotification,
                onPressed: onNotifications,
                badgeCount: notificationCount,
                filled: true,
              ),
              SizedBox(width: 16.w),
              AppTopBarIconAction(
                icon: IconsaxPlusLinear.message,
                svg: AppAssets.icChat,
                onPressed: onMessages,
                badgeCount: messageCount,
                filled: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight.h);
}

class _DashboardUserIdentity extends StatelessWidget {
  const _DashboardUserIdentity({
    required this.greeting,
    required this.userName,
    required this.avatarUrl,
  });

  final String greeting;
  final String userName;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SessionController>()) {
      return _DashboardUserIdentityRow(
        greeting: greeting,
        userName: userName,
        avatarUrl: avatarUrl,
      );
    }

    final session = Get.find<SessionController>();
    return Obx(() {
      final user = session.user.value;
      return SkeletonWrapper(
        isLoading: session.isProfileLoading.value,
        child: _DashboardUserIdentityRow(
          greeting: greeting,
          userName: _displayName(user?.fullName ?? userName),
          avatarUrl: _displayAvatar(user?.profilePictureUrl ?? avatarUrl),
        ),
      );
    });
  }

  String _displayName(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? 'User' : trimmed;
  }

  String? _displayAvatar(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}

class _DashboardUserIdentityRow extends StatelessWidget {
  const _DashboardUserIdentityRow({
    required this.greeting,
    required this.userName,
    required this.avatarUrl,
  });

  final String greeting;
  final String userName;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Row(
      children: [
        _AppBarAvatar(imageUrl: avatarUrl, size: 46),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  height: 20 / 14,
                  fontWeight: FontWeight.w500,
                  color: appColors.secondaryText,
                ),
              ),
              Text(
                userName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 20.sp,
                  height: 30 / 20,
                  fontWeight: FontWeight.w600,
                  color: appColors.primaryText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Centered message-list app bar with the Figma message glyph beside its title.
class AppMessagesTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppMessagesTopBar({
    super.key,
    required this.title,
    this.onBack,
  });

  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return AppTopBar(
      title: title,
      onPressed: onBack,
      toolbarHeight: 56,
      titleWidget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            IconsaxPlusLinear.message,
            size: 24.sp,
            color: context.colors.primary,
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 24.sp,
              height: 32 / 24,
              fontWeight: FontWeight.w600,
              color: context.colors.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}

/// Conversation header with presence, language selection, and information action.
class AppConversationTopBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AppConversationTopBar({
    super.key,
    required this.name,
    required this.status,
    required this.languageLabel,
    required this.onLanguagePressed,
    required this.onInfoPressed,
    this.avatarUrl,
    this.isOnline = false,
    this.onBack,
  });

  final String name;
  final String status;
  final String languageLabel;
  final String? avatarUrl;
  final bool isOnline;
  final VoidCallback? onBack;
  final VoidCallback onLanguagePressed;
  final VoidCallback onInfoPressed;

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Material(
      color: appColors.bottomNavBackground,
      child: SafeArea(
        bottom: false,
        child: Padding(
          // Eight vertical pixels preserve the Figma 64 px bar while allowing
          // the specified 30 px + 18 px name/status line heights to fit.
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            children: [
              _AppBarBackButton(onPressed: onBack),
              SizedBox(width: 19.w),
              _AppBarAvatar(
                imageUrl: avatarUrl,
                size: 40,
                showOnlineIndicator: isOnline,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 20.sp,
                        height: 30 / 20,
                        fontWeight: FontWeight.w600,
                        color: appColors.primaryText,
                      ),
                    ),
                    Text(
                      status,
                      maxLines: 1,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 12.sp,
                        height: 18 / 12,
                        fontWeight: FontWeight.w600,
                        color: context.colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              _LanguageAction(
                label: languageLabel,
                onPressed: onLanguagePressed,
              ),
              SizedBox(width: 12.w),
              AppTopBarIconAction(
                icon: IconsaxPlusLinear.info_circle,
                onPressed: onInfoPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(64.h);
}

/// Standard Iconsax action used by app-bar variants.
class AppTopBarIconAction extends StatelessWidget {
  const AppTopBarIconAction({
    super.key,
    required this.icon,
    required this.onPressed,
    this.svg,
    this.badgeCount = 0,
    this.filled = false,
    this.danger = false,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? svg;
  final int badgeCount;
  final bool filled;
  final bool danger;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final foreground = danger ? context.colors.error : context.colors.primary;

    return Badge(
      isLabelVisible: badgeCount > 0,
      label: Text(badgeCount > 99 ? '99+' : badgeCount.toString()),
      backgroundColor: const Color(0xFF009E9E),
      textColor: context.colors.onSecondary,
      child: IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        icon: (svg != null)
            ? SvgPicture.asset(
                svg!,
                width: 24.w,
                height: 24.w,
                colorFilter:
                    ColorFilter.mode(context.colors.primary, BlendMode.srcIn),
              )
            : Icon(icon, size: 24.sp),
        color: foreground,
        style: IconButton.styleFrom(
          fixedSize: Size(48.w, 48.w),
          backgroundColor: filled ? foreground.withValues(alpha: 0.10) : null,
          side: danger ? BorderSide(color: context.colors.error) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
    );
  }
}

class _AppBarBackButton extends StatelessWidget {
  const _AppBarBackButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () => Navigator.maybePop(context),
      icon: const Icon(IconsaxPlusLinear.arrow_left),
      color: context.colors.primary,
      iconSize: 20.sp,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints.tight(Size(40.w, 40.w)),
      style: IconButton.styleFrom(shape: const CircleBorder()),
    );
  }
}

class _AppBarSubmitButton extends StatelessWidget {
  const _AppBarSubmitButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Text(
        label,
        style: GlobalTextStyles.interTextStyle(
          fontSize: 18.sp,
          height: 28 / 18,
          fontWeight: FontWeight.w500,
          color: context.colors.onPrimary,
        ),
      ),
    );
  }
}

class _AppBarAvatar extends StatelessWidget {
  const _AppBarAvatar({
    required this.imageUrl,
    required this.size,
    this.showOnlineIndicator = false,
  });

  final String? imageUrl;
  final double size;
  final bool showOnlineIndicator;

  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      width: size.w,
      height: size.w,
      padding: EdgeInsets.all(1.5.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: context.appColors.bottomNavBorder),
      ),
      child: ClipOval(
        child: imageUrl == null || imageUrl!.isEmpty
            ? const _AppBarAvatarFallback()
            : CommonImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                placeholder: const _AppBarAvatarFallback(),
                errorWidget: const _AppBarAvatarFallback(),
              ),
      ),
    );

    if (!showOnlineIndicator) return avatar;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        avatar,
        PositionedDirectional(
          end: 0,
          bottom: 0,
          child: Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.appColors.success,
              border: Border.all(
                color: context.appColors.bottomNavBackground,
                width: 1.25.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AppBarAvatarFallback extends StatelessWidget {
  const _AppBarAvatarFallback();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.surfaceContainerHighest,
      child: Icon(
        IconsaxPlusLinear.user,
        color: context.appColors.mutedText,
      ),
    );
  }
}

class _LanguageAction extends StatelessWidget {
  const _LanguageAction({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        side: BorderSide(color: context.colors.surfaceContainerHighest),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              height: 18 / 12,
              fontWeight: FontWeight.w700,
              color: context.colors.primary,
            ),
          ),
          SizedBox(width: 4.w),
          Icon(
            IconsaxPlusLinear.arrow_down_1,
            size: 16.sp,
            color: context.colors.primary,
          ),
        ],
      ),
    );
  }
}
