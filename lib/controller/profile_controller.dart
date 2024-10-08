import 'package:bloodbond/screen/login_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  final getStorage = GetStorage();

  void logout() {
    getStorage.remove('token');
    getStorage.remove("role");
    getStorage.remove('latitude');
    getStorage.remove('longitude');
    getStorage.remove('blood_group');
    getStorage.remove('first_name');
    getStorage.remove('name');
    getStorage.remove('image');
    getStorage.remove('id');
    getStorage.remove('city');

    Get.offAll(() => const LoginScreen());
  }
}
