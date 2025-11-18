import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rentapp/firebase_options.dart';
import 'package:rentapp/injection_container.dart';
import 'package:rentapp/presentation/pages/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
    initInjection();
  } catch (e) {
    print('Firebase initialization failed: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnboardingPage(),
    );
  }
}