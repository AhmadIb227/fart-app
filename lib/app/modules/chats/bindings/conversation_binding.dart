// lib/app/modules/conversation/bindings/conversation_binding.dart
import 'package:get/get.dart';
import 'package:messaging_app/app/modules/chats/controllers/conversation_controller.dart';

class ConversationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConversationController>(() => ConversationController());
  }
}
