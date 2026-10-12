import '../../../imports/imports.dart';

class RawToast extends HookWidget {
  final Widget child;
  final Duration animationDuration;
  final Duration snackbarDuration;
  final Curve? animationCurve;
  final bool autoDismiss;
  final ToastPosition toastPosition;
  final double Function() getscaleFactor;
  final double Function() getPosition;
  final void Function() onRemove;

  const RawToast({
    super.key,
    required this.child,
    required this.animationDuration,
    required this.toastPosition,
    required this.snackbarDuration,
    required this.onRemove,
    this.autoDismiss = true,
    required this.getPosition,
    this.animationCurve,
    required this.getscaleFactor,
  });

  Widget _getChildBasedOnDismiss(Widget child) {
    return Animate(
      onComplete: (controller) {
        if (autoDismiss) {
          onRemove();
        }
      },
      effects: [
        SlideEffect(
          begin: Offset(
            0,
            toastPosition == ToastPosition.bottom ? 2 : -2,
          ),
          end: Offset.zero,
          duration: Duration(
            milliseconds: 2 * animationDuration.inMilliseconds,
          ),
          curve: animationCurve ?? Curves.elasticOut,
        ),
        FadeEffect(
          duration: animationDuration,
          begin: 0,
          end: 1,
        ),
        if (autoDismiss)
          SlideEffect(
            delay: snackbarDuration,
            duration: const Duration(milliseconds: 500),
            curve: animationCurve ?? Curves.easeInOut,
            begin: Offset.zero,
            end: Offset(
              0,
              toastPosition == ToastPosition.bottom ? 2 : -2,
            ),
          ),
      ],
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.up,
        onDismissed: (direction) {
          onRemove();
        },
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final positionedKey = useMemoized(() => GlobalKey());

    return AnimatedPositioned(
      duration: Duration(
        milliseconds: animationDuration.inMilliseconds,
      ),
      key: positionedKey,
      curve: Curves.easeOutBack,
      top: toastPosition == ToastPosition.top
          ? getPosition() + 55
          : null,
      bottom: toastPosition == ToastPosition.bottom
          ? getPosition() + 60
          : null,
      left: 0,
      right: 0,
      child: Material(
        color: AppColors.transparentColor,
        child: AnimatedScale(
          duration: animationDuration,
          curve: Curves.bounceOut,
          scale: getPosition() == 0 ? 1 : getscaleFactor(),
          child: _getChildBasedOnDismiss(child),
        ),
      ),
    );
  }
}
