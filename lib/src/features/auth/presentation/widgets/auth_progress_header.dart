import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';

class AuthProgressHeader extends StatelessWidget {
  final int activeSteps;
  final int totalSteps;

  const AuthProgressHeader({
    super.key,
    required this.activeSteps,
    this.totalSteps = 7,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isActive = index < activeSteps;
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            height: 4.h,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryColor : const Color(0xFF97CFD0),
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        );
      }),
    );
  }
}
