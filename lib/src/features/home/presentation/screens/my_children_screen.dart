import 'package:alurei/src/imports/imports.dart';
import '../controllers/my_children_controller.dart';

class MyChildrenScreen extends StatelessWidget {
  const MyChildrenScreen({super.key});

  MyChildrenController get controller {
    if (!Get.isRegistered<MyChildrenController>()) {
      Get.put(MyChildrenController());
    }
    return Get.find<MyChildrenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title: LangKey.parentHome.myChildren,
        titleColor: AppColors.headerTextColor,
        showBackButton: true,
        showDivider: false,
        onPressed: () => Get.back<void>(),
      ),
      body: SafeArea(
        child: Obx(() {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            itemCount: controller.childrenList.length + 1,
            separatorBuilder: (context, index) => 16.verticalSpace,
            itemBuilder: (context, index) {
              if (index == controller.childrenList.length) {
                return _buildAddChildButton(context);
              }
              final child = controller.childrenList[index];
              return _buildChildCard(context, child);
            },
          );
        }),
      ),
    );
  }

  Widget _buildChildCard(BuildContext context, Map<String, dynamic> child) {
    return GestureDetector(
      onTap: () {
        Get.toNamed<dynamic>(AppRoutes.childProfile, arguments: child);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundImage: child['image'] != null
                  ? AssetImage(child['image'] as String)
                  : null,
              backgroundColor: AppColors.brandTealTrack,
            ),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    child['name'] ?? '',
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.headerTextColor,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    child['age'] ?? '',
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: context.appColors.secondaryText,
                    ),
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      _buildAssignedAvatars(child),
                      8.horizontalSpace,
                      Expanded(
                        child: Text(
                          '${LangKey.parentHome.assigned} ${child['assigned']}',
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor, // Teal color
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            8.horizontalSpace,
            Icon(
              IconsaxPlusLinear.arrow_right_3,
              color: context.appColors.secondaryText,
              size: 20.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignedAvatars(Map<String, dynamic> child) {
    return SizedBox(
      width: 36.w,
      height: 20.w,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: CircleAvatar(
              radius: 10.w,
              backgroundColor: AppColors.whiteColor,
              child: CircleAvatar(
                radius: 9.w,
                backgroundImage: child['caregiver1'] != null
                    ? AssetImage(child['caregiver1'] as String)
                    : null,
                backgroundColor: AppColors.brandTealTrack,
              ),
            ),
          ),
          Positioned(
            left: 12.w,
            child: CircleAvatar(
              radius: 10.w,
              backgroundColor: AppColors.whiteColor,
              child: CircleAvatar(
                radius: 9.w,
                backgroundImage: child['caregiver2'] != null
                    ? AssetImage(child['caregiver2'] as String)
                    : null,
                backgroundColor: AppColors.brandTealTrack,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddChildButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle add child
      },
      child: CustomPaint(
        painter: DottedBorderPainter(
          color: AppColors.primaryColor.withValues(alpha: 0.3),
          strokeWidth: 1.5,
          gap: 4,
          radius: 16.r,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                ),
                child: Icon(
                  Icons.add,
                  color: AppColors.primaryColor,
                  size: 20.w,
                ),
              ),
              12.verticalSpace,
              Text(
                LangKey.parentHome.addAnotherChild,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
