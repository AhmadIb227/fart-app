import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:messaging_app/app/data/models/chat_thread.dart';
import 'package:messaging_app/app/data/models/contact_user.dart';
import 'package:messaging_app/app/data/providers/mock_chat_provider.dart';
import 'package:messaging_app/app/data/providers/mock_contacts_provider.dart';
import 'package:messaging_app/app/routes/app_routes.dart';

class ChatListController extends GetxController {
  final _provider = MockChatProvider();
  final _contactsProvider = MockContactsProvider();

  final RxBool isLoading = false.obs;

  final RxList<ContactUser> contacts = <ContactUser>[].obs;
  Map<String, ContactUser> _nameIndex = {};

  final RxList<ChatThread> threads = <ChatThread>[].obs;
  final RxList<ChatThread> filtered = <ChatThread>[].obs;

  final RxBool isMenuOpen = false.obs;

  final RxBool isSearching = false.obs;
  final TextEditingController searchCtrl = TextEditingController();

  final RxInt navIndex = 0.obs; // 0 = Chats

  @override
  void onInit() {
    super.onInit();
    _preloadContacts();
    loadThreads();
    searchCtrl.addListener(() => onSearchChanged(searchCtrl.text));
  }

  Future<void> _preloadContacts() async {
    final list = await _contactsProvider.fetchContacts();
    contacts.assignAll(list);
    _rebuildIndex();
  }

  void _rebuildIndex() {
    _nameIndex = {for (final u in contacts) _normalize(u.name): u};
  }

  String _normalize(String s) =>
      s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '');

  Future<void> _ensureContactsLoaded() async {
    if (contacts.isEmpty) {
      await _preloadContacts();
    }
  }

  ContactUser? _findByNameSmart(String name) {
    final key = _normalize(name);
    final exact = _nameIndex[key];
    if (exact != null) return exact;

    // contains كخيار ثانٍ
    for (final e in _nameIndex.entries) {
      if (e.key.contains(key) || key.contains(e.key)) return e.value;
    }
    return null;
  }

  // --- Fuzzy match (Levenshtein) كخطة ثالثة اختيارياً ---
  int _lev(String a, String b) {
    if (a == b) return 0;
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;

    final m = List.generate(
      a.length + 1,
      (_) => List<int>.filled(b.length + 1, 0),
    );
    for (var i = 0; i <= a.length; i++) m[i][0] = i;
    for (var j = 0; j <= b.length; j++) m[0][j] = j;

    for (var i = 1; i <= a.length; i++) {
      for (var j = 1; j <= b.length; j++) {
        final cost = a[i - 1] == b[j - 1] ? 0 : 1;
        m[i][j] = [
          m[i - 1][j] + 1, // deletion
          m[i][j - 1] + 1, // insertion
          m[i - 1][j - 1] + cost, // substitution
        ].reduce((v, e) => v < e ? v : e);
      }
    }
    return m[a.length][b.length];
  }

  ContactUser? _findByNameFuzzy(String name) {
    final key = _normalize(name);
    var bestDist = 999;
    ContactUser? best;

    _nameIndex.forEach((k, u) {
      final d = _lev(k, key);
      if (d < bestDist) {
        bestDist = d;
        best = u;
      }
    });

    // نقبل مسافة تحرير صغيرة فقط (2-3) لتفادي التطابقات الخاطئة
    return (bestDist <= 2) ? best : null;
  }
  // ------------------------------------------------------

  Future<void> loadThreads() async {
    isLoading.value = true;
    try {
      final data = await _provider.fetchThreads();
      threads.assignAll(data);
      filtered.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }

  void toggleMenu() => isMenuOpen.toggle();
  void closeMenu() => isMenuOpen.value = false;

  void onSearchTap() {
    isSearching.value = true;
    closeMenu();
  }

  void cancelSearch() {
    isSearching.value = false;
    searchCtrl.clear();
    filtered.assignAll(threads);
  }

  void onSearchChanged(String v) {
    final q = v.trim().toLowerCase();
    if (q.isEmpty) {
      filtered.assignAll(threads);
      return;
    }
    filtered.assignAll(
      threads.where(
        (t) =>
            t.name.toLowerCase().contains(q) ||
            t.lastMessage.toLowerCase().contains(q),
      ),
    );
  }

  void onAddFriend() {
    closeMenu();
    Get.toNamed(AppRoutes.addFriend);
  }

  void onCreateGroup() {
    closeMenu();
    Get.toNamed(AppRoutes.createGroup);
  }

  Future<void> openThread(ChatThread t) async {
    await _ensureContactsLoaded();

    final cu =
        _findByNameSmart(t.name) ??
        _findByNameFuzzy(t.name) ??
        ContactUser(id: t.id, name: t.name, phone: '', avatarUrl: '');

    Get.toNamed(Routes.conversation, arguments: cu);
  }

  void onNavTap(int i) {
    navIndex.value = i;
    switch (i) {
      case 0:
        break;
      case 1:
        Get.snackbar('Navigation', 'Groups tapped');
        break;
      case 2:
        Get.snackbar('Navigation', 'Profile tapped');
        break;
      case 3:
        Get.snackbar('Navigation', 'More tapped');
        break;
    }
  }

  @override
  void onClose() {
    searchCtrl.dispose();
    super.onClose();
  }
}
