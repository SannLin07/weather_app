import 'package:get/get.dart';

import '../home_screen/home_screen.dart';

class SplashController extends GetxController {
  var _isLoading = false.obs; //Rxbool
  bool get isLoading => _isLoading.value; //nomal bool
  set isLoading(value) => _isLoading.value = value; //getter => setter

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    isLoading = true;
    // Simulate loading data
    await Future.delayed(const Duration(seconds: 2));
    // Navigate to home screen
    Get.off(() => const HomeScreen());
    isLoading = false;
  }
}
