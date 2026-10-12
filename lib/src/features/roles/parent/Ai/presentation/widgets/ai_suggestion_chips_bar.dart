import 'package:alurei/src/imports/imports.dart';
import 'package:flutter/material.dart';

class AiSuggestionChipsBar extends StatelessWidget {
  const AiSuggestionChipsBar({
    super.key,
    required this.suggestions,
    required this.onSelectSuggestion,
  });

  final List<String> suggestions;
  final ValueChanged<String> onSelectSuggestion;

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) return const SizedBox.shrink();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Row(
        children: suggestions.map((text) {
          return Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(9999.r),
              child: InkWell(
                onTap: () => onSelectSuggestion(text),
                borderRadius: BorderRadius.circular(9999.r),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 9.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7EEEF),
                    borderRadius: BorderRadius.circular(9999.r),
                    border: Border.all(color: const Color(0xFFFAFAFA)),
                  ),
                  child: Text(
                    text,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF4D5761),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      height: 20 / 14,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
