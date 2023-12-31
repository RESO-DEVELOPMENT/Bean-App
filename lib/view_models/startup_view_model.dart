import 'package:get/get.dart';

import '../utils/route_constrant.dart';
import 'base_view_model.dart';

class StartUpViewModel extends BaseViewModel {
  StartUpViewModel() {
    handleStartUpLogic();
  }
  Future handleStartUpLogic() async {
    await Future.delayed(const Duration(seconds: 1));
    // String? userId = await getUserId();
    // if (userId != null) {
    //   await Get.find<AccountViewModel>().getMembershipInfo(userId);
    // }
    // await Get.find<MenuViewModel>().getMenuOfBrand();
    await Get.offAllNamed(RouteHandler.HOME);
  }
}
