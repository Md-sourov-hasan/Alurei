import 'package:alurei/src/imports/imports.dart';

import 'for_you_activity_ideas.dart';
import 'for_you_ask_alurei.dart';
import 'for_you_highlights.dart';
import 'for_you_little_moments.dart';
import 'for_you_wellbeing.dart';
import '../insights/care_insights_filter_pill.dart';

class CareForYouTabView extends HookWidget {
  const CareForYouTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final monthKey = useMemoized(GlobalKey.new);
    final weekKey = useMemoized(GlobalKey.new);
    final selectedMonth = useState('October');
    final selectedWeek = useState('Week 2');

    // Create ValueNotifiers that wrap the useState values to match CareInsightsFilterPill API
    final monthNotifier = useMemoized(() => ValueNotifier(selectedMonth.value));
    final weekNotifier = useMemoized(() => ValueNotifier(selectedWeek.value));
    
    // Sync state changes back to notifiers
    useEffect(() {
      monthNotifier.value = selectedMonth.value;
      weekNotifier.value = selectedWeek.value;
      return null;
    }, [selectedMonth.value, selectedWeek.value]);
    
    // Listen to notifier changes
    useEffect(() {
      void monthListener() => selectedMonth.value = monthNotifier.value;
      void weekListener() => selectedWeek.value = weekNotifier.value;
      
      monthNotifier.addListener(monthListener);
      weekNotifier.addListener(weekListener);
      
      return () {
        monthNotifier.removeListener(monthListener);
        weekNotifier.removeListener(weekListener);
      };
    }, [monthNotifier, weekNotifier]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: CareInsightsFilterPill(
            monthKey: monthKey,
            weekKey: weekKey,
            selectedMonth: monthNotifier,
            selectedWeek: weekNotifier,
          ),
        ),
        SizedBox(height: 24.h),
        const ForYouActivityIdeas(),
        SizedBox(height: 32.h),
        const ForYouLittleMoments(),
        SizedBox(height: 32.h),
        const ForYouWellbeing(),
        SizedBox(height: 32.h),
        const ForYouAskAlurei(),
        SizedBox(height: 32.h),
        const ForYouHighlights(),
        SizedBox(height: 40.h),
      ],
    );
  }
}
