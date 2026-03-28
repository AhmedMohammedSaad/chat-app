import 'package:chatapp/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/theme_extension.dart';
import '../../core/presentation/view/widgets/app_text_field.dart';
import '../../core/presentation/view/widgets/app_gradient_button.dart';
import '../../core/presentation/view/widgets/app_glass_container.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.secondary.withValues(alpha: 0.25),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.primary.withValues(alpha: 0.25),
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
                            "Create Account",
                            style: textStyles.headerPrimary,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Get started and explore all features.",
                            style: textStyles.headerSecondary,
                          ),
                          const SizedBox(height: 40),

                          Text("Full Name", style: textStyles.labelText),
                          const SizedBox(height: 8),
                          AppTextField(
                            hint: "Enter your name",
                            controller: authCubit.nameController,
                          ),
                          const SizedBox(height: 20),

                          Text("Email Address", style: textStyles.labelText),
                          const SizedBox(height: 8),
                          AppTextField(
                            hint: "Enter your email",
                            controller: authCubit.emailController,
                          ),
                          const SizedBox(height: 20),

                          Text("Password", style: textStyles.labelText),
                          const SizedBox(height: 8),
                          AppTextField(
                            hint: "Enter your password",
                            isPassword: true,
                            controller: authCubit.passworedController,
                          ),
                          const SizedBox(height: 30),

                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is SignupFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.errorMessage)),
                                );
                              }
                            },
                            builder: (context, state) {
                              return AppGradientButton(
                                isLoading: state is SignupLoading,
                                text: "Sign Up",
                                onPressed: () {
                                  authCubit.signUp(context);
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 30),

                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Already have an account? Login",
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
