import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/contact_user.dart';

import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:record/record.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

enum MsgKind { text, image, file, audio, location, contact }

class ChatMessage {
  final String id;
  final MsgKind kind;
  final String text;
  final bool isMe;
  final DateTime sentAt;

  final String? path;
  final String? name;
  final double? lat;
  final double? lng;

  const ChatMessage({
    required this.id,
    required this.kind,
    required this.text,
    required this.isMe,
    required this.sentAt,
    this.path,
    this.name,
    this.lat,
    this.lng,
  });
}

class ConversationController extends GetxController {
  final Rxn<ContactUser> user = Rxn<ContactUser>();

  final RxList<ChatMessage> _typed = <ChatMessage>[].obs;

  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;

  final TextEditingController msgCtrl = TextEditingController();
  final ScrollController scrollCtrl = ScrollController();

  final RxBool isAttachOpen = false.obs;

  final ImagePicker _picker = ImagePicker();
  final AudioRecorder _rec = AudioRecorder();

  @override
  void onInit() {
    super.onInit();

    // استلام جهة الاتصال
    final arg = Get.arguments;
    if (arg is ContactUser) user.value = arg;

    // رسائل تجريبية
    _typed.addAll([
      ChatMessage(
        id: 'm1',
        kind: MsgKind.text,
        text:
            "This is your delivery driver from Speedy Chow. I'm just around the corner from your place. 😊",
        isMe: false,
        sentAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      ChatMessage(
        id: 'm2',
        kind: MsgKind.text,
        text:
            "Awesome, thanks for letting me know! Can't wait for my delivery. 📦",
        isMe: true,
        sentAt: DateTime.now().subtract(const Duration(minutes: 4)),
      ),
    ]);
    _syncToView();

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
  }

  // ====== فتح/إغلاق لوحة الإضافات ======
  void toggleAttachPanel() {
    isAttachOpen.toggle();
    if (isAttachOpen.value) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  void closeAttachPanel() => isAttachOpen.value = false;

  // ====== إرسال رسالة نصيّة ======
  void sendMessage() {
    final txt = msgCtrl.text.trim();
    if (txt.isEmpty) return;

    _typed.add(
      ChatMessage(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        kind: MsgKind.text,
        text: txt,
        isMe: true,
        sentAt: DateTime.now(),
      ),
    );
    msgCtrl.clear();
    closeAttachPanel();

    _syncToView();
    Future.microtask(_scrollToEnd);
  }

  Future<void> onPickCamera() async {
    closeAttachPanel();
    final ok = await _ask(Permission.camera);
    if (!ok) return;

    final XFile? file = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (file == null) return;

    _typed.add(
      ChatMessage(
        id: _id(),
        kind: MsgKind.image,
        text: '📷 Photo',
        path: file.path,
        isMe: true,
        sentAt: DateTime.now(),
      ),
    );
    _afterAdd();
  }

  Future<void> onPickGallery() async {
    closeAttachPanel();
    final ok = await _ask(
      Platform.isAndroid ? Permission.photos : Permission.photos,
    );
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (file == null) return;

    _typed.add(
      ChatMessage(
        id: _id(),
        kind: MsgKind.image,
        text: '🖼️ Image',
        path: file.path,
        isMe: true,
        sentAt: DateTime.now(),
      ),
    );
    _afterAdd();
  }

  Future<void> onPickDocument() async {
    closeAttachPanel();
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      withReadStream: false,
    );
    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;
    _typed.add(
      ChatMessage(
        id: _id(),
        kind: MsgKind.file,
        text: '📄 ${file.name}',
        path: file.path,
        name: file.name,
        isMe: true,
        sentAt: DateTime.now(),
      ),
    );
    _afterAdd();
  }

  Future<void> onShareLocation() async {
    closeAttachPanel();

    // صلاحية الموقع
    bool svcEnabled = await Geolocator.isLocationServiceEnabled();
    if (!svcEnabled) {
      Get.snackbar('Location', 'Location services are disabled');
      return;
    }
    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }
    if (perm == LocationPermission.deniedForever ||
        perm == LocationPermission.denied) {
      Get.snackbar('Location', 'Location permission denied');
      return;
    }

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final link = 'https://maps.google.com/?q=${pos.latitude},${pos.longitude}';

    _typed.add(
      ChatMessage(
        id: _id(),
        kind: MsgKind.location,
        text: '📍 My Location\n$link',
        lat: pos.latitude,
        lng: pos.longitude,
        isMe: true,
        sentAt: DateTime.now(),
      ),
    );
    _afterAdd();
  }

  Future<void> onRecordAudio() async {
    closeAttachPanel();

    final micOk = await _ask(Permission.microphone);
    if (!micOk) return;

    final isRec = await _rec.isRecording();
    if (!isRec) {
      // ابدأ التسجيل
      await _rec.start(
        const RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 128000),
        path: '',
      );
      Get.snackbar('Record', 'Recording...');
      return;
    } else {
      final path = await _rec.stop();
      if (path == null) return;
      _typed.add(
        ChatMessage(
          id: _id(),
          kind: MsgKind.audio,
          text: '🎤 Voice message',
          path: path,
          isMe: true,
          sentAt: DateTime.now(),
        ),
      );
      _afterAdd();
    }
  }

  /// اختيار جهة اتصال من الجهاز
  Future<void> onPickContact() async {
    closeAttachPanel();

    final ok = await _ask(Permission.contacts);
    if (!ok) return;

    try {
      final contact = await ContactsService.openDeviceContactPicker();
      if (contact == null) return;

      final display = contact.displayName ?? 'Contact';
      String phone = '';
      if (contact.phones != null && contact.phones!.isNotEmpty) {
        phone = contact.phones!.first.value ?? '';
      }

      _typed.add(
        ChatMessage(
          id: _id(),
          kind: MsgKind.contact,
          text: '👤 $display${phone.isNotEmpty ? ' — $phone' : ''}',
          name: display,
          isMe: true,
          sentAt: DateTime.now(),
        ),
      );
      _afterAdd();
    } catch (e) {
      Get.snackbar('Contact', 'Contact picker not available');
    }
  }

  // ====== Helpers ======
  String _id() => DateTime.now().microsecondsSinceEpoch.toString();

  Future<bool> _ask(Permission p) async {
    final status = await p.request();
    return status.isGranted;
  }

  void _afterAdd() {
    _syncToView();
    Future.microtask(_scrollToEnd);
  }

  void _syncToView() {
    messages.assignAll(
      _typed.map((m) {
        return {
          'id': m.id,
          'text': m.text,
          'isMe': m.isMe,
          'sentAt': m.sentAt,
          'kind': m.kind.name,
          'path': m.path,
          'name': m.name,
          'lat': m.lat,
          'lng': m.lng,
        };
      }),
    );
  }

  void _scrollToEnd() {
    if (!scrollCtrl.hasClients) return;
    scrollCtrl.animateTo(
      scrollCtrl.position.maxScrollExtent + 120,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  void onClose() {
    msgCtrl.dispose();
    scrollCtrl.dispose();
    _rec.dispose();
    super.onClose();
  }
}
