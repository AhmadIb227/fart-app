import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/group_meta.dart';
import '../../../services/group_prefs_service.dart';

class GroupInfoController extends GetxController {
  final Rxn<GroupMeta> group = Rxn<GroupMeta>();

  // حالات
  final mute = false.obs;
  final tone = 'Default'.obs;

  final protectedChat = false.obs;
  final hideChat = false.obs;
  final hideChatHistory = false.obs;

  final color = Rxn<Color>();
  final bgPath = RxnString();

  // عداد وسائط (إن توفر من الخارج، وإلا 0)
  final mediaCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is GroupMeta) group.value = arg;
    _load();
  }

  void _load() {
    final g = group.value;
    if (g == null) return;
    mute.value = GroupPrefsService.isMuted(g.id);
    tone.value = GroupPrefsService.tone(g.id);
    protectedChat.value = GroupPrefsService.isProtected(g.id);
    hideChat.value = GroupPrefsService.isHidden(g.id);
    hideChatHistory.value = GroupPrefsService.hideHistory(g.id);
    color.value = GroupPrefsService.customColor(g.id);
    bgPath.value = GroupPrefsService.backgroundPath(g.id);
  }

  Future<void> toggleMute(bool v) async {
    final g = group.value;
    if (g == null) return;
    await GroupPrefsService.setMuted(g.id, v);
    mute.value = v;
  }

  Future<void> pickTone() async {
    final g = group.value;
    if (g == null) return;
    final sel = await Get.bottomSheet<String>(
      _ToneSheet(current: tone.value),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
    if (sel != null) {
      await GroupPrefsService.setTone(g.id, sel);
      tone.value = sel;
      Get.snackbar('Notification', 'Tone set to $sel');
    }
  }

  Future<void> setProtected(bool v) async {
    final g = group.value;
    if (g == null) return;
    await GroupPrefsService.setProtected(g.id, v);
    protectedChat.value = v;
  }

  Future<void> setHidden(bool v) async {
    final g = group.value;
    if (g == null) return;
    await GroupPrefsService.setHidden(g.id, v);
    hideChat.value = v;
  }

  Future<void> setHideHistory(bool v) async {
    final g = group.value;
    if (g == null) return;
    await GroupPrefsService.setHideHistory(g.id, v);
    hideChatHistory.value = v;
  }

  Future<void> pickColor() async {
    final g = group.value;
    if (g == null) return;
    final c = await Get.bottomSheet<Color?>(
      _ColorSheet(current: color.value),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
    await GroupPrefsService.setCustomColor(g.id, c);
    color.value = c;
  }

  Future<void> pickBackground() async {
    final g = group.value;
    if (g == null) return;
    final ImagePicker picker = ImagePicker();
    final x = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (x != null) {
      await GroupPrefsService.setBackgroundPath(g.id, x.path);
      bgPath.value = x.path;
    }
  }

  void openMedia() {
    // افتح شاشة وسائط/روابط لاحقاً – حالياً تنبيه بسيط
    Get.snackbar('Media', 'Open media & links (TODO)');
  }

  Future<void> report() async {
    Get.snackbar('Report', 'Thanks for your report');
  }

  Future<void> leaveGroup() async {
    final ok = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Leave group?'),
        content: const Text(
          'You will stop receiving messages from this group.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
    if (ok == true) {
      final g = group.value;
      if (g == null) return;
      await GroupPrefsService.setHidden(g.id, true);
      Get.back(); // اغلاق صفحة المعلومات
      Get.snackbar('Group', 'You left the group');
    }
  }
}

/// === BottomSheets ===
class _ToneSheet extends StatelessWidget {
  final String current;
  const _ToneSheet({required this.current});

  @override
  Widget build(BuildContext context) {
    final tones = ['Default', 'Chime', 'Bell', 'Pop', 'Soft'];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Select tone',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 8),
            for (final t in tones)
              ListTile(
                title: Text(t),
                trailing: t == current
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () => Get.back(result: t),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _ColorSheet extends StatelessWidget {
  final Color? current;
  const _ColorSheet({required this.current});

  @override
  Widget build(BuildContext context) {
    final palette = <Color>[
      const Color(0xFF08512A),
      const Color(0xFF0B615F),
      const Color(0xFF1565C0),
      const Color(0xFF6A1B9A),
      const Color(0xFFAD1457),
      const Color(0xFFEF6C00),
      const Color(0xFF2E7D32),
      const Color(0xFF455A64),
    ];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Pick chat color',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final c in palette)
                  GestureDetector(
                    onTap: () => Get.back(result: c),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: const [
                          BoxShadow(color: Color(0x22000000), blurRadius: 8),
                        ],
                      ),
                      child: current?.value == c.value
                          ? const Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  ),
                // بدون لون
                GestureDetector(
                  onTap: () => Get.back(result: null),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black26),
                    ),
                    child: const Icon(Icons.close, size: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
