
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../services/theme_manager.dart';

class DependencyInjection implements Bindings {

  DependencyInjection();

  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ThemeController(), fenix: true);
  }
}