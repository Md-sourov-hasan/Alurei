import 'package:alurei/src/imports/imports.dart';

class RelationshipBottomSheet extends StatefulWidget {
  const RelationshipBottomSheet({super.key, required this.initialValue});

  final String initialValue;

  @override
  State<RelationshipBottomSheet> createState() =>
      _RelationshipBottomSheetState();
}

class _RelationshipBottomSheetState extends State<RelationshipBottomSheet> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final options = [
      LangKey.editProfile.father,
      LangKey.editProfile.mother,
      LangKey.editProfile.guardian,
      LangKey.editProfile.sibling,
      LangKey.editProfile.grandfather,
      LangKey.editProfile.grandmother,
      LangKey.editProfile.uncle,
      LangKey.editProfile.aunt,
      LangKey.editProfile.relative,
    ];

    return Container(
      decoration: BoxDecoration(
        color: context.appColors.primaryBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 24.h,
        bottom: context.safeArea.bottom + 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: context.colors.outlineVariant,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(height: 24.h),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: options.map((option) {
                  final isSelected = _selectedValue == option;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedValue = option;
                      });
                      Get.back<String>(result: option);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? context.colors.primary
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? context.colors.primary
                              : AppColors.brandGrayBorder,
                        ),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            option,
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : context.appColors.secondaryText,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                          Container(
                            width: 24.w,
                            height: 24.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.brandGrayBorder,
                                width: isSelected ? 4.w : 1.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
