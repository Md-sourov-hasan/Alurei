import 'package:alurei/src/imports/imports.dart';

class CareInsightsFavoriteItemsCard extends StatelessWidget {
  const CareInsightsFavoriteItemsCard({
    super.key,
    required this.sectionTitle,
    this.sectionIcon,
    this.sectionSvgPath,
    required this.items,
  });

  final String sectionTitle;
  final IconData? sectionIcon;
  final String? sectionSvgPath;
  final List<Map<String, String>> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (sectionSvgPath != null)
              SvgPicture.asset(
                sectionSvgPath!,
                width: 18.w,
                height: 18.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF004D54),
                  BlendMode.srcIn,
                ),
              )
            else if (sectionIcon != null)
              Icon(sectionIcon, size: 18.w, color: const Color(0xFF004D54)),
            SizedBox(width: 8.w),
            Text(
              sectionTitle,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF003D45),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: const Color(0xFFE6EEEE)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          child: Column(
            children: List.generate(items.length, (index) {
              final item = items[index];
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: SizedBox(
                        width: 44.w,
                        height: 44.w,
                        child: Image.asset(item['image']!, fit: BoxFit.cover),
                      ),
                    ),
                    title: Text(
                      item['title']!,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF003D45),
                      ),
                    ),
                    subtitle: Text(
                      item['subtitle']!,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF6C7E80),
                      ),
                    ),
                    trailing: Icon(
                      IconsaxPlusLinear.arrow_right_3,
                      size: 16.w,
                      color: const Color(0xFF6C7E80),
                    ),
                  ),
                  if (index < items.length - 1)
                    Divider(height: 1.h, color: const Color(0xFFEEF4F4)),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
