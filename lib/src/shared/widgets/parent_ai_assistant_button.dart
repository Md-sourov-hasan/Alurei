import 'dart:async';
import 'package:alurei/src/imports/imports.dart';

class ParentAiAssistantButton extends HookWidget {
  const ParentAiAssistantButton({
    super.key,
    required this.menuOpen,
    required this.onPressed,
    this.onOptionSelected,
  });

  final bool menuOpen;
  final VoidCallback onPressed;
  final VoidCallback? onOptionSelected;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      if (menuOpen) {
        final timer = Timer(const Duration(seconds: 2), () {
          if (menuOpen) {
            onPressed();
          }
        });
        return timer.cancel;
      }
      return null;
    }, [menuOpen]);

    final handleOptionTap = onOptionSelected ??
        () {
          Get.toNamed<void>(AppRoutes.parentAi);
        };

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 250),
          switchInCurve: Curves.easeOutBack,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) {
            final scaleAnimation =
                Tween<double>(begin: 0.8, end: 1).animate(animation);
            final slideAnimation = Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(animation);

            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: SlideTransition(
                  position: slideAnimation,
                  child: child,
                ),
              ),
            );
          },
          child: menuOpen
              ? Padding(
                  key: const ValueKey('ai_chips_menu_open'),
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _AiChip(
                        label: LangKey.parentToday.whatNow,
                        onTap: handleOptionTap,
                      ),
                      SizedBox(height: 6.h),
                      _AiChip(
                        label: LangKey.parentToday.askAi,
                        onTap: handleOptionTap,
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(key: ValueKey('ai_chips_menu_closed')),
        ),
        Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: menuOpen ? handleOptionTap : onPressed,
            child: ClipOval(
              child: SizedBox(
                width: 64.w,
                height: 64.w,
                child: Transform.scale(
                  scale: 1.35,
                  child: Image.asset(
                    AppAssets.parentTodayAiAssistant,
                    fit: BoxFit.cover,
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

class _AiChip extends StatelessWidget {
  const _AiChip({
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.whiteBackgroundColor,
          borderRadius: AppBorders.full,
          boxShadow: AppShadows.subtle,
          border: Border.all(color: context.colors.primary),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Text(
            label,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.w600,
              height: 20 / 14,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
