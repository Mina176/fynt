import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/widgets/scrollable_content_with_sticky_button.dart';
import 'package:fynt/features/authentication/logic/auth_service.dart';
import 'package:fynt/features/authentication/presentation/auth_field.dart';
import 'package:fynt/core/utils/validators.dart';
import 'package:fynt/features/onboarding/presentation/onboarding_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  String? emailError;
  final _emailContoller = TextEditingController();
  bool isLoading = false;
  void sendResetEmail() async {
    if (!formKey.currentState!.validate()) return;
    try {
      setState(() {
        isLoading = true;
        emailError = null;
      });
      await ref
          .read(authServiceProvider)
          .sendPasswordResetEmail(_emailContoller.text.trim());
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reset link sent! Please check your email.'),
          ),
        );
        context.pop();
      }
    } catch (e) {
      final validationError = Validators.validatePasswordWhenSignUp(
        e.toString(),
      );
      if (validationError != null) {
        setState(() => emailError = validationError);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.kHorizontalPadding,
          ),
          child: ScrollableContentWithStickyButton(
            column: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const OnboardingCard(
                  icon: Icons.lock_reset_sharp,
                  borderRadius: 50,
                  width: 100,
                  height: 100,
                  title: 'Forgot Password?',
                  subTitle:
                      'Don\'t worry, it happens. Please enter the email address associated with your account.',
                ),
                Form(
                  key: formKey,
                  child: TextFieldWithLabel(
                    label: 'Email Address',
                    hintText: 'you@example.com',
                    controller: _emailContoller,
                    validator: (val) =>
                        emailError ?? Validators.validateEmail(val),
                  ),
                ),
              ],
            ),
            button: Padding(
              padding: const EdgeInsets.only(
                bottom: Sizes.kVerticalPadding,
              ),
              child: ElevatedButton(
                onPressed: isLoading ? null : sendResetEmail,
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Send Reset Link'),
                          Icon(Icons.arrow_forward_rounded),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
