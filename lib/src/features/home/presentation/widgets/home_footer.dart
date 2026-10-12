import 'package:alurei/src/features/auth/domain/entities/user.dart';
import 'package:alurei/src/imports/imports.dart';

class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key, required this.role});

  final AppUserRole role;

  @override
  Widget build(BuildContext context) {
    final isNanny = role == AppUserRole.nanny;

    return Column(
      children: [
        Text(
          isNanny ? LangKey.nannyHome.appVersion : LangKey.parentHome.version,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.appColors.secondaryText,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSpacing.xs.h),
        Text(
          isNanny
              ? LangKey.nannyHome.appSubtitle
              : LangKey.parentHome.premiumChildcare,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.appColors.secondaryText,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
