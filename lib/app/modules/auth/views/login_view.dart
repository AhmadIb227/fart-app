import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import 'package:email_validator/email_validator.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // استخدام MediaQuery للحصول على أبعاد الشاشة لتصميم متجاوب
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // استخدام اللون الرمادي الفاتح لخلفية منطقة الإدخال كما هو مطلوب [cite: 15]
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- قسم الهيدر ---
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                // تحديد الارتفاع بنسبة 35% من الشاشة [cite: 11]
                height: screenHeight * 0.35,
                width: double.infinity,
                // استخدام اللون الأخضر الداكن للخلفية [cite: 8]
                color: const Color(0xFF1B4332),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    // العنوان الرئيسي "Login" [cite: 9]
                    Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 8),
                    // العنوان الفرعي "Enter your credentials" [cite: 10]
                    Text(
                      "Enter your credentials",
                      style: TextStyle(
                        // استخدام اللون الذهبي [cite: 10]
                        color: Color(0xFFC9A961),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- قسم الإدخال ---
            Padding(
              padding: const EdgeInsets.all(24.0),
              // 1. استبدل Column بـ Form وقم بربطه بالـ formKey
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // --- حقل البريد الإلكتروني ---
                    TextFormField(
                      // 2. ربط حقل الإدخال بالـ controller الخاص به
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'example@email.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      // 3. إضافة قواعد التحقق
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email'; // رسالة خطأ للحقل الفارغ [cite: 139]
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'Please enter a valid email'; // رسالة خطأ لصيغة الإيميل [cite: 140]
                        }
                        return null; // يعني أن القيمة صحيحة
                      },
                    ),

                    const SizedBox(height: 10),

                    // --- حقل كلمة المرور ---
                    Obx(
                      () => TextFormField(
                        // 4. ربط حقل الإدخال بالـ controller الخاص به
                        controller: controller.passwordController,
                        obscureText: controller.isPasswordHidden.value,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordHidden.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        ),
                        // 5. إضافة قواعد التحقق
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password'; // رسالة خطأ للحقل الفارغ [cite: 139]
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    // --- إضافة مربع اختيار "تذكرني" ---
                    Obx(
                      () => Row(
                        children: [
                          Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: (value) {
                              controller.rememberMe.value = value!;
                            },
                            activeColor: const Color(0xFF1B4332),
                          ),
                          const Text("Remember me"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // --- زر تسجيل الدخول وحالة التحميل ---
                    Obx(() {
                      // استخدم Obx لمراقبة التغييرات في متغيرات الـ controller
                      return controller.isLoading.value
                          // إذا كان التحميل جاريًا، أظهر مؤشر التحميل
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(
                                  0xFF1B4332,
                                ), // استخدم اللون الأساسي للتطبيق
                              ),
                            )
                          // إذا لم يكن التحميل جاريًا، أظهر الزر
                          : ElevatedButton(
                              onPressed: controller.login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1B4332),
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- كلاس تصميم المنحنى السفلي للهيدر ---
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // يبدأ من أعلى اليسار
    path.lineTo(0, size.height - 40);

    // النقطة الأولى للمنحنى
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    // النقطة الثانية للمنحنى
    var secondControlPoint = Offset(
      size.width - (size.width / 3.25),
      size.height - 65,
    );
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    // يصعد لأعلى اليمين
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
