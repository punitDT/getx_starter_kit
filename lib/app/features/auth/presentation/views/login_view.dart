import 'package:flutter/material.dart';

import '../../../../core/base/base_view.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_form_widget.dart';

class LoginView extends BaseView<AuthController> {
  const LoginView({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Center(
      child: SingleChildScrollView(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          margin: const EdgeInsets.all(20),
          child: AuthFormWidget(
            emailController: emailController,
            passwordController: passwordController,
            buttonLabel: 'Login',
            isSubmitting: controller.isLoading.value,
            onSubmit: () {
              if (emailController.text.trim().isNotEmpty && passwordController.text.isNotEmpty) {
                controller.login(emailController.text, passwordController.text);
              }
            },
          ),
        ),
      ),
    );
  }
}
