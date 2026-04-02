import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/extensions/localization_extension.dart';
import 'package:fynt/core/widgets/scrollable_content_with_sticky_button.dart';
import 'package:fynt/features/authentication/logic/auth_service.dart';
import 'package:fynt/features/authentication/presentation/auth_field.dart';
import 'package:fynt/core/routing/app_route_enum.dart';
import 'package:fynt/core/utils/validators.dart';
import 'package:fynt/features/onboarding/presentation/widgets/onboarding_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UpdatePasswordScreen extends ConsumerStatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  ConsumerState<UpdatePasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<UpdatePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  String? passwordError;
  final _passwordController = TextEditingController();
  bool isLoading = false;
  void updatePassword() async {
    if (isLoading) return;
    if (!formKey.currentState!.validate()) return;
    try {
      setState(() {
        isLoading = true;
        passwordError = null;
      });
      await ref
          .read(authServiceProvider)
          .updatePassword(_passwordController.text);
      if (mounted) {
        context.go(AppRoutes.signIn.path);
      }
    } catch (e) {
      final validationError = Validators.validatePasswordWhenSignUp(
        e.toString(),
      );
      if (validationError != null) {
        setState(() => passwordError = validationError);
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.kVerticalPadding,
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
                  title: 'Update Password',
                  subTitle: 'Please enter your new password.',
                ),
                Form(
                  key: formKey,
                  child: TextFieldWithLabel(
                    label: context.l10n.password,
                    hintText: 'Enter your new password',
                    isPassword: true,
                    controller: _passwordController,
                    validator: (val) =>
                        passwordError ??
                        Validators.validatePasswordWhenSignUp(val),
                  ),
                ),
              ],
            ),
            button: Padding(
              padding: const EdgeInsets.only(
                bottom: Sizes.kVerticalPadding,
              ),
              child: ElevatedButton(
                onPressed: isLoading ? null : updatePassword,
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Update Password'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
