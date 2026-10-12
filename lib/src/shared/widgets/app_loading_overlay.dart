import '../../imports/imports.dart';

/// A full-screen loading overlay that fades in over the current content.
///
/// Shows a centered circular progress indicator on the app surface background,
/// matching the Figma "Loading Screen" spec (node 23523:62579).
///
/// **Reusable** — can be used anywhere via:
/// ```dart
/// // 1. As a page-level overlay inside a Stack:
/// Stack(children: [
///   YourContent(),
///   if (isLoading) const AppLoadingOverlay(),
/// ])
///
/// // 2. As a GetX full-screen dialog:
/// AppLoadingOverlay.show();  // show
/// AppLoadingOverlay.hide();  // hide
/// ```
class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({
    super.key,
    this.backgroundColor,
    this.indicatorColor,
    this.trackColor,
    this.indicatorSize = 40,
    this.strokeWidth = 3.5,
  });

  /// Background of the overlay. Defaults to the app surface color.
  final Color? backgroundColor;

  /// Active indicator color. Defaults to the primary color.
  final Color? indicatorColor;

  /// Track (background ring) color. Defaults to the brand teal track.
  final Color? trackColor;

  /// Diameter of the progress indicator.
  final double indicatorSize;

  /// Stroke width of the progress indicator.
  final double strokeWidth;

  // ── Static helpers for GetX dialog usage ─────────────────────────────────

  /// Shows a full-screen loading overlay as a GetX dialog.
  static void show({
    Color? backgroundColor,
    Color? indicatorColor,
    Color? trackColor,
  }) {
    Get.dialog<void>(
      AppLoadingOverlay(
        backgroundColor: backgroundColor,
        indicatorColor: indicatorColor,
        trackColor: trackColor,
      ),
      barrierDismissible: false,
      barrierColor: AppColors.transparentColor,
      useSafeArea: false,
    );
  }

  /// Hides the currently-shown loading overlay dialog.
  static void hide() {
    if (Get.isDialogOpen ?? false) {
      Get.back<void>();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.theme.colorScheme;

    return Material(
      color: backgroundColor ?? cs.surface,
      child: Center(
        child: SizedBox(
          width: indicatorSize,
          height: indicatorSize,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            color: indicatorColor ?? cs.primary,
            backgroundColor: trackColor ?? AppColors.brandTealTrack,
          ),
        ),
      ),
    );
  }
}
