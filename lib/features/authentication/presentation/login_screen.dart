import 'package:fynt/core/extensions/localization_extension.dart';
import 'package:fynt/features/authentication/logic/auth_controller.dart';
import 'package:fynt/features/authentication/logic/loading_state.dart';
import 'package:fynt/features/authentication/presentation/auth_field.dart';
import 'package:fynt/core/utils/validators.dart';
import 'package:fynt/core/routing/app_route_enum.dart';
import 'package:fynt/core/theming/app_colors.dart';
import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String? emailError;
  String? passwordError;
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signIn() async {
    setState(() {
      emailError = null;
      passwordError = null;
    });

    if (formKey.currentState!.validate()) {
      await ref
          .read(authControllerProvider.notifier)
          .sigInInUserWithEmailAndPassword(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    ref.listen(authControllerProvider, (previous, next) {
      if (next.state == LoadingStateEnum.success) {
        context.go(AppRoutes.home.path);
      } else if (next.hasError) {
        final error = next.errorMessage.toString();
        if (error.contains('auth credential is incorrect')) {
          setState(() => emailError = context.l10n.noAccountFoundWithEmail);
        } else if (error.contains('credential is incorrect')) {
          setState(() => passwordError = context.l10n.passwordIncorrect);
        } else if (error.contains('wrong-password')) {
          setState(() => passwordError = context.l10n.incorrectPassword);
        } else {}
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.kHorizontalPadding,
          ),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      context.l10n.welcomeBack,
                      style: TextStyles.title,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      context.l10n.loginSubtitle,
                      style: TextStyles.subtitle,
                      textAlign: TextAlign.center,
                    ),
                    gapH16,
                    Form(
                      key: formKey,
                      child: Column(
                        spacing: 12,
                        children: [
                          TextFieldWithLabel(
                            label: context.l10n.email,
                            hintText: context.l10n.emailHint,
                            controller: _emailController,
                            validator: (val) =>
                                emailError ?? Validators.validateEmail(val),
                            onChanged: (val) {
                              if (emailError != null) {
                                setState(() => emailError = null);
                              }
                            },
                          ),
                          TextFieldWithLabel(
                            label: context.l10n.password,
                            hintText: context.l10n.passwordHint,
                            controller: _passwordController,
                            isPassword: true,
                            validator: (val) =>
                                passwordError ??
                                Validators.validatePasswordWhenSignIn(val),
                            onChanged: (val) {
                              if (passwordError != null) {
                                setState(() => passwordError = null);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.push(AppRoutes.forgotPassword.path),
                      child: Text(
                        context.l10n.forgotPassword,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    gapH8,
                    ElevatedButton(
                      onPressed: isLoading ? null : _signIn,
                      child: Text(context.l10n.signIn),
                    ),
                    CustomDivider(
                      centeredText: context.l10n.continueWith,
                    ),
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () => ref
                                .read(authControllerProvider.notifier)
                                .signInWithGoogle(),
                      child: isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: Sizes.p32,
                                  child: Image.asset(
                                    'assets/google-logo-png-29546.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                gapH4,
                                Text(context.l10n.continueWithGoogle),
                              ],
                            ),
                    ),
                    gapH16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.l10n.dontHaveAccount),
                        GestureDetector(
                          onTap: () => context.push(AppRoutes.signUp.path),
                          child: Text(
                            ' ${context.l10n.signUp}',
                            style: const TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    required this.centeredText,
  });
  final String centeredText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(),
        ),
        gapW8,
        Text(
          centeredText,
          style: TextStyle(color: Colors.grey[500]),
        ),
        gapW8,
        const Expanded(
          child: Divider(),
        ),
      ],
    );
  }
}
