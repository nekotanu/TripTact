import 'package:flutter/material.dart';
import 'package:triptact/core/constants/app_texts.dart';
import 'package:triptact/widgets/primary_button.dart';
import '../../core/constants/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/splash_screen.jpg',
            ), // use a soft sky/ocean gradient image
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromARGB(255, 255, 255, 255).withValues(alpha: 0.2),
                AppColors.primary.withValues(alpha: 0.4),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.flight,
                  color: AppColors.white,
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'TripTact',
                style: AppTextStyles.heading.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 10),
              Text(
                'Your personal AI travel companion',

                style: AppTextStyles.subheading.copyWith(
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Create perfect itineraries tailored to your\nstyle, budget, and dreams',
                style: TextStyle(color: AppColors.grey, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                text: 'Get Started',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
              const SizedBox(height: 40),
              const Text(
                'Discover • Plan • Explore',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
