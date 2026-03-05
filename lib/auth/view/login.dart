import 'package:chatapp/auth/cubit/auth_cubit.dart';
import 'package:chatapp/auth/view/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Back Button
                  const SizedBox(height: 30),

                  /// Header + Image
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Hello, Welcome Back",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Happy to see you again, to use your\naccount please login first.",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),

                  const SizedBox(height: 40),

                  /// Email
                  const Text("Email Address", style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: context.read<AuthCubit>().emailControllerLogin,
                  ),

                  const SizedBox(height: 20),

                  /// Password
                  const Text("Password", style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 8),
                  _buildTextField(
                    isPassword: true,
                    controller: context
                        .read<AuthCubit>()
                        .passworedControllerLogin,
                  ),

                  const SizedBox(height: 10),

                  /// Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password",
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Don't have an account? SignUp",
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// Login Button
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        debugPrint("login success");
                      }
                      if (state is LoginFailure) {
                        debugPrint(state.errorMessage);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7B1FA2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {
                            context.read<AuthCubit>().logIn();
                          },
                          child: state is LoginLoading
                              ? Center(child: CircularProgressIndicator())
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),

                  /// Divider
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildTextField({
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 210, 209, 209),

        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
