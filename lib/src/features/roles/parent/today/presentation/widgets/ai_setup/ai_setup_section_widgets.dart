import 'package:alurei/src/imports/imports.dart';

class AiSetupSectionTitle extends StatelessWidget {
  const AiSetupSectionTitle({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: context.colors.primary),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            title,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              height: 20 / 14,
              fontWeight: FontWeight.w500,
              color: context.colors.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class AiSetupSmallLabel extends StatelessWidget {
  const AiSetupSmallLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GlobalTextStyles.interTextStyle(
        fontSize: 12.sp,
        height: 18 / 12,
        fontWeight: FontWeight.w700,
        color: context.appColors.primaryText,
      ),
    );
  }
}
