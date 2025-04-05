import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs; // Track current tab index

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
