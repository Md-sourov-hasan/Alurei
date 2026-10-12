import 'package:alurei/src/imports/imports.dart';

class SelectChildItem {
  const SelectChildItem({
    required this.id,
    required this.name,
    required this.avatarAsset,
  });

  final String id;
  final String name;
  final String avatarAsset;
}

class SelectChildSheet extends HookWidget {
  const SelectChildSheet({
    super.key,
    required this.onGoToSchedule,
    this.initialChildren,
  });

  final ValueChanged<SelectChildItem> onGoToSchedule;
  final List<SelectChildItem>? initialChildren;

  static const List<SelectChildItem> _defaultChildren = [
    SelectChildItem(
      id: 'child-1',
      name: 'Monica Steve',
      avatarAsset: AppAssets.monicaChild1,
    ),
    SelectChildItem(
      id: 'child-2',
      name: 'Eve',
      avatarAsset: AppAssets.moniokaChild2,
    ),
    SelectChildItem(
      id: 'child-3',
      name: 'Rose',
      avatarAsset: AppAssets.monikaChild3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState<int>(0);
    final fetchedChildren = useState<List<SelectChildItem>>([]);
    final isLoading = useState<bool>(true);

    useEffect(() {
      if (initialChildren != null && initialChildren!.isNotEmpty) {
        fetchedChildren.value = initialChildren!;
        isLoading.value = false;
        return null;
      }

      ParentChildrenService.instance.getChildren().then((result) {
        result.fold(
          (failure) {
            fetchedChildren.value = _defaultChildren;
            isLoading.value = false;
          },
          (list) {
            if (list.isNotEmpty) {
              final mapped = list.map((json) {
                final id = json['id'] as String? ?? '';
                final name = json['name'] as String? ?? 'Child';
                final avatar = json['avatar'] as String?;
                final fallbackAvatar = id.hashCode.isEven
                    ? AppAssets.monicaChild1
                    : AppAssets.moniokaChild2;
                return SelectChildItem(
                  id: id,
                  name: name,
                  avatarAsset:
                      (avatar != null && avatar.isNotEmpty) ? avatar : fallbackAvatar,
                );
              }).toList();
              fetchedChildren.value = mapped;
            } else {
              fetchedChildren.value = _defaultChildren;
            }
            isLoading.value = false;
          },
        );
      });
      return null;
    }, []);

    final childrenList = isLoading.value
        ? _defaultChildren
        : (fetchedChildren.value.isEmpty
            ? _defaultChildren
            : fetchedChildren.value);

    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 32.h),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle + Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 24),
              Container(
                width: 48.w,
                height: 6.h,
                decoration: BoxDecoration(
                  color: context.theme.brightness == Brightness.dark
                      ? context.appColors.bottomNavBorder
                      : AppColors.neutral300,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
              GestureDetector(
                onTap: () => Get.back<void>(),
                child: Icon(
                  Icons.close,
                  size: 24.w,
                  color: context.appColors.mutedText,
                ),
              ),
            ],
          ),
          20.verticalSpace,

          // Modal Title
          Text(
            LangKey.parentKitchen.selectChild,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: context.appColors.strongText,
            ),
          ),
          4.verticalSpace,

          // Subtitle
          Text(
            LangKey.parentKitchen.whichChildIsThisFor,
            textAlign: TextAlign.center,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: context.appColors.primaryText,
              height: 24 / 16,
            ),
          ),
          24.verticalSpace,

          // Children List
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(childrenList.length, (index) {
              final child = childrenList[index];
              final isSelected = selectedIndex.value == index;

              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == childrenList.length - 1 ? 0 : 12.h,
                ),
                child: GestureDetector(
                  onTap: () => selectedIndex.value = index,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: context.appColors.secondaryBackground,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: isSelected
                            ? context.colors.primary
                            : AppColors.brandTealBorder,
                        width: 1.5.w,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Avatar Image with border
                        Container(
                          width: 48.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: isSelected
                                  ? context.colors.primary
                                  : AppColors.transparentColor,
                              width: 2.w,
                            ),
                          ),
                          child: CommonImage(
                            imageUrl: child.avatarAsset,
                            width: 44,
                            height: 44,
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        16.horizontalSpace,

                        // Child Name
                        Expanded(
                          child: Text(
                            child.name,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: context.appColors.strongText,
                            ),
                          ),
                        ),

                        // Radio Button Indicator
                        Container(
                          width: 24.w,
                          height: 24.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? context.colors.primary
                                  : AppColors.brandGrayBorder,
                              width: 1.5.w,
                            ),
                          ),
                          child: isSelected
                              ? Center(
                                  child: Container(
                                    width: 12.w,
                                    height: 12.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.colors.primary,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              );
                }),
              ),
            ),
          ),
          24.verticalSpace,

          // Action Buttons
          AppButton(
            label: LangKey.parentKitchen.goToSchedule,
            onPressed: () {
              final selectedChild = childrenList[selectedIndex.value];
              Get.back<void>();
              onGoToSchedule(selectedChild);
            },
            variant: ButtonVariant.primary,
            color: AppColors.primaryButtonColor,
            textColor: AppColors.whiteColor,
            isFullWidth: true,
            height: ButtonSize.large,
          ),
          12.verticalSpace,
          AppButton(
            label: LangKey.parentKitchen.cancel,
            onPressed: () => Get.back<void>(),
            variant: ButtonVariant.outline,
            textColor: context.colors.primary,
            isFullWidth: true,
            height: ButtonSize.large,
          ),
        ],
      ),
    );
  }
}
