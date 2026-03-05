import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/auth/view/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final TextEditingController emailController = TextEditingController(),
      passworedController = TextEditingController(),
      nameController = TextEditingController();

  final TextEditingController emailControllerLogin = TextEditingController(),
      passworedControllerLogin = TextEditingController();

  @override
  Future<void> close() async {
    emailController.dispose();
    passworedController.dispose();
    nameController.dispose();
    emailControllerLogin.dispose();
    passworedControllerLogin.dispose();
    super.close();
  }

  // signup
  Future<void> signUp(BuildContext context) async {
    final instance = FirebaseAuth.instance;
    emit(SignupLoading());
    try {
      //1 create user
      await instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passworedController.text,
      );
      //2 get id
      final user = instance.currentUser!.uid;
      // 3 set data in firestore
      await FirebaseFirestore.instance.collection("user").doc(user).set({
        "id": user,
        "name": nameController.text,
        "email": emailController.text,
      });
      //!
      if (!context.mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );

      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignupFailure(errorMessage: e.message ?? "Error"));
    } catch (e) {
      emit(SignupFailure(errorMessage: e.toString()));
    }
  }

  Future<void> logIn() async {
    final instance = FirebaseAuth.instance;
    emit(LoginLoading());
    try {
      //1 login
      await instance.signInWithEmailAndPassword(
        email: emailControllerLogin.text.trim(),
        password: passworedControllerLogin.text.trim(),
      );

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(errorMessage: e.message ?? "Error"));
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}
