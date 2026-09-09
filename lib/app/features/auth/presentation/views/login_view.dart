import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_starter_kit/generated/locales.g.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_form_widget.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            margin: const EdgeInsets.all(20),
            child: AuthFormWidget(
              emailController: controller.emailController,
              passwordController: controller.passwordController,
              buttonLabel: LocaleKeys.login_title.tr,
              isSubmitting: controller.isLoading.value,
              onSubmit: () {
                if (controller.emailController.text.trim().isNotEmpty && controller.passwordController.text.isNotEmpty) {
                  controller.login(controller.emailController.text, controller.passwordController.text);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

}
