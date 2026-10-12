import 'package:alurei/src/imports/imports.dart';
import '../controllers/my_children_controller.dart';

class MyChildrenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyChildrenController());
  }
}
