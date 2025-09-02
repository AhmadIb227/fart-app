import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messaging_app/app/widgets/buttons/add_members_sheet.dart';

import '../../../data/models/contact_user.dart';
import '../../../data/providers/mock_contacts_provider.dart';

class CreateGroupController extends GetxController {
  // اسم المجموعة
  final TextEditingController nameCtrl = TextEditingController();

  // كل جهات الاتصال (مصدرها MockContactsProvider)
  final RxList<ContactUser> _all = <ContactUser>[].obs;

  // الأعضاء المختارون
  final RxList<ContactUser> selectedMembers = <ContactUser>[].obs;

  final _contactsProvider = MockContactsProvider();

  @override
  void onInit() {
    super.onInit();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final contacts = await _contactsProvider.fetchContacts();
    _all.assignAll(contacts);
  }

  /// يفتح الشيت المنبثق بتصميم فيجما لاختيار الأعضاء
  Future<void> openAddMembersSheet() async {
    final picked = await showAddMembersSheet(
      all: _all.toList(),
      initiallySelected: selectedMembers.toList(),
    );
    if (picked != null) {
      selectedMembers.assignAll(picked);
    }
  }

  /// لاحقاً اربطها مع الـ API (POST /groups)
  void submit() {
    final name = nameCtrl.text.trim();
    if (name.isEmpty) {
      Get.snackbar('Create Group', 'Please enter group name');
      return;
    }
    if (selectedMembers.isEmpty) {
      Get.snackbar('Create Group', 'Please add at least one member');
      return;
    }

    // TODO: استبدل بهذا نداء الباك-إند لاحقاً
    Get.snackbar(
      'Create Group',
      'Created "$name" with ${selectedMembers.length} member(s).',
    );
    Get.back();
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    super.onClose();
  }
}
