import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';

import '../../../data/models/contact_user.dart';
import '../../../data/providers/mock_contacts_provider.dart';

class AddFriendController extends GetxController {
  final TextEditingController phoneCtrl = TextEditingController();

  // الدولة الافتراضية: سوريا
  final RxString dialCode = '+963'.obs;
  final RxString flagEmoji = '🇸🇾'.obs;
  final RxString countryCode = 'SY'.obs;

  // مزوّد البيانات (Mock)
  final _contactsProvider = MockContactsProvider();

  // كل الجهات
  final RxList<ContactUser> _allContacts = <ContactUser>[].obs;
  // الاقتراحات الحالية
  final RxList<ContactUser> suggestions = <ContactUser>[].obs;

  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    _loadContacts();
    phoneCtrl.addListener(_onPhoneChanged);
  }

  Future<void> _loadContacts() async {
    final list = await _contactsProvider.fetchContacts();
    _allContacts.assignAll(list);
    _refreshSuggestions(); // في حال كان هناك نص مسبق
  }

  void _onPhoneChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), _refreshSuggestions);
  }

  // تنظيف الأرقام إلى digits فقط (بدون + أو مسافات إلخ)
  String _digitsOnly(String s) => s.replaceAll(RegExp(r'\D'), '');

  void pickCountry(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (c) {
        dialCode.value = '+${c.phoneCode}';
        flagEmoji.value = c.flagEmoji;
        countryCode.value = c.countryCode;
        _refreshSuggestions(); // تحديث الاقتراحات عند تغيير الدولة
      },
    );
  }

  void _refreshSuggestions() {
    final input = phoneCtrl.text.trim();
    final inputDigits = _digitsOnly(input);
    final dialDigits = _digitsOnly(dialCode.value);

    // لا نعرض شيء لو الإدخال قصير جداً
    if (inputDigits.length < 2) {
      suggestions.clear();
      return;
    }

    // منطق المطابقة:
    // 1) مطابقة رقم الاتصال بعد إزالة كل غير الأرقام.
    // 2) نطابق إما على (كود الدولة + الإدخال) أو على الإدخال كجزء (contains).
    final qFull = '$dialDigits$inputDigits';

    final result = _allContacts.where((cu) {
      final phoneDigits = _digitsOnly(cu.phone);
      return phoneDigits.contains(qFull) || phoneDigits.contains(inputDigits);
    }).toList();

    // يمكن تحسينها بإزالة التكرارات والاقتصار على أول N
    if (result.length > 8) {
      result.removeRange(8, result.length);
    }
    suggestions.assignAll(result);
  }

  void fillFromSuggestion(ContactUser cu) {
    // تعبئة الحقل برقم المختار (بدون مسافات)
    phoneCtrl.text = cu.phone.replaceAll(' ', '');
    phoneCtrl.selection = TextSelection.fromPosition(
      TextPosition(offset: phoneCtrl.text.length),
    );
    _refreshSuggestions();
  }

  void submit() {
    final phone = phoneCtrl.text.trim();
    if (phone.isEmpty) {
      Get.snackbar('Oops', 'Please enter phone number');
      return;
    }
    // هنا النداء للباك-إند لاحقاً
    Get.snackbar('Add Friend', 'Request: ${dialCode.value} $phone');
  }

  @override
  void onClose() {
    _debounce?.cancel();
    phoneCtrl.dispose();
    super.onClose();
  }
}
