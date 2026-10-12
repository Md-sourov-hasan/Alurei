import 'package:alurei/src/imports/imports.dart';

class _NoteModel {
  _NoteModel({
    required this.id,
    required this.text,
    required this.authorName,
    required this.authorRole,
    required this.timestamp,
  });

  final String id;
  final String text;
  final String authorName;
  final String authorRole;
  final String timestamp;
}

class CareInsightsCaregiverNotesSection extends HookWidget {
  const CareInsightsCaregiverNotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = useState([
      _NoteModel(
        id: '1',
        text: 'Eve prefers reading before bedtime.',
        authorName: 'Monica',
        authorRole: 'Parent',
        timestamp: 'Today, 10:24 AM',
      ),
      _NoteModel(
        id: '2',
        text: 'Eve prefers reading before bedtime.',
        authorName: 'Monica',
        authorRole: 'Sibling',
        timestamp: 'Today, 10:24 AM',
      ),
    ]);
    final textController = useTextEditingController();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFE6EEEE)),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          IconsaxPlusLinear.clipboard_text,
                          size: 22.w,
                          color: const Color(0xFF1E293B),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            LangKey.parentCare.caregiverNotes,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E293B),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.only(left: 30.w),
                      child: Text(
                        LangKey.parentCare.caregiverNotesSubtitle,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF64748B),
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: () {
                  showAppDialog(
                    child: Dialog(
                      backgroundColor: AppColors.whiteBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 24.h,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Describe Notes',
                                  style: GlobalTextStyles.interTextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: context.appColors.primaryText,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    Navigator.of(context, rootNavigator: true).pop();
                                  },
                                  child: Icon(
                                    Icons.close,
                                    size: 24.w,
                                    color: context.appColors.primaryText,
                                  ),
                                ),
                              ],
                            ),
                            20.verticalSpace,
                            TextField(
                              controller: textController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                hintText:
                                    'e:g: Eve prefers reading before bedtime.',
                                hintStyle: GlobalTextStyles.interTextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF64748B),
                                ),
                                contentPadding: EdgeInsets.all(16.w),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF8ED2C9),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF00897B),
                                  ),
                                ),
                              ),
                            ),
                            24.verticalSpace,
                            Row(
                              children: [
                                Expanded(
                                  child: AppButton(
                                    label: LangKey.parentToday.cancel,
                                    variant: ButtonVariant.outline,
                                    textColor: const Color(0xFF64748B),
                                    borderColor: const Color(0xFFE2E8F0),
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      Navigator.of(context, rootNavigator: true).pop();
                                    },
                                  ),
                                ),
                                16.horizontalSpace,
                                Expanded(
                                  child: AppButton(
                                    label: LangKey.parentToday.save,
                                    variant: ButtonVariant.primary,
                                    color: AppColors.secondaryTeal,
                                    onPressed: () {
                                      if (textController.text.trim().isNotEmpty) {
                                        notes.value = [
                                          ...notes.value,
                                          _NoteModel(
                                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                                            text: textController.text.trim(),
                                            authorName: 'You',
                                            authorRole: 'Parent',
                                            timestamp: 'Just now',
                                          ),
                                        ];
                                        textController.clear();
                                      }
                                      FocusScope.of(context).unfocus();
                                      Navigator.of(context, rootNavigator: true).pop();
                                      showGlobalToast(
                                          message: LangKey.parentCare.noteSavedSuccessfully);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF004D54),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        IconsaxPlusLinear.add,
                        size: 14.w,
                        color: AppColors.whiteColor,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        LangKey.parentCare.addNote,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          ...notes.value.map((note) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: _CaregiverNoteItem(
                  text: note.text,
                  authorName: note.authorName,
                  authorRole: note.authorRole,
                  timestamp: note.timestamp,
                  onDelete: () {
                    notes.value = notes.value.where((n) => n.id != note.id).toList();
                  },
                ),
              )),
        ],
      ),
    );
  }
}

class _CaregiverNoteItem extends StatelessWidget {
  const _CaregiverNoteItem({
    required this.text,
    required this.authorName,
    required this.authorRole,
    required this.timestamp,
    this.onDelete,
  });

  final String text;
  final String authorName;
  final String authorRole;
  final String timestamp;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F8),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '"$text"',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                SizedBox(height: 8.h),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '$authorName ($authorRole)',
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      TextSpan(
                        text: '  •  ',
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      TextSpan(
                        text: timestamp,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () {
              showAppDialog(
                child: Dialog(
                  backgroundColor: AppColors.whiteBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 28.h,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF2F2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            IconsaxPlusLinear.trash,
                            size: 24.w,
                            color: AppColors.deleteRed,
                          ),
                        ),
                        16.verticalSpace,
                        Text(
                          'Delete the item?',
                          textAlign: TextAlign.center,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: context.appColors.primaryText,
                          ),
                        ),
                        12.verticalSpace,
                        Text(
                          'Are you sure you want to delete this note?',
                          textAlign: TextAlign.center,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: context.appColors.secondaryText,
                            height: 1.4,
                          ),
                        ),
                        28.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                label: LangKey.parentToday.cancel,
                                variant: ButtonVariant.outline,
                                textColor: const Color(0xFF334155),
                                borderColor: AppColors.brandGrayBorder,
                                onPressed: () => Get.back(),
                              ),
                            ),
                            16.horizontalSpace,
                            Expanded(
                              child: AppButton(
                                label: LangKey.parentToday.delete,
                                variant: ButtonVariant.primary,
                                color: AppColors.deleteRed,
                                onPressed: () {
                                  Get.back();
                                  if (onDelete != null) {
                                    onDelete!();
                                  }
                                  showGlobalToast(message: LangKey.parentCare.noteDeleted);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Icon(
                IconsaxPlusLinear.trash,
                size: 20.w,
                color: const Color(0xFFEF4444),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
