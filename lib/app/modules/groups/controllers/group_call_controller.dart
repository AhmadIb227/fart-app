import 'dart:async';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../data/models/group_meta.dart';

class GroupCallController extends GetxController {
  final Rxn<GroupMeta> group = Rxn<GroupMeta>();

  // حالة المكالمة
  final isInCall = false.obs;
  final callingLabel = 'Calling ...'.obs;

  // تحكّم
  final micMuted = false.obs;
  final speakerOn = false.obs;

  // مؤقّت
  final elapsedSeconds = 0.obs;
  Timer? _ticker;

  // الكاميرا الأمامية
  final camReady = false.obs;
  CameraController? camCtrl;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is GroupMeta) group.value = arg;
  }

  // استدعها من شاشة الفيديو (مثلاً في initState/البناء الأول)
  Future<void> initFrontCamera() async {
    try {
      // اطلب صلاحيات
      await Permission.camera.request();
      await Permission.microphone.request();

      final cams = await availableCameras();
      final front = cams.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cams.first,
      );
      camCtrl = CameraController(
        front,
        ResolutionPreset.high,
        enableAudio: true,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await camCtrl!.initialize();
      camReady.value = true;
    } catch (_) {
      camReady.value = false; // خليه صامت لو ما توفرت كاميرا
    }
  }

  // الاتصال (محاكاة الاستجابة)
  void connect() {
    if (isInCall.value) return;
    isInCall.value = true;
    callingLabel.value = 'Calling ...'; // غيّرها إن حبيت
    _startTimer();
  }

  void hangUp() {
    _stopTimer();
    camCtrl?.dispose();
    camCtrl = null;
    Get.back();
  }

  void toggleMic() => micMuted.toggle();
  void toggleSpeaker() => speakerOn.toggle();

  String formatElapsed() {
    final t = elapsedSeconds.value;
    final m = (t ~/ 60).toString().padLeft(2, '0');
    final s = (t % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _startTimer() {
    _ticker?.cancel();
    elapsedSeconds.value = 0;
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      elapsedSeconds.value++;
    });
  }

  void _stopTimer() {
    _ticker?.cancel();
    _ticker = null;
  }

  @override
  void onClose() {
    camCtrl?.dispose();
    _stopTimer();
    super.onClose();
  }
}
