import 'package:get/get.dart';
import 'package:messaging_app/app/modules/friends/controllers/add_friend_controller.dart';

class FriendsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddFriendController>(() => AddFriendController());
  }
}
