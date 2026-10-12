import 'package:alurei/src/imports/imports.dart';

/// Temporary tab content used until the role-specific feature is implemented.
class RolePlaceholderScreen extends StatelessWidget {
  const RolePlaceholderScreen({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.appColors.primaryBackground,
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48.sp, color: context.colors.primary),
              SizedBox(height: AppSpacing.md),
              Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
