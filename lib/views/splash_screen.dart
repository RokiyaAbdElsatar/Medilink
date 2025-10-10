import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medilink/constant/appcolor.dart';
import 'package:medilink/views/navigation_screen.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  String _title = "";
  final String _fullTitle = "Medilink";

  String _subtitle = "";
  final String _fullSubtitle = "Where care meets connection";

  bool _showCursor = true;
  bool _startShimmer = false;

  Timer? _cursorTimer;
  Timer? _typingTimerTitle;
  Timer? _typingTimerSubtitle;
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    // Shimmer controller (plays once)
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Step 1: Start typing title
    Future.delayed(const Duration(milliseconds: 800), () {
      _startTypingTitle();
    });

    // Cursor blinking for subtitle
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!mounted) return;
      setState(() => _showCursor = !_showCursor);
    });
  }

  void _startTypingTitle() {
    int index = 0;
    _typingTimerTitle = Timer.periodic(const Duration(milliseconds: 120), (
      timer,
    ) {
      if (!mounted) return;
      if (index < _fullTitle.length) {
        setState(() {
          _title += _fullTitle[index];
        });
        index++;
      } else {
        timer.cancel();

        // After title finishes, start subtitle
        Future.delayed(const Duration(milliseconds: 550), () {
          _startTypingSubtitle();
        });
      }
    });
  }

  void _startTypingSubtitle() {
    int index = 0;
    _typingTimerSubtitle = Timer.periodic(const Duration(milliseconds: 70), (
      timer,
    ) {
      if (!mounted) return;
      if (index < _fullSubtitle.length) {
        setState(() {
          _subtitle += _fullSubtitle[index];
        });
        index++;
      } else {
        timer.cancel();

        // Step 4: Trigger shimmer ONCE after subtitle
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) {
            setState(() => _startShimmer = true);
            _shimmerController.forward(); // play shimmer one time
          }

          // Step 5: Navigate when shimmer finishes
          _shimmerController.addStatusListener((status) {
            if (status == AnimationStatus.completed && mounted) {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 700),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const NavigationScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        final offsetAnimation =
                            Tween<Offset>(
                              begin: const Offset(-1.0, 0.0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOutCubic,
                              ),
                            );
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                ),
              );
            }
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _cursorTimer?.cancel();
    _typingTimerTitle?.cancel();
    _typingTimerSubtitle?.cancel();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(AppColor.primary),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 800),
                child: _startShimmer
                    ? Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Color(AppColor.primary),
                        period: const Duration(seconds: 1),
                        direction: ShimmerDirection.ltr,
                        enabled: true,
                        loop: 1,
                        child: const Image(
                          image: AssetImage("assets/images/medilink1.png"),
                          width: 150,
                          height: 150,
                        ),
                      )
                    : const Image(
                        image: AssetImage("assets/images/medilink1.png"),
                        width: 150,
                        height: 150,
                      ),
              ),

              const SizedBox(height: 20),

              Text(
                _title,
                style: TextStyle(
                  fontSize: 38,
                  color: Color(AppColor.textSecondary),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _subtitle,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(AppColor.textSecondary),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _showCursor ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      "|",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(AppColor.textSecondary),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
