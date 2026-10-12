import 'package:alurei/src/features/home/domain/entities/home_profile.dart';
import 'package:alurei/src/utils/utils.dart';

abstract class HomeRepository {
  FutureEither<HomeProfile> getCurrentProfile();
}
