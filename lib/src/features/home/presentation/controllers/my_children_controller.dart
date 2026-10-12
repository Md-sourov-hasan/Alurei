import 'package:alurei/src/imports/imports.dart';

class MyChildrenController extends GetxController {
  // Dummy data for children
  final RxList<Map<String, dynamic>> childrenList = <Map<String, dynamic>>[
    {
      'name': 'Eve Ahmed',
      'age': '4 years 2 months 6 days',
      'assigned': 'Maya, Arjun',
      'image': 'assets/images/Monica_child1.png',
      'caregiver1': 'assets/images/parent_today_parent_avatar.png',
      'caregiver2': 'assets/images/monioka_child2.png',
    },
    {
      'name': 'Liam Johnson',
      'age': '3 years 5 months 12 days',
      'assigned': 'Maya, Arjun',
      'image': 'assets/images/monioka_child2.png',
      'caregiver1': 'assets/images/parent_today_parent_avatar.png',
      'caregiver2': 'assets/images/monika_child3.png',
    },
    {
      'name': 'Ava Patel',
      'age': '2 years 8 months 19 days',
      'assigned': 'Maya, Arjun',
      'image': 'assets/images/monika_child3.png',
      'caregiver1': 'assets/images/parent_today_parent_avatar.png',
      'caregiver2': 'assets/images/Monica_child1.png',
    },
    {
      'name': 'Noah Smith',
      'age': '5 years 1 month 3 days',
      'assigned': 'Kiran, Tara',
      'image': 'assets/images/Monica_child1.png',
      'caregiver1': 'assets/images/parent_today_parent_avatar.png',
      'caregiver2': 'assets/images/monioka_child2.png',
    },
    {
      'name': 'Sophia Brown',
      'age': '1 year 4 months 15 days',
      'assigned': 'Maya, Arjun',
      'image': 'assets/images/monioka_child2.png',
      'caregiver1': 'assets/images/parent_today_parent_avatar.png',
      'caregiver2': 'assets/images/monika_child3.png',
    }
  ].obs;
}
