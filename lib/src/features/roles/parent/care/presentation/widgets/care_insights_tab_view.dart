import 'package:alurei/src/imports/imports.dart';
import '../controllers/parent_care_controller.dart';
import 'insights/care_insights_caregiver_notes_card.dart';
import 'insights/care_insights_celebrate_card.dart';
import 'insights/care_insights_consistency_card.dart';
import 'insights/care_insights_favorites_section.dart';
import 'insights/care_insights_filter_pill.dart';
import 'insights/care_insights_moments_section.dart';
import 'insights/care_insights_snapshot_card.dart';
import 'insights/care_insights_summary_cards.dart';

class CareInsightsTabView extends HookWidget {
  const CareInsightsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ParentCareController>()
        ? Get.find<ParentCareController>()
        : Get.put(ParentCareController());

    final selectedBonusIndex = useState(1);
    final selectedMonth = useState('October');
    final selectedWeek = useState('Week 2');
    final monthKey = useMemoized(() => GlobalKey());
    final weekKey = useMemoized(() => GlobalKey());

    const favoriteActivities = [
      {
        'title': 'Drawing & Coloring',
        'subtitle': '4 30 mins • 2 hrs ...',
        'image': AppAssets.activityPlayground,
      },
      {
        'title': 'Outdoor Discovery',
        'subtitle': '1 15 mins • 1 hr ...',
        'image': AppAssets.recipeBlueberryOatPorridge,
      },
      {
        'title': 'Story Time',
        'subtitle': '4 30 mins • 2 hrs ...',
        'image': AppAssets.activityBearArtwork,
      },
    ];

    const favoriteMeals = [
      {
        'title': 'Blueberry Oat Porridge',
        'subtitle': 'Meal preparation ...',
        'image': AppAssets.recipeBlueberryOatPorridge,
      },
      {
        'title': 'Blueberry Oat Porridge',
        'subtitle': 'Ingredients & nutrition ...',
        'image': AppAssets.recipeMashedSweetPotato,
      },
      {
        'title': 'Blueberry Oat Porridge',
        'subtitle': 'Meal preparation ...',
        'image': AppAssets.recipeBlueberryOatPorridge,
      },
    ];

    const moments = [
      {
        'day': 'Monday',
        'text':
            'Collected leaves during a nature walk and talked about different shapes.',
      },
      {
        'day': 'Wednesday',
        'text':
            'Spent more time exploring creative activities and outdoor play',
      },
      {
        'day': 'Thursday',
        'text': 'Tried cucumber for the first time and asked for more.',
      },
      {
        'day': 'Saturday',
        'text': 'Tried a new vegetable and enjoyed it.',
      },
      {
        'day': 'Sunday',
        'text':
            'Visited the park and collected leaves for a craft activity.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),

        // 1. Date & Week Filter Pills Container
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CareInsightsFilterPill(
              monthKey: monthKey,
              weekKey: weekKey,
              selectedMonth: selectedMonth,
              selectedWeek: selectedWeek,
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // 2. Development Snapshot Card
        Obx(() {
          return CareInsightsSnapshotCard(
            childName: controller.currentChildName,
            trackedDays: '12',
            mealsLogged: '8',
          );
        }),
        SizedBox(height: 24.h),

        // 3. Favorite Activities Section
        CareInsightsFavoriteItemsCard(
          sectionTitle: LangKey.parentCare.favoriteActivities,
          sectionSvgPath: AppAssets.icFavActivity,
          items: favoriteActivities,
        ),
        SizedBox(height: 24.h),

        // 4. Favorite Meals Section
        CareInsightsFavoriteItemsCard(
          sectionTitle: LangKey.parentCare.favoriteMeals,
          sectionSvgPath: AppAssets.icFavMeals,
          items: favoriteMeals,
        ),
        SizedBox(height: 24.h),

        // 5. Nutrition Variety Card
        const CareInsightsNutritionVarietyCard(),
        SizedBox(height: 16.h),

        // 6. Growth & Play Card
        const CareInsightsGrowthPlayCard(),
        SizedBox(height: 16.h),

        // 7. Evolving Preferences Banner
        Obx(() {
          return CareInsightsEvolvingPreferencesBanner(
            childName: controller.currentChildName,
          );
        }),
        SizedBox(height: 24.h),

        // 8. Moments & Connection Section
        const CareInsightsMomentsSection(moments: moments),
        _buildSectionDivider(),

        // 9. Celebrate a Great Week Card
        CareInsightsCelebrateCard(selectedBonusIndex: selectedBonusIndex),
        _buildSectionDivider(),

        // 10. Caregiver Notes Section
        const CareInsightsCaregiverNotesSection(),
        _buildSectionDivider(),

        // 11. Care Consistency Card
        const CareInsightsConsistencyCard(scorePercentage: 95),
        SizedBox(height: 40.h),
      ],
    );
  }

  Widget _buildSectionDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14.h),
      height: 10.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3F3),
        borderRadius: BorderRadius.circular(5.r),
      ),
    );
  }
}
