import 'package:flutter/material.dart';
import 'package:medilink/constant/appcolor.dart';
import 'package:medilink/views/chat_screen.dart';
import 'package:medilink/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppColor.textSecondary),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: 110,
                      height: 110,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                        cacheWidth: 300,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "Medilink",
                        style: TextStyle(
                          color: Color(AppColor.primary),
                          fontSize: 52,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Where Care Meets Connection",
                        style: TextStyle(
                          color: Color(AppColor.textPrimary),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 55),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter Your Email',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                    color: Color(AppColor.primary),
                    fontSize: 22,
                  ),
                  hintStyle: TextStyle(
                    color: Color(AppColor.textHint),
                    fontSize: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(AppColor.primary)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(AppColor.primary)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 45),
              TextField(
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color(AppColor.primary),
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  labelText: 'Password',
                  hintText: 'Enter Your Password',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                    color: Color(AppColor.primary),
                    fontSize: 22,
                  ),
                  hintStyle: TextStyle(
                    color: Color(AppColor.textHint),
                    fontSize: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(AppColor.primary)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(AppColor.primary)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Color(AppColor.grey)),
                  ),
                ),
              ),
              const SizedBox(height: 45),
              CustomButton(
                title: 'Log In',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                  );
                },
              ),

              const SizedBox(height: 50),
              Column(
                children: [
                  Row(
                    children: const [
                      SizedBox(width: 5),
                      Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Or Login with",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Color(AppColor.border),
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSocialButton('assets/images/facebook.png'),
                      SizedBox(width: 8),
                      _buildSocialButton('assets/images/google.png'),
                      SizedBox(width: 8),
                      _buildSocialButton('assets/images/apple.png'),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don’t Have An Account? ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(AppColor.textHint),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(AppColor.textPrimary),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildSocialButton(String assetPath) {
    return Container(
      width: 120,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Color(AppColor.border)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Image.asset(assetPath, width: 70, height: 40)),
    );
  }
}
