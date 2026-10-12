import 'dart:io';

import 'package:alurei/src/imports/imports.dart';

class FullScreenDocumentViewer extends StatelessWidget {
  const FullScreenDocumentViewer({
    super.key,
    required this.title,
    required this.status,
    required this.dateLabel,
    this.file,
  });

  final String title;
  final String status;
  final String dateLabel;
  final File? file;

  static Future<T?> open<T>({
    required String title,
    required String status,
    required String dateLabel,
    File? file,
  }) {
    return Get.to<T>(
          () => FullScreenDocumentViewer(
            title: title,
            status: status,
            dateLabel: dateLabel,
            file: file,
          ),
          fullscreenDialog: true,
        ) ??
        Future<T?>.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Stack(
          children: [
            PositionedDirectional(
              start: 24.w,
              top: 24.h,
              child: InkWell(
                onTap: Get.back<void>,
                borderRadius: AppBorders.full,
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor.withValues(alpha: 0.10),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    IconsaxPlusLinear.arrow_left,
                    size: 20.sp,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _DocumentPreview(
                  title: title,
                  status: status,
                  dateLabel: dateLabel,
                  file: file,
                ),
              ),
            ),
            PositionedDirectional(
              start: 16.w,
              end: 16.w,
              bottom: 48.h,
              child: TextButton.icon(
                onPressed: _download,
                icon: Icon(
                  IconsaxPlusLinear.document_download,
                  size: 32.sp,
                  color: AppColors.whiteColor,
                ),
                label: Text(
                  LangKey.parentHome.downloadDocument,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 16.sp,
                    height: 24 / 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _download() async {
    final source = file ?? await _fallbackFile();
    final result = await DocumentFileService.instance.saveToFileManager(
      source,
      fileName: title,
    );
    result.fold(
      (failure) => showGlobalToast(message: failure.message, status: 'error'),
      (savedFile) => showGlobalToast(
        message: '${LangKey.parentHome.documentDownloaded}: ${savedFile.path}',
      ),
    );
  }

  Future<File> _fallbackFile() async {
    final directory = await getTemporaryDirectory();
    final fallback = File('${directory.path}/${title.toLowerCase()}.pdf');
    if (await fallback.exists()) return fallback;
    await fallback.writeAsString('$title\n$status • $dateLabel\n');
    return fallback;
  }
}

class _DocumentPreview extends StatelessWidget {
  const _DocumentPreview({
    required this.title,
    required this.status,
    required this.dateLabel,
    this.file,
  });

  final String title;
  final String status;
  final String dateLabel;
  final File? file;

  @override
  Widget build(BuildContext context) {
    final path = file?.path.toLowerCase() ?? '';
    if (path.endsWith('.png') ||
        path.endsWith('.jpg') ||
        path.endsWith('.jpeg')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4.r),
        child: Image.file(
          file!,
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      );
    }

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: 500.h),
      margin: EdgeInsets.only(top: 36.h),
      padding: EdgeInsets.all(16.w),
      color: AppColors.whiteColor,
      child: Container(
        padding: EdgeInsets.fromLTRB(26.w, 34.h, 26.w, 24.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightInfoContainer, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 18.sp,
                height: 28 / 18,
                fontWeight: FontWeight.w700,
                color: AppColors.headingTextColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '$status • $dateLabel',
              style: GlobalTextStyles.interTextStyle(
                fontSize: 12.sp,
                height: 18 / 12,
                fontWeight: FontWeight.w600,
                color: AppColors.headingTextColor,
              ),
            ),
            SizedBox(height: 24.h),
            for (var index = 0; index < 8; index++) ...[
              Container(
                width: index.isEven ? double.infinity : 250.w,
                height: 8.h,
                color: AppColors.neutral200,
              ),
              SizedBox(height: 10.h),
            ],
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: Text(
                '1',
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 11.sp,
                  height: 16 / 11,
                  color: AppColors.blackTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
