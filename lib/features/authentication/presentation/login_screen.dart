import 'package:fintrack/features/authentication/logic/auth_controller.dart';
import 'package:fintrack/features/authentication/logic/loading_state.dart';
import 'package:fintrack/features/authentication/presentation/auth_field.dart';
import 'package:fintrack/utils/validators.dart';
import 'package:fintrack/routing/app_route_enum.dart';
import 'package:fintrack/theming/app_colors.dart';
import 'package:fintrack/constants/app_sizes.dart';
import 'package:fintrack/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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

  String? emailError;
  String? passwordError;

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
          setState(() => emailError = "No account found with this email");
        } else if (error.contains('credential is incorrect')) {
          setState(() => passwordError = "Password is incorrect");
        } else if (error.contains('wrong-password')) {
          setState(() => passwordError = "Incorrect password");
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
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Welcome Back',
                      style: TextStyles.title,
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'Track your wealth securely.\n Please log in to your account.',
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
                            label: 'Email Address',
                            hintText: 'name@example.com',
                            controller: _emailController,
                            errorText: emailError,
                            validator: Validators.validateEmail,
                            onChanged: (val) {
                              if (emailError != null) {
                                setState(() => emailError = null);
                              }
                            },
                          ),
                          TextFieldWithLabel(
                            label: 'Password',
                            hintText: '••••••••',
                            controller: _passwordController,
                            isPassword: true,
                            errorText: passwordError,
                            validator: Validators.validatePasswordWhenSignIn,
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
                      child: const Text(
                        'Forgot Password?',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    gapH8,
                    ElevatedButton(
                      onPressed: isLoading ? null : _signIn,
                      child: const Text('Login'),
                    ),
                    const CustomDivider(
                      centeredText: 'OR',
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
                                const Text('Continue with Google'),
                              ],
                            ),
                    ),
                    gapH16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        GestureDetector(
                          onTap: () => context.push(AppRoutes.signUp.path),
                          child: const Text(
                            ' Sign Up',
                            style: TextStyle(
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
