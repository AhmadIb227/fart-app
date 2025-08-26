class Validators {
  static String? requiredField(String? v) =>
      (v == null || v.trim().isEmpty) ? 'الحقل مطلوب' : null;

  static String? email(String? v) {
    if (requiredField(v) != null) return 'البريد مطلوب';
    final r = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,4}$');
    return r.hasMatch(v!.trim()) ? null : 'صيغة بريد غير صحيحة';
  }

  static String? min6(String? v) =>
      (v != null && v.length >= 6) ? null : 'الحد الأدنى 6 أحرف';
}
