import 'package:alurei/src/imports/imports.dart';
import '../../domain/entities/kitchen_recipe.dart';

class RecipeDetailsSafetyNotes extends StatelessWidget {
  const RecipeDetailsSafetyNotes({
    super.key,
    required this.recipe,
  });

  final KitchenRecipe recipe;

  @override
  Widget build(BuildContext context) {
    final note = recipe.safetyNote;
    if (note == null || note.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangKey.parentKitchen.safetyNotes,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: context.colors.primary,
            height: 32 / 24,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: context.appColors.warning,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Text(
            note,
            textAlign: TextAlign.center,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: context.appColors.onWarning,
              height: 24 / 16,
            ),
          ),
        ),
      ],
    );
  }
}
