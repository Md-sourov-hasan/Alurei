import 'package:alurei/src/imports/imports.dart';
import 'package:flutter/material.dart';

import '../controllers/parent_ai_controller.dart';

class AiHistoryDrawer extends StatelessWidget {
  const AiHistoryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ParentAiController>();

    return Drawer(
      width: 317.w,
      backgroundColor: const Color(0xFFF4F4F4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          bottomLeft: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          Container(
            color: const Color(0xFFF4F4F4),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: SafeArea(
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LangKey.parentAi.history,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF333333),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: SvgPicture.asset(
                      AppAssets.icCross,
                      width: 20.w,
                      height: 20.w,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final items = controller.historyItems.toList();
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final itemText = items[index];
                  return InkWell(
                    onTap: () {
                      controller.selectHistoryItem(itemText);
                      Navigator.of(context).pop();
                    },
                    borderRadius: BorderRadius.circular(8.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 12.h,
                      ),
                      child: Text(
                        itemText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF202939),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
