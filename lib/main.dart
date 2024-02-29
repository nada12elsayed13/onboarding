import 'package:flutter/material.dart';
import 'package:onboarding/onBoarding/home.dart';

import 'package:onboarding/onBoarding/onBoardingView.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding")??false;

  runApp( MyApp(onboarding: onboarding));
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({super.key, this.onboarding = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor:const Color(0xffe1e1e1)),
        useMaterial3: true,
      ),
      home: onboarding? const Home() : const OnboardingView(),
    );
  }
}