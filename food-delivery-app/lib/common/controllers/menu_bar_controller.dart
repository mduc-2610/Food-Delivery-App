
import 'package:get/get.dart';

class MenuBarController extends GetxController {
  static MenuBarController get instance => Get.find();

  Rx<int> currentIndex = 0.obs;

  MenuBarController(int index) {
    this.currentIndex.value = index;
  }

  void updateIndex(value) {
    print("VAPT");
    currentIndex.value = value;
  }

}