import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

class AuthFormWidget extends StatelessWidget {
  const AuthFormWidget({
    required this.emailController,
    required this.passwordController,
    required this.buttonLabel,
    required this.onSubmit,
    this.isSubmitting = false,
    this.isRegister = false,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String buttonLabel;
  final VoidCallback onSubmit;
  final bool isSubmitting;
  final bool isRegister;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isRegister ? 'Create account' : 'Welcome back',
            style: AppTextStyles.displayMedium.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: 24),
          AppTextField(
            controller: emailController,
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: passwordController,
            label: 'Password',
            obscureText: true,
          ),
          const SizedBox(height: 24),
          AppButton(label: buttonLabel, onPressed: onSubmit, isLoading: isSubmitting),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed('/register'),
            child: Text(isRegister ? 'Already have an account?' : 'Need an account?'),
          ),
        ],
      ),
    );
  }
}
