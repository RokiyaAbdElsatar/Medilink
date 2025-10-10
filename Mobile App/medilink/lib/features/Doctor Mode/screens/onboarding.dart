import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:medilink/core/constant/appcolor.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Widget buildImage(String path) {
    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColor.gradientColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 100,
            child: Image.asset(
              path,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.broken_image,
                  size: 40,
                  color: Colors.grey,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Color(AppColor.background),
      pages: [
        PageViewModel(
          title: "Chat with Your Patients",
          body: "Stay in touch, answer questions, and offer guidance.",
          image: buildImage("assets/images/onboardingpatient.png"),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              color: Color(AppColor.primary),
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            bodyTextStyle: TextStyle(
              color: Color(AppColor.textPrimary),
              fontSize: 16.0,
            ),
            imagePadding: EdgeInsets.only(top: 40),
            contentMargin: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
        PageViewModel(
          title: "Know Their History",
          body:
              "View each patient’s medical background and past consultations in one place.",
          image: buildImage("assets/images/patientreport.png"),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              color: Color(AppColor.primary),
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            bodyTextStyle: TextStyle(
              color: Color(AppColor.textPrimary),
              fontSize: 16.0,
            ),
            imagePadding: EdgeInsets.only(top: 40),
            contentMargin: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
        PageViewModel(
          title: "Set Your Availability",
          body:
              "Easily choose when you're available patients book at times that suit you.",
          image: buildImage("assets/images/availability.png"),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              color: Color(AppColor.primary),
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            bodyTextStyle: TextStyle(
              color: Color(AppColor.textPrimary),
              fontSize: 16.0,
            ),
            imagePadding: EdgeInsets.only(top: 40),
            contentMargin: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ],
      onDone: () {
        Navigator.of(context).pushReplacementNamed('/login');
      },
      done: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: Color(AppColor.primary),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 6,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text("Get Started", style: TextStyle(color: Colors.white)),
      ),
      showSkipButton: true,
      skip: const Text(
        "Skip",
        style: TextStyle(color: Color(AppColor.textHint)),
      ),
      onSkip: () {
        Navigator.of(context).pushReplacementNamed('/login');
      },
      next: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: Color(AppColor.primary),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 6,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text("Next", style: TextStyle(color: Colors.white)),
      ),

      dotsDecorator: DotsDecorator(
        activeColor: Color(AppColor.primary),
        color: Color(AppColor.background),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Color(AppColor.primary), width: 1.5),
        ),
        size: const Size(12, 12),
        activeSize: const Size(30, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
      controlsPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 16),
    );
  }
}
