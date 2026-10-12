import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/parent_today_data.dart';
import '../../domain/repositories/parent_today_repository.dart';

class NannyPortfolioController extends GetxController {
  NannyPortfolioController(this._repository);

  final ParentTodayRepository _repository;

  final portfolio = Rxn<ParentNannyPortfolioData>();
  final selectedTab = ParentNannyPortfolioTab.portfolio.obs;
  final isLoading = true.obs;
  final errorMessage = RxnString();

  String get nannyId {
    final arguments = Get.arguments;
    if (arguments is Map && arguments['nanny_id'] is String) {
      return arguments['nanny_id']! as String;
    }
    return 'nanny-deepa';
  }

  @override
  void onInit() {
    super.onInit();
    loadPortfolio();
  }

  Future<void> loadPortfolio() async {
    isLoading.value = true;
    errorMessage.value = null;
    final result = await _repository.loadNannyPortfolio(nannyId);
    result.fold(
      (failure) => errorMessage.value = failure.message,
      (value) => portfolio.value = value,
    );
    isLoading.value = false;
  }

  set tab(ParentNannyPortfolioTab tab) => selectedTab.value = tab;
}
