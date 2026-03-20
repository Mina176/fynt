import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/features/authentication/logic/auth_controller.dart';
import 'package:fynt/features/authentication/logic/loading_state.dart';
import 'package:fynt/features/authentication/presentation/login_screen.dart';
import 'package:fynt/features/authentication/presentation/auth_field.dart';
import 'package:fynt/core/utils/validators.dart';
import 'package:fynt/core/routing/app_route_enum.dart';
import 'package:fynt/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? emailError;
  String? passwordError;

  void _signUp() async {
    setState(() {
      emailError = null;
      passwordError = null;
    });

    if (_formKey.currentState!.validate()) {
      await ref
          .read(authControllerProvider.notifier)
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            fullName: _nameController.text.trim(),
          );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;
    ref.listen(authControllerProvider, (previous, next) {
      if (next.state == LoadingStateEnum.success) {
        context.go(AppRoutes.home.path);
      } else if (next.hasError) {
        setState(() {
          emailError = next.errorMessage;
        });
      }
    });
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.kVerticalPadding,
            horizontal: Sizes.kHorizontalPadding,
          ),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  spacing: 12,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Start Tracking Today',
                      style: TextStyles.title,
                    ),
                    const Text(
                      'Take control of your finances.',
                      style: TextStyles.subtitle,
                    ),
                    gapH16,
                    Form(
                      key: _formKey,
                      child: Column(
                        spacing: 12,
                        children: [
                          TextFieldWithLabel(
                            controller: _nameController,
                            label: 'Full Name',
                            hintText: 'John Doe',
                            onSaved: (value) => _nameController.text = value!,
                            validator: (value) =>
                                value!.isEmpty ? 'Name is required' : null,
                          ),
                          TextFieldWithLabel(
                            controller: _emailController,
                            label: 'Email',
                            hintText: 'john@example.com',
                            validator: (val) =>
                                emailError ?? Validators.validateEmail(val),
                          ),
                          TextFieldWithLabel(
                            controller: _passwordController,
                            label: 'Password',
                            hintText: '••••••••',
                            isPassword: true,
                            validator: (val) =>
                                passwordError ??
                                Validators.validatePasswordWhenSignUp(val),
                          ),
                          TextFieldWithLabel(
                            label: 'Confirm Password',
                            hintText: '••••••••',
                            isPassword: true,
                            validator: (value) =>
                                Validators.validateConfirmPassword(
                                  _passwordController.text,
                                  value,
                                ),
                          ),
                          gapH4,
                          ElevatedButton(
                            onPressed: isLoading ? null : _signUp,
                            child: isLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text('Sign Up'),
                          ),
                        ],
                      ),
                    ),
                    const CustomDivider(
                      centeredText: 'Or continue with',
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
                                gapW4,
                                const Text('Continue with Google'),
                              ],
                            ),
                    ),
                    gapH4,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        GestureDetector(
                          onTap: () => context.go(AppRoutes.signIn.path),
                          child: const Text(
                            ' Log in',
                            style: TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
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
