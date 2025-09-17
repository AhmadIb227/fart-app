import 'package:get/get.dart';
import 'package:messaging_app/app/modules/groups/controllers/group_call_controller.dart';

class GroupCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupCallController>(() => GroupCallController());
  }
}
