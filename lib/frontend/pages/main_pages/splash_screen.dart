
import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:ninenty_second_per_word_app/frontend/pages/main_pages/home_page_acces_users.dart';
import 'package:ninenty_second_per_word_app/frontend/style/app_colors.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          
          child: Image.asset('assets/images/90_logo.png',))
      ),
    );
  }
}