import 'package:alurei/src/imports/imports.dart';
import '../../data/repositories/recipe_repository_impl.dart';
import '../../domain/entities/kitchen_recipe.dart';
import 'missing_ingredients_sheet.dart';
import 'select_child_sheet.dart';

class RecipeDetailsBottomActions extends StatelessWidget {
  const RecipeDetailsBottomActions({
    super.key,
    required this.recipe,
  });

  final KitchenRecipe recipe;

  void _showSelectChildSheet(BuildContext context) {
    showAppSheet<void>(
      child: SelectChildSheet(
        onGoToSchedule: (selectedChild) async {
          final repository = RecipeRepositoryImpl();
          final now = DateTime.now();
          final dateStr =
              '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

          final result = await repository.addScheduleFromLibrary(
            childId: selectedChild.id,
            date: dateStr,
            libraryItemId: recipe.id,
            libraryItemType: 'recipe',
            startTime: '09:15',
            endTime: '10:00',
            description: 'Recipe schedule: ${recipe.title}',
          );

          result.fold(
            (failure) {
              showGlobalToast(message: failure.message, status: 'error');
            },
            (_) {
              showGlobalToast(message: LangKey.parentKitchen.addedToSchedule);
            },
          );

          Get.toNamed<void>(
            AppRoutes.buildDayFromLibrary,
            arguments: {
              'child_id': selectedChild.id,
              'child_name': selectedChild.name,
            },
          );
        },
      ),
    );
  }

  void _showMissingIngredientsSheet(BuildContext context) {
    showAppSheet<void>(
      child: MissingIngredientsSheet(
        onScheduleAnyway: () {
          _showSelectChildSheet(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 32.h),
      decoration: BoxDecoration(
        color: context.appColors.bottomNavSelectedBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Add to Schedule Button
          AppButton(
            label: LangKey.parentKitchen.addToSchedule,
            onPressed: () {
              if (recipe.status == RecipeStatus.needsIngredients) {
                _showMissingIngredientsSheet(context);
              } else {
                _showSelectChildSheet(context);
              }
            },
            variant: ButtonVariant.primary,
            isFullWidth: true,
            height: ButtonSize.large,
            prefixIcon: SvgPicture.asset(
              AppAssets.icKitchenAdd,
              width: 20.w,
              height: 20.w,
              colorFilter: const ColorFilter.mode(
                AppColors.whiteColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Cancel Button
          AppButton(
            label: LangKey.parentKitchen.cancel,
            onPressed: () => Get.back<void>(),
            variant: ButtonVariant.outline,
            borderColor: AppColors.brandGrayBorder,
            isFullWidth: true,
            height: ButtonSize.large,
          ),
        ],
      ),
    );
  }
}
