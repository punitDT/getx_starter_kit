import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_form_widget.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          margin: const EdgeInsets.all(20),
          child: AuthFormWidget(
            emailController: controller.emailController,
            passwordController: controller.passwordController,
            buttonLabel: 'Create account',
            isSubmitting: controller.isLoading.value,
            isRegister: true,
            onSubmit: () {
              if (controller.emailController.text.trim().isNotEmpty && controller.passwordController.text.isNotEmpty) {
                controller.register(controller.emailController.text, controller.passwordController.text);
              }
            },
          ),
        ),
      ),
    );
  }
}
