import 'package:get/get.dart';
import 'package:messaging_app/app/modules/chats/bindings/conversation_binding.dart';
import 'package:messaging_app/app/modules/chats/views/conversation_view.dart';
import 'package:messaging_app/app/modules/friends/bindings/friends_binding.dart';
import 'package:messaging_app/app/modules/friends/views/add_friend_view.dart';
import 'package:messaging_app/app/modules/groups/bindings/create_group_binding.dart';
import 'package:messaging_app/app/modules/groups/bindings/group_call_binding.dart';
import 'package:messaging_app/app/modules/groups/bindings/group_info_binding.dart';
import 'package:messaging_app/app/modules/groups/bindings/groups_binding.dart';
import 'package:messaging_app/app/modules/groups/views/create_group_view.dart';
import 'package:messaging_app/app/modules/groups/views/group_call_view.dart';
import 'package:messaging_app/app/modules/groups/views/group_info_view.dart';
import 'package:messaging_app/app/modules/groups/views/group_video_call_view.dart';
import 'package:messaging_app/app/modules/groups/views/groups_view.dart';
import 'package:messaging_app/app/routes/app_routes.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/splash/views/onboarding_view.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/profile_setup_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/security/views/pin_setup_view.dart';
import '../modules/security/views/biometric_setup_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/chats/views/chat_list_view.dart';
import '../modules/chats/bindings/chat_binding.dart';

class AppPages {
  static final routes = <GetPage>[
    GetPage(name: AppRoutes.splash, page: () => const SplashView()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingView()),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.profileSetup,
      page: () => const ProfileSetupView(),
      binding: AuthBinding(),
    ),
    GetPage(name: AppRoutes.home, page: () => const HomeView()),
    GetPage(name: AppRoutes.pinSetup, page: () => const PinSetupView()),
    GetPage(
      name: AppRoutes.biometricSetup,
      page: () => const BiometricSetupView(),
    ),

    // جديد: شاشة قائمة المحادثات
    GetPage(
      name: AppRoutes.chats,
      page: () => const ChatListView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.addFriend,
      page: () => const AddFriendView(),
      binding: FriendsBinding(),
    ),
    GetPage(
      name: AppRoutes.createGroup,
      page: () => const CreateGroupView(),
      binding: CreateGroupBinding(),
    ),
    GetPage(
      name: Routes.conversation,
      page: () => const ConversationView(),
      binding: ConversationBinding(),
    ),
    GetPage(
      name: Routes.GROUPS,
      page: () => const GroupsView(),
      binding: GroupsBinding(),
    ),
    GetPage(
      name: Routes.GROUP_CALL,
      page: () => const GroupCallView(),
      binding: GroupCallBinding(),
    ),
    GetPage(
      name: Routes.GROUP_VIDEO_CALL,
      page: () => const GroupVideoCallView(),
      binding: GroupCallBinding(),
    ),
    GetPage(
      name: Routes.GROUP_INFO,
      page: () => const GroupInfoView(),
      binding: GroupInfoBinding(),
    ),
  ];
}
