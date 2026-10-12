import 'package:alurei/src/imports/imports.dart';
import '../../domain/entities/kitchen_recipe.dart';
import '../controllers/base_kitchen_controller.dart';
import 'kitchen_recipe_card.dart';

class KitchenSuggestedSection extends GetView<BaseKitchenController> {
  const KitchenSuggestedSection({
    super.key,
    required this.data,
  });

  final KitchenData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LangKey.parentKitchen.suggestedForYou,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  height: 32 / 24,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 16.h),
              _ChildChips(names: data.childNames),
              SizedBox(height: 16.h),
            ],
          ),
        ),
        SizedBox(
          height: 451.h,
          child: Obx(() {
            if (controller.isSuggestionsLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final recipes = controller.filteredSuggestedRecipes;

            if (recipes.isEmpty) {
              return Center(
                child: Text(
                  'No recipe suggestions available',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    color: AppColors.secondaryTeal,
                  ),
                ),
              );
            }

            return ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: recipes.length,
              separatorBuilder: (_, __) => SizedBox(width: 16.w),
              itemBuilder: (context, i) {
                final recipe = recipes[i];
                return KitchenRecipeCard(
                  recipe: recipe,
                  onViewRecipe: () => controller.onViewRecipe(recipe),
                  onAddToSchedule: () => controller.onAddToSchedule(recipe),
                );
              },
            );
          }),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}

class _ChildChips extends GetView<BaseKitchenController> {
  const _ChildChips({required this.names});

  final List<String> names;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: Obx(
        () {
          final selectedIndex = controller.selectedChildIndex.value;
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: names.length,
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (ctx, i) {
              final isSelected = selectedIndex == i;
              return GestureDetector(
                onTap: () => controller.selectChild(i),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.secondaryTeal
                        : AppColors.kitchenChildChipUnselectedBg,
                    borderRadius: BorderRadius.circular(9999.r),
                  ),
                  child: Text(
                    names[i],
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? AppColors.whiteColor
                          : AppColors.secondaryTeal,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
