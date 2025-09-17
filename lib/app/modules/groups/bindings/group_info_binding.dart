import 'package:get/get.dart';
import 'package:messaging_app/app/modules/groups/controllers/group_info_controller.dart';

class GroupInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupInfoController>(() => GroupInfoController());
  }
}
