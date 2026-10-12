import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/parent_document_data.dart';

class DocumentsTabs extends StatelessWidget {
  const DocumentsTabs({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final ParentDocumentsTab selected;
  final ValueChanged<ParentDocumentsTab> onSelected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: context.appColors.bottomNavBorder),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: ParentDocumentsTab.values.map((tab) {
          final isSelected = tab == selected;
          return InkWell(
            onTap: () => onSelected(tab),
            child: Container(
              padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 12.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected
                        ? context.colors.primary
                        : AppColors.transparentColor,
                    width: 2.h,
                  ),
                ),
              ),
              child: Text(
                switch (tab) {
                  ParentDocumentsTab.mine => LangKey.parentHome.myDocuments,
                  ParentDocumentsTab.nanny =>
                    LangKey.parentHome.nannysDocuments,
                },
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 18.sp,
                  height: 28 / 18,
                  fontWeight: FontWeight.w600,
                  color: context.appColors.primaryText,
                ),
              ),
            ),
          );
        }).toList(growable: false),
      ),
    );
  }
}

class NannyDocumentSelector extends StatelessWidget {
  const NannyDocumentSelector({
    super.key,
    required this.nannies,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<ParentNannyDocumentGroup> nannies;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.brandGrayBorder)),
        ),
        child: Row(
          children: [
            for (var index = 0; index < nannies.length; index++)
              InkWell(
                onTap: () => onSelected(index),
                child: Container(
                  margin: EdgeInsetsDirectional.only(end: 16.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: selectedIndex == index
                            ? context.colors.primary
                            : AppColors.transparentColor,
                        width: 2.h,
                      ),
                    ),
                  ),
                  child: Text(
                    nannies[index].name,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      height: 20 / 14,
                      fontWeight: selectedIndex == index
                          ? FontWeight.w700
                          : FontWeight.w400,
                      color: selectedIndex == index
                          ? context.colors.primary
                          : context.appColors.secondaryText,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DocumentCategoryCard extends StatelessWidget {
  const DocumentCategoryCard({
    super.key,
    required this.title,
    required this.documents,
    required this.onUpload,
    required this.onView,
    required this.onDownload,
    this.allowUpload = false,
  });

  final String title;
  final List<ParentDocumentItem> documents;
  final ValueChanged<ParentDocumentItem> onUpload;
  final ValueChanged<ParentDocumentItem> onView;
  final ValueChanged<ParentDocumentItem> onDownload;
  final bool allowUpload;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: AppBorders.lg,
        boxShadow: const [
          BoxShadow(
            color: AppColors.black04,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: AppBorders.md,
                ),
                child: Icon(
                  IconsaxPlusLinear.document_text,
                  size: 24.sp,
                  color: context.colors.onPrimary,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 18.sp,
                    height: 28 / 18,
                    fontWeight: FontWeight.w600,
                    color: context.appColors.primaryText,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          for (var index = 0; index < documents.length; index++) ...[
            DocumentListItem(
              document: documents[index],
              allowUpload: allowUpload,
              onUpload: () => onUpload(documents[index]),
              onView: () => onView(documents[index]),
              onDownload: () => onDownload(documents[index]),
            ),
            if (index != documents.length - 1) SizedBox(height: 16.h),
          ],
        ],
      ),
    );
  }
}

class DocumentListItem extends StatelessWidget {
  const DocumentListItem({
    super.key,
    required this.document,
    required this.allowUpload,
    required this.onUpload,
    required this.onView,
    required this.onDownload,
  });

  final ParentDocumentItem document;
  final bool allowUpload;
  final VoidCallback onUpload;
  final VoidCallback onView;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(17.w),
      decoration: BoxDecoration(
        color: AppColors.documentItemSurface,
        border: Border.all(color: AppColors.documentItemBorder),
        borderRadius: AppBorders.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 16.sp,
                    height: 24 / 16,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.primaryText,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${document.status} • ${document.dateLabel}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    height: 18 / 12,
                    color: context.appColors.mutedText,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!allowUpload || document.file != null)
                _DocumentIconButton(
                  icon: IconsaxPlusLinear.eye,
                  isPrimary: false,
                  onTap: onView,
                ),
              if (!allowUpload || document.file != null) SizedBox(width: 8.w),
              _DocumentIconButton(
                icon: allowUpload && document.file == null
                    ? IconsaxPlusLinear.export
                    : IconsaxPlusLinear.document_download,
                isPrimary: true,
                onTap: allowUpload && document.file == null
                    ? onUpload
                    : onDownload,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DocumentIconButton extends StatelessWidget {
  const _DocumentIconButton({
    required this.icon,
    required this.isPrimary,
    required this.onTap,
  });

  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppBorders.full,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color:
              isPrimary ? context.colors.primary : AppColors.transparentColor,
          shape: BoxShape.circle,
          border: isPrimary ? null : Border.all(color: context.colors.primary),
        ),
        child: Icon(
          icon,
          size: 18.sp,
          color: isPrimary ? context.colors.onPrimary : context.colors.primary,
        ),
      ),
    );
  }
}
