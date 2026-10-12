import 'dart:ui';

import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/bedtime_story_data.dart';

class BedtimeStoryHeroCard extends StatelessWidget {
  const BedtimeStoryHeroCard({
    super.key,
    required this.coverAsset,
    required this.title,
    required this.heroLabel,
  });

  final String coverAsset;
  final String title;
  final String heroLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380.h,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: AppBorders.xl,
        boxShadow: AppShadows.card,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            coverAsset,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => ColoredBox(
              color: AppColors.brandTealLight,
              child: Icon(
                IconsaxPlusBold.book_1,
                size: 72.sp,
                color: context.colors.primary,
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.transparentColor,
                  AppColors.black26,
                  AppColors.blackColor.withValues(alpha: 0.8),
                ],
                stops: const [0, 0.5, 1],
              ),
            ),
          ),
          PositionedDirectional(
            start: 24.w,
            end: 24.w,
            bottom: 24.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 24.sp,
                    height: 32 / 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.neutral100,
                  ),
                ),
                SizedBox(height: 8.h),
                ClipRRect(
                  borderRadius: AppBorders.lg,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor.withValues(alpha: 0.2),
                        borderRadius: AppBorders.lg,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            IconsaxPlusBold.star,
                            size: 14.sp,
                            color: AppColors.whiteColor,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            heroLabel,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 12.sp,
                              height: 18 / 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BedtimeStorySectionHeader extends StatelessWidget {
  const BedtimeStorySectionHeader({
    super.key,
    required this.title,
    this.action,
  });

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 20.sp,
              height: 30 / 20,
              fontWeight: FontWeight.w600,
              color: context.appColors.secondaryText,
            ),
          ),
        ),
        if (action != null) action!,
      ],
    );
  }
}

class BedtimeStoryAudioCard extends StatelessWidget {
  const BedtimeStoryAudioCard({
    super.key,
    required this.track,
    required this.position,
    required this.duration,
    required this.playing,
    required this.onPlayPause,
    required this.onSeek,
    this.onDelete,
    this.title,
    this.backgroundColor,
  });

  final BedtimeStoryAudio track;
  final Duration position;
  final Duration duration;
  final bool playing;
  final VoidCallback onPlayPause;
  final ValueChanged<double> onSeek;
  final VoidCallback? onDelete;
  final String? title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final resolvedDuration =
        duration.inSeconds <= 0 ? const Duration(seconds: 1) : duration;
    final clampedPosition =
        position > resolvedDuration ? resolvedDuration : position;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colors.primary,
        borderRadius: AppBorders.lg,
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            top: -24.h,
            end: -24.w,
            child: Icon(
              IconsaxPlusBold.music,
              size: 80.sp,
              color: AppColors.whiteColor.withValues(alpha: 0.1),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title ?? track.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 18.sp,
                        height: 28 / 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  if (onDelete != null)
                    InkWell(
                      onTap: onDelete,
                      borderRadius: AppBorders.md,
                      child: Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Icon(
                          IconsaxPlusLinear.trash,
                          size: 18.sp,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  _AudioPlayButton(
                    playing: playing,
                    onPressed: onPlayPause,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      children: [
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 6.h,
                            activeTrackColor: AppColors.whiteColor,
                            inactiveTrackColor:
                                AppColors.whiteColor.withValues(alpha: 0.2),
                            thumbColor: AppColors.whiteColor,
                            overlayColor:
                                AppColors.whiteColor.withValues(alpha: 0.12),
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 6.r,
                            ),
                            overlayShape: RoundSliderOverlayShape(
                              overlayRadius: 14.r,
                            ),
                          ),
                          child: Slider(
                            min: 0,
                            max: resolvedDuration.inSeconds.toDouble(),
                            value: clampedPosition.inSeconds
                                .clamp(0, resolvedDuration.inSeconds)
                                .toDouble(),
                            onChanged: onSeek,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _AudioTimeText(clampedPosition),
                            _AudioTimeText(resolvedDuration),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BedtimeStoryTranscriptPanel extends StatelessWidget {
  const BedtimeStoryTranscriptPanel({
    super.key,
    required this.expanded,
    required this.transcript,
    required this.onToggle,
  });

  final bool expanded;
  final String transcript;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.appColors.primaryBackground,
        borderRadius: AppBorders.md,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: AppBorders.md,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Icon(
                    IconsaxPlusLinear.document_text,
                    size: 18.sp,
                    color: context.colors.primary,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      LangKey.parentToday.viewTranscriptPreview,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 16.sp,
                        height: 24 / 16,
                        fontWeight: FontWeight.w500,
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    duration: AppDurations.fast,
                    turns: expanded ? 0.5 : 0,
                    child: Icon(
                      IconsaxPlusLinear.arrow_down,
                      size: 18.sp,
                      color: context.colors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: Text(
                transcript,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  height: 20 / 14,
                  fontWeight: FontWeight.w400,
                  color: context.appColors.mutedText,
                ).copyWith(fontStyle: FontStyle.italic),
              ),
            ),
            crossFadeState:
                expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: AppDurations.normal,
          ),
        ],
      ),
    );
  }
}

class BedtimeStoryInfoNote extends StatelessWidget {
  const BedtimeStoryInfoNote({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: const BoxDecoration(
        color: AppColors.bedtimeStoryInfoBackground,
        borderRadius: AppBorders.lg,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            IconsaxPlusBold.magic_star,
            size: 22.sp,
            color: context.colors.primary,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 16.sp,
                height: 24 / 16,
                fontWeight: FontWeight.w400,
                color: context.appColors.secondaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BedtimeStoryRecorderPanel extends StatelessWidget {
  const BedtimeStoryRecorderPanel({
    super.key,
    required this.recording,
    required this.paused,
    required this.duration,
    required this.level,
    required this.onRecordToggle,
    required this.onCancel,
    required this.onSave,
  });

  final bool recording;
  final bool paused;
  final Duration duration;
  final double level;
  final VoidCallback onRecordToggle;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: const BoxDecoration(
        color: AppColors.bedtimeStoryRecorderBackground,
        borderRadius: AppBorders.lg,
      ),
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: AppColors.bedtimeStoryDashedBorder,
          radius: 16.r,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 34.h),
          child: Column(
            children: [
              Text(
                recording
                    ? paused
                        ? LangKey.parentToday.recordingPaused
                        : LangKey.parentToday.recordingStory
                    : LangKey.parentToday.readyToRecord,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 18.sp,
                  height: 28 / 18,
                  fontWeight: FontWeight.w500,
                  color: context.appColors.primaryText,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                recording
                    ? formatBedtimeStoryDuration(duration)
                    : LangKey.parentToday.recordInstruction,
                textAlign: TextAlign.center,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  height: 20 / 14,
                  fontWeight: FontWeight.w400,
                  color: context.appColors.mutedText,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _RoundOutlineButton(
                    icon: IconsaxPlusLinear.close_circle,
                    onTap: recording ? onCancel : null,
                  ),
                  SizedBox(width: 24.w),

                  // Start recording / pause / resume button
                  GestureDetector(
                    onTap: onRecordToggle,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: AnimatedContainer(
                        duration: AppDurations.fast,
                        width: 64.w,
                        height: 64.w,
                        decoration: BoxDecoration(
                          color: recording
                              ? context.colors.primary
                              : context.colors.primary.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          recording && !paused
                              ? IconsaxPlusBold.pause
                              : recording && paused
                                  ? IconsaxPlusBold.play
                                  : IconsaxPlusBold.microphone_2,
                          size: 26.sp,
                          color: recording
                              ? context.colors.onPrimary
                              : context.colors.primary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 24.w),

                  // Record save buttons
                  _RoundOutlineButton(
                    icon: IconsaxPlusLinear.tick_circle,
                    onTap: recording ? onSave : null,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              BedtimeStoryWaveform(active: recording && !paused, level: level),
            ],
          ),
        ),
      ),
    );
  }
}

class BedtimeStoryWaveform extends HookWidget {
  const BedtimeStoryWaveform({
    super.key,
    required this.active,
    required this.level,
  });

  final bool active;
  final double level;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 700),
    );
    useEffect(() {
      if (active) {
        controller.repeat();
      } else {
        controller.stop();
        controller.value = 0;
      }
      return null;
    }, [active, controller]);

    final heights = [12.0, 20.0, 32.0, 16.0, 24.0, 8.0, 20.0];
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return SizedBox(
          height: 32.h,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var index = 0; index < heights.length; index++)
                AnimatedContainer(
                  duration: AppDurations.fast,
                  margin: EdgeInsetsDirectional.only(end: index == 6 ? 0 : 4.w),
                  width: 4.w,
                  height: _waveHeight(heights, index, controller.value).h,
                  decoration: BoxDecoration(
                    color: context.colors.primary,
                    borderRadius: AppBorders.full,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  double _waveHeight(List<double> heights, int index, double value) {
    if (!active) return heights[index];
    final phase = ((value * heights.length) + index).floor() % heights.length;
    final multiplier = 0.55 + (level.clamp(0.0, 1.0) * 0.7);
    return (heights[phase] * multiplier).clamp(8.0, 32.0);
  }
}

class _AudioPlayButton extends StatelessWidget {
  const _AudioPlayButton({
    required this.playing,
    required this.onPressed,
  });

  final bool playing;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: AppBorders.md,
      child: Container(
        width: 56.w,
        height: 56.w,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: AppBorders.md,
          boxShadow: AppShadows.subtle,
        ),
        child: Icon(
          playing ? IconsaxPlusBold.pause : IconsaxPlusBold.play,
          size: 22.sp,
          color: context.colors.primary,
        ),
      ),
    );
  }
}

class _AudioTimeText extends StatelessWidget {
  const _AudioTimeText(this.duration);

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Text(
      formatBedtimeStoryDuration(duration),
      style: GlobalTextStyles.interTextStyle(
        fontSize: 12.sp,
        height: 18 / 12,
        fontWeight: FontWeight.w500,
        color: AppColors.whiteColor,
      ),
    );
  }
}

class _RoundOutlineButton extends StatelessWidget {
  const _RoundOutlineButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppBorders.full,
      child: Opacity(
        opacity: onTap == null ? 0.45 : 1,
        child: Container(
          width: 48.w,
          height: 48.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.bedtimeStoryDashedBorder),
          ),
          child: Icon(icon, size: 18.sp, color: context.colors.primary),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({
    required this.color,
    required this.radius,
  });

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final rect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rect);
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + 7),
          paint,
        );
        distance += 12;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}

String formatBedtimeStoryDuration(Duration duration) {
  final minutes = duration.inMinutes.remainder(60).toString();
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
