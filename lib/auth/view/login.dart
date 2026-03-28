import 'package:chatapp/auth/cubit/auth_cubit.dart';
import 'package:chatapp/auth/view/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/theme_extension.dart';
import '../../core/presentation/view/widgets/app_text_field.dart';
import '../../core/presentation/view/widgets/app_gradient_button.dart';
import '../../core/presentation/view/widgets/app_glass_container.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.primary.withValues(alpha: 0.35),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.accentBlue.withValues(alpha: 0.25),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: SingleChildScrollView(
                  child: AppGlassContainer(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Welcome Back!",
                            style: textStyles.headerPrimary,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Login to continue and connect with your friends.",
                            style: textStyles.headerSecondary,
                          ),
                          const SizedBox(height: 40),

                          Text("Email Address", style: textStyles.labelText),
                          const SizedBox(height: 8),
                          AppTextField(
                            hint: "Enter your email",
                            controller: context.read<AuthCubit>().emailControllerLogin,
                          ),
                          const SizedBox(height: 20),

                          Text("Password", style: textStyles.labelText),
                          const SizedBox(height: 8),
                          AppTextField(
                            hint: "Enter your password",
                            isPassword: true,
                            controller:
                                context.read<AuthCubit>().passworedControllerLogin,
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password?",
                                style: textStyles.textButtonAction,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is LoginFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.errorMessage)),
                                );
                              }
                            },
                            builder: (context, state) {
                              return AppGradientButton(
                                isLoading: state is LoginLoading,
                                text: "Login",
                                onPressed: () {
                                  context.read<AuthCubit>().logIn();
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 30),

                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Don't have an account? Sign Up",
                                style: textStyles.textButtonPrimary.copyWith(
                                  color: colors.textButtonAction,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
