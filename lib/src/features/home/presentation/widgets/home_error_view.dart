import 'package:alurei/src/imports/imports.dart';

class HomeErrorView extends StatelessWidget {
  const HomeErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.error,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.md.h),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(LangKey.parentToday.retry),
            ),
          ],
        ),
      ),
    );
  }
}
