import 'package:alurei/src/imports/imports.dart';

class HomeMenuSection extends StatelessWidget {
  const HomeMenuSection({
    super.key,
    this.title,
    required this.children,
  });

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.sm.h),
            child: Text(
              title!,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: context.colors.onSurface,
              ),
            ),
          ),
        ],
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.appColors.elevatedBackground,
            borderRadius: AppBorders.lg,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: children),
        ),
      ],
    );
  }
}
