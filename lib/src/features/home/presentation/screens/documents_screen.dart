import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/parent_document_data.dart';
import '../controllers/documents_controller.dart';
import '../widgets/documents_widgets.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DocumentsController>();
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: context.appColors.elevatedBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: Get.back<void>,
          icon: Icon(
            IconsaxPlusLinear.arrow_left,
            size: 20.sp,
            color: context.colors.primary,
          ),
        ),
        centerTitle: true,
        title: Text(
          LangKey.parentHome.documents,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 24.sp,
            height: 32 / 24,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          ),
        ),
      ),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 32.h),
          children: [
            DocumentsTabs(
              selected: controller.selectedTab.value,
              onSelected: (tab) => controller.tab = tab,
            ),
            SizedBox(height: 32.h),
            if (controller.selectedTab.value == ParentDocumentsTab.mine)
              DocumentCategoryCard(
                title: LangKey.parentHome.myDocuments,
                documents: controller.myDocuments,
                allowUpload: true,
                onUpload: controller.uploadDocument,
                onView: controller.viewDocument,
                onDownload: controller.downloadDocument,
              )
            else ...[
              NannyDocumentSelector(
                nannies: controller.nannyDocumentGroups,
                selectedIndex: controller.selectedNannyIndex.value,
                onSelected: (index) => controller.nannyIndex = index,
              ),
              SizedBox(height: 24.h),
              DocumentCategoryCard(
                title: '${controller.selectedNanny.name.split(' ').first}'
                    '${LangKey.parentHome.apostropheDocuments}',
                documents: controller.selectedNanny.documents,
                onUpload: controller.uploadDocument,
                onView: controller.viewDocument,
                onDownload: controller.downloadDocument,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
