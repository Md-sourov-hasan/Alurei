import 'package:alurei/src/imports/imports.dart';

class EditChildProfileController extends GetxController {
  final nameController = TextEditingController(text: 'Eve');
  final birthDateController = TextEditingController();
  final weightController = TextEditingController();
  final activityNameController = TextEditingController();
  final notesController = TextEditingController();

  final selectedGender = 'Girl'.obs;

  // School Schedule
  final schoolDays = ['Mon'].obs;
  final schoolStartTimeController = TextEditingController(text: '08:30 AM');
  final schoolEndTimeController = TextEditingController(text: '03:30 PM');

  // Recurring Activity
  final activityDays = ['Mon'].obs;
  final activityStartTimeController = TextEditingController(text: '08:30 AM');
  final activityEndTimeController = TextEditingController(text: '09:00 AM');

  final RxList<Map<String, dynamic>> recurringActivities =
      <Map<String, dynamic>>[
    {
      'title': 'Story time',
      'time': '08:30 AM - 09:00 AM',
      'days': 'Mon',
    }
  ].obs;

  // Safety / Health
  final safetyReason = 'None'.obs;

  @override
  void onClose() {
    nameController.dispose();
    birthDateController.dispose();
    weightController.dispose();
    activityNameController.dispose();
    notesController.dispose();
    schoolStartTimeController.dispose();
    schoolEndTimeController.dispose();
    activityStartTimeController.dispose();
    activityEndTimeController.dispose();
    super.onClose();
  }

  void toggleSchoolDay(String day) {
    if (schoolDays.contains(day)) {
      schoolDays.remove(day);
    } else {
      schoolDays.add(day);
    }
  }

  void toggleActivityDay(String day) {
    if (activityDays.contains(day)) {
      activityDays.remove(day);
    } else {
      activityDays.add(day);
    }
  }

  void setActivity() {
    if (activityNameController.text.isNotEmpty && activityDays.isNotEmpty) {
      recurringActivities.add({
        'title': activityNameController.text,
        'time':
            '${activityStartTimeController.text} - ${activityEndTimeController.text}',
        'days': activityDays.join(', '),
      });
      activityNameController.clear();
      activityDays.clear();
      activityDays.add('Mon');
    }
  }

  void removeActivity(int index) {
    recurringActivities.removeAt(index);
  }

  void saveProfile() {
    // Save logic
    Get.back();
  }
}
