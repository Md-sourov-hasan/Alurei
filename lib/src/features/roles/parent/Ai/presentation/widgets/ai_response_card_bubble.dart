import 'package:alurei/src/imports/imports.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/parent_ai_message.dart';

class AiResponseCardBubble extends StatelessWidget {
  const AiResponseCardBubble({
    super.key,
    required this.message,
  });

  final ParentAiMessage message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.whiteBackgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.text,
              style: context.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF202939),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                height: 20 / 14,
              ),
            ),
            if (message.listItems.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Column(
                children: message.listItems.map((itemText) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 18.w,
                          height: 18.w,
                          margin: EdgeInsets.only(top: 1.h, right: 8.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.colors.primary.withOpacity(0.12),
                          ),
                          child: Icon(
                            IconsaxPlusLinear.tick_circle,
                            size: 14.sp,
                            color: context.colors.primary,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            itemText,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF202939),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              height: 20 / 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
            if (message.followUpQuestion != null) ...[
              SizedBox(height: 8.h),
              Text(
                message.followUpQuestion!,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF202939),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 20 / 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
