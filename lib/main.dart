import 'package:chatapp/auth/cubit/auth_cubit.dart';
import 'package:chatapp/auth/view/login.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/home/cubit/home_cubit.dart';
import 'package:chatapp/home/view/home_screen.dart';
import 'package:chatapp/core/theme/app_theme.dart';
import 'package:chatapp/core/theme/cubit/theme_cubit.dart';
import 'package:chatapp/core/theme/cubit/theme_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: "https://iatbhhxrqyjuubfdhlst.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlhdGJoaHhycXlqdXViZmRobHN0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQ3MjYxMTcsImV4cCI6MjA5MDMwMjExN30.J42DGrskDMeqpigbdvuGrNpu5hzYdnLUsr48OhgJv6o",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => HomeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ChatApp',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.themeMode,
            home: FirebaseAuth.instance.currentUser != null
                ? const HomeScreen()
                : const LoginScreen(),
          );
        },
      ),
    );
  }
}
