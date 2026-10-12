import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/parent_today_data.dart';

class ParentRoutineDetailSheet extends StatelessWidget {
  const ParentRoutineDetailSheet({
    super.key,
    required this.data,
  });

  final ParentRoutineDetailSheetData data;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.88,
      ),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 28.h + bottomInset),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36.w,
                height: 4.h,
                decoration: const BoxDecoration(
                  color: AppColors.neutral300,
                  borderRadius: AppBorders.full,
                ),
              ),
            ),
            SizedBox(height: 14.h),
            _RoutineDetailHero(data: data),
            SizedBox(height: 24.h),
            _ProofStrip(items: data.proofs),
            SizedBox(height: 20.h),
            _FeedbackPanel(data: data),
            SizedBox(height: 16.h),
            _CompletedBanner(completedAt: data.completedAt),
          ],
        ),
      ),
    );
  }
}

class ParentRoutineDetailSheetData {
  const ParentRoutineDetailSheetData({
    required this.item,
    required this.title,
    required this.description,
    required this.typeLabel,
    required this.icon,
    required this.heroColor,
    required this.completionLabel,
    required this.completionColor,
    required this.completionSurface,
    required this.proofs,
    required this.submittedAt,
    required this.completedAt,
    required this.nannyNote,
  });

  final ParentRoutineItem item;
  final String title;
  final String description;
  final String typeLabel;
  final IconData icon;
  final Color heroColor;
  final String completionLabel;
  final Color completionColor;
  final Color completionSurface;
  final List<RoutineProofItem> proofs;
  final String submittedAt;
  final String completedAt;
  final String nannyNote;

  factory ParentRoutineDetailSheetData.fromItem(ParentRoutineItem item) {
    return switch (item.kind) {
      ParentRoutineKind.breakfast => ParentRoutineDetailSheetData(
          item: item,
          title: _textOrFallback(item.title, LangKey.parentToday.breakfast),
          description: _textOrFallback(
            item.description,
            LangKey.parentToday.breakfastDescription,
          ),
          typeLabel: LangKey.parentToday.meal,
          icon: IconsaxPlusBold.reserve,
          heroColor: AppColors.routineDetailBreakfastSurface,
          completionLabel: LangKey.parentToday.fullPlate,
          completionColor: AppColors.supportingGreen,
          completionSurface: AppColors.supportingGreenShade,
          proofs: [
            RoutineProofItem(
              imageUrl: AppAssets.recipeBlueberryOatPorridge,
              title: LangKey.parentToday.breakfastProofTitle,
              capturedAt: LangKey.parentToday.defaultProofTime,
            ),
          ],
          submittedAt: LangKey.parentToday.defaultSubmittedTime,
          completedAt: LangKey.parentToday.defaultCompletedTime,
          nannyNote: LangKey.parentToday.breakfastNannyNote,
        ),
      ParentRoutineKind.outdoor => ParentRoutineDetailSheetData(
          item: item,
          title: _textOrFallback(item.title, LangKey.parentToday.outdoorPlay),
          description: _textOrFallback(
            item.description,
            LangKey.parentToday.outdoorPlayDescription,
          ),
          typeLabel: LangKey.parentToday.activity,
          icon: IconsaxPlusBold.tree,
          heroColor: AppColors.routineDetailOutdoorSurface,
          completionLabel: LangKey.parentToday.partially,
          completionColor: AppColors.warning500,
          completionSurface: AppColors.supportingOrangeShade,
          proofs: [
            RoutineProofItem(
              imageUrl: AppAssets.activityPlayground,
              title: LangKey.parentToday.outdoorProofTitle,
              capturedAt: LangKey.parentToday.defaultProofTime,
            ),
          ],
          submittedAt: LangKey.parentToday.defaultSubmittedTime,
          completedAt: LangKey.parentToday.defaultCompletedTime,
          nannyNote: LangKey.parentToday.outdoorNannyNote,
        ),
      ParentRoutineKind.study => ParentRoutineDetailSheetData(
          item: item,
          title: _textOrFallback(item.title, LangKey.parentToday.studyTime),
          description: _textOrFallback(
            item.description,
            LangKey.parentToday.studyTimeDescription,
          ),
          typeLabel: LangKey.parentToday.study,
          icon: IconsaxPlusBold.teacher,
          heroColor: AppColors.routineDetailStudySurface,
          completionLabel: LangKey.parentToday.minimal,
          completionColor: AppColors.supportingRed,
          completionSurface: AppColors.supportingRedShade,
          proofs: [
            RoutineProofItem(
              imageUrl: AppAssets.monikaChild3,
              title: LangKey.parentToday.studyProofTitle,
              capturedAt: LangKey.parentToday.defaultProofTime,
            ),
          ],
          submittedAt: LangKey.parentToday.defaultSubmittedTime,
          completedAt: LangKey.parentToday.defaultCompletedTime,
          nannyNote: LangKey.parentToday.studyNannyNote,
        ),
      _ => ParentRoutineDetailSheetData(
          item: item,
          title: _textOrFallback(item.title, LangKey.parentToday.task),
          description: _textOrFallback(item.description, ''),
          typeLabel:
              _textOrFallback(item.itemTypeLabel, LangKey.parentToday.task),
          icon: IconsaxPlusBold.note_2,
          heroColor: AppColors.routineDetailStudySurface,
          completionLabel: LangKey.parentToday.fullPlate,
          completionColor: AppColors.supportingGreen,
          completionSurface: AppColors.supportingGreenShade,
          proofs: const [],
          submittedAt: LangKey.parentToday.defaultSubmittedTime,
          completedAt: LangKey.parentToday.defaultCompletedTime,
          nannyNote: LangKey.parentToday.breakfastNannyNote,
        ),
    };
  }

  String get timeRange {
    final start = _formatRoutineClock(item.startTime);
    final end = _formatRoutineClock(item.endTime);
    if (start.isEmpty) return '';
    if (end.isEmpty) return start;
    return '$start - $end';
  }
}

class RoutineProofItem {
  const RoutineProofItem({
    required this.imageUrl,
    required this.title,
    required this.capturedAt,
  });

  final String imageUrl;
  final String title;
  final String capturedAt;
}

class _RoutineDetailHero extends StatelessWidget {
  const _RoutineDetailHero({required this.data});

  final ParentRoutineDetailSheetData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(14.w, 16.h, 14.w, 18.h),
      decoration: BoxDecoration(
        color: data.heroColor,
        borderRadius: AppBorders.lg,
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            top: 0,
            end: 0,
            child: _CloseButton(onPressed: Get.back<void>),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(end: 44.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(data.icon, size: 30.sp, color: AppColors.primaryColor),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        data.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 20.sp,
                          height: 30 / 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.headerTextColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    _TagPill(label: data.typeLabel),
                  ],
                ),
                if (data.description.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    data.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 12.sp,
                      height: 18 / 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ],
                SizedBox(height: 18.h),
                Wrap(
                  spacing: 12.w,
                  runSpacing: 8.h,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (data.timeRange.isNotEmpty)
                      Text(
                        data.timeRange,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 12.sp,
                          height: 18 / 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackTextColor,
                        ),
                      ),
                    _DonePill(text: data.completedAt),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProofStrip extends StatelessWidget {
  const _ProofStrip({required this.items});

  final List<RoutineProofItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              IconsaxPlusLinear.gallery,
              size: 22.sp,
              color: AppColors.primaryColor,
            ),
            SizedBox(width: 8.w),
            Text(
              LangKey.parentToday.proofItemCount
                  .replaceAll('{}', items.length.toString()),
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                height: 20 / 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 104.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final proof = items[index];
              final heroTag = 'routine-proof-${proof.imageUrl}-$index';
              return _ProofThumbnail(
                proof: proof,
                index: index,
                total: items.length,
                heroTag: heroTag,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ProofThumbnail extends StatelessWidget {
  const _ProofThumbnail({
    required this.proof,
    required this.index,
    required this.total,
    required this.heroTag,
  });

  final RoutineProofItem proof;
  final int index;
  final int total;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => FullScreenImageViewer.open<void>(
        imageUrl: proof.imageUrl,
        title: proof.title,
        subtitle: proof.capturedAt,
        index: index + 1,
        total: total,
        heroTag: heroTag,
      ),
      borderRadius: AppBorders.md,
      child: Hero(
        tag: heroTag,
        child: ClipRRect(
          borderRadius: AppBorders.md,
          child: SizedBox(
            width: 98.w,
            height: 104.h,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CommonImage(imageUrl: proof.imageUrl, fit: BoxFit.cover),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.transparentColor,
                          AppColors.blackColor.withValues(alpha: 0.55),
                        ],
                      ),
                    ),
                    child: Text(
                      proof.capturedAt,
                      textAlign: TextAlign.center,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 8.sp,
                        height: 12 / 8,
                        fontWeight: FontWeight.w700,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeedbackPanel extends StatelessWidget {
  const _FeedbackPanel({required this.data});

  final ParentRoutineDetailSheetData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        border: Border.all(color: AppColors.neutral200),
        borderRadius: AppBorders.xl,
        boxShadow: AppShadows.subtle,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 24.w,
                height: 24.w,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  IconsaxPlusBold.star,
                  size: 14.sp,
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                LangKey.parentToday.feedback,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 16.sp,
                  height: 24 / 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
              const Spacer(),
              Text(
                LangKey.parentToday.submittedAt
                    .replaceAll('{}', data.submittedAt),
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 12.sp,
                  height: 18 / 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.disabledTextColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _MetricTile(
                  label: LangKey.parentToday.enjoyment,
                  emoji: '😊',
                  value: LangKey.parentToday.lovedIt,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: _MetricTile(
                  label: LangKey.parentToday.childMood,
                  emoji: '😊',
                  value: LangKey.parentToday.happy,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _CompletionRow(data: data),
          SizedBox(height: 14.h),
          _NannyNote(note: data.nannyNote),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.emoji,
    required this.value,
  });

  final String label;
  final String emoji;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 82.h),
      padding: EdgeInsets.all(12.w),
      decoration: const BoxDecoration(
        color: AppColors.routineDetailFeedbackSurface,
        borderRadius: AppBorders.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              height: 18 / 12,
              fontWeight: FontWeight.w500,
              color: AppColors.supportingGreen,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            emoji,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 24.sp,
              height: 32 / 24,
              fontWeight: FontWeight.w400,
              color: AppColors.blackTextColor,
            ),
          ),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              height: 18 / 12,
              fontWeight: FontWeight.w600,
              color: AppColors.supportingGreen,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompletionRow extends StatelessWidget {
  const _CompletionRow({required this.data});

  final ParentRoutineDetailSheetData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.appColors.primaryBackground,
        border: Border.all(color: AppColors.neutral200),
        borderRadius: AppBorders.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              LangKey.parentToday.completion,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                height: 20 / 14,
                fontWeight: FontWeight.w400,
                color: AppColors.disabledTextColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 9.h),
            decoration: BoxDecoration(
              color: data.completionSurface,
              border: Border.all(color: data.completionColor, width: 1.5.w),
              borderRadius: AppBorders.lg,
            ),
            child: Text(
              data.completionLabel,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 12.sp,
                height: 18 / 12,
                fontWeight: FontWeight.w600,
                color: data.completionColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NannyNote extends StatelessWidget {
  const _NannyNote({required this.note});

  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.routineDetailNoteSurface,
        border: Border.all(color: AppColors.routineDetailNoteBorder),
        borderRadius: AppBorders.lg,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            IconsaxPlusLinear.message_text,
            size: 24.sp,
            color: AppColors.primaryColor,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKey.parentToday.nannyNote,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    height: 20 / 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  note,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    height: 18 / 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryTextColor,
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

class _CompletedBanner extends StatelessWidget {
  const _CompletedBanner({required this.completedAt});

  final String completedAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: const BoxDecoration(
        color: AppColors.routineDetailCompleteSurface,
        borderRadius: AppBorders.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            IconsaxPlusLinear.tick_circle,
            size: 20.sp,
            color: AppColors.groceryGreen,
          ),
          SizedBox(width: 8.w),
          Text(
            LangKey.parentToday.completedAt.replaceAll('{}', completedAt),
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              height: 20 / 14,
              fontWeight: FontWeight.w400,
              color: AppColors.groceryGreen,
            ),
          ),
        ],
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteColor,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 36.w,
          height: 36.w,
          child: Icon(
            IconsaxPlusLinear.close_circle,
            size: 20.sp,
            color: AppColors.neutral700,
          ),
        ),
      ),
    );
  }
}

class _TagPill extends StatelessWidget {
  const _TagPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: AppBorders.full,
      ),
      child: Text(
        label,
        style: GlobalTextStyles.interTextStyle(
          fontSize: 12.sp,
          height: 18 / 12,
          fontWeight: FontWeight.w600,
          color: AppColors.groceryGreen,
        ),
      ),
    );
  }
}

class _DonePill extends StatelessWidget {
  const _DonePill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.groceryGreen.withValues(alpha: 0.1),
        borderRadius: AppBorders.full,
      ),
      child: Text(
        LangKey.parentToday.doneAt.replaceAll('{}', text),
        style: GlobalTextStyles.interTextStyle(
          fontSize: 12.sp,
          height: 18 / 12,
          fontWeight: FontWeight.w700,
          color: AppColors.groceryStockGreen,
        ),
      ),
    );
  }
}

String _textOrFallback(String? value, String fallback) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? fallback : trimmed;
}

String _formatRoutineClock(String? value) {
  final minutes = _parseMinutes(value);
  if (minutes == null) return value ?? '';
  final hour = minutes ~/ 60;
  final minute = minutes.remainder(60);
  final period = hour >= 12 ? 'PM' : 'AM';
  final displayHour = hour % 12 == 0 ? 12 : hour % 12;
  return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
}

int? _parseMinutes(String? value) {
  if (value == null) return null;
  final parts = value.split(':');
  if (parts.length != 2) return null;
  final hour = int.tryParse(parts[0]);
  final minute = int.tryParse(parts[1]);
  if (hour == null || minute == null || hour > 23 || minute > 59) return null;
  return hour * 60 + minute;
}
