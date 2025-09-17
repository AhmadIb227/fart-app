import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messaging_app/app/routes/app_routes.dart';

import '../../../data/models/contact_user.dart';
import '../../../data/models/group_meta.dart';

class GroupItem {
  final String id;
  final String title;
  final String subtitle;
  final String timeLabel;
  final int badge;
  final int membersCount;
  final List<String> avatars;

  GroupItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timeLabel,
    this.badge = 0,
    this.membersCount = 3,
    this.avatars = const [],
  });
}

class GroupsController extends GetxController {
  final navIndex = 1.obs;
  final isMenuOpen = false.obs;
  final isSearching = false.obs;
  final isLoading = false.obs;

  final TextEditingController searchCtrl = TextEditingController();

  final RxList<GroupItem> _all = <GroupItem>[].obs;

  List<GroupItem> get filtered {
    final q = searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return _all;
    return _all.where((g) {
      return g.title.toLowerCase().contains(q) ||
          g.subtitle.toLowerCase().contains(q);
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    _all.addAll([
      GroupItem(
        id: 'g1',
        title: 'Game 🎮',
        subtitle: "Great, thanks for letting me know!",
        timeLabel: '10:25',
        membersCount: 3,
      ),
      GroupItem(
        id: 'g2',
        title: 'Diamond Team 💎',
        subtitle: "Thanks a bunch! Have a great day!",
        timeLabel: '09/05',
        membersCount: 5,
      ),
      GroupItem(
        id: 'g3',
        title: 'IT Training',
        subtitle: "Hope you enjoy it!",
        timeLabel: '01/05',
        membersCount: 8,
      ),
    ]);
  }

  void onNavTap(int index) {
    navIndex.value = index;
    closeMenu();

    switch (index) {
      case 0:
        if (Get.currentRoute != Routes.chats) {
          Get.offNamed(Routes.chats);
        }
        break;
      case 1:
        break;
      default:
        break;
    }
  }

  void toggleMenu() => isMenuOpen.toggle();
  void closeMenu() => isMenuOpen.value = false;

  void onSearchTap() {
    isSearching.value = true;
    searchCtrl.clear();
    update();
  }

  void cancelSearch() {
    isSearching.value = false;
    searchCtrl.clear();
    update();
  }

  void onCreateGroup() {
    Get.snackbar('Groups', 'Create Group tapped');
  }

  void openGroup(GroupItem g) {
    final cu = ContactUser(id: g.id, name: g.title, phone: '', avatarUrl: '');

    final meta = GroupMeta(
      id: g.id,
      title: g.title,
      membersCount: g.membersCount,
      avatars: g.avatars,
    );

    Get.toNamed(Routes.conversation, arguments: {'user': cu, 'group': meta});
  }

  @override
  void onClose() {
    searchCtrl.dispose();
    super.onClose();
  }
}
