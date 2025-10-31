import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/views/Patient_personal.dart';
import 'package:medilink/views/navigation_screen.dart';
import 'package:medilink/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _loginUser() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 🔹 Sign in with Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 🔹 Fetch user document from Firestore (optional)
      final uid = userCredential.user!.uid;
      final doc = await _firestore.collection('patients').doc(uid).get();

      if (doc.exists) {
        // ✅ Navigate to HomeScreen on success
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No user data found in database")),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = "Login failed. Please try again.";

      if (e.code == 'user-not-found') {
        message = "No user found with that email.";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password.";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email format.";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(AppColor.textSecondary),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60.h),

                /// Logo & Text
                LayoutBuilder(
                  builder: (context, constraints) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth,
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10.w,
                        runSpacing: 5.h,
                        children: [
                          SizedBox(
                            width: 110.w,
                            height: 110.w,
                            child: Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.contain,
                              cacheWidth: 300,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20.h),
                              Text(
                                "Medilink",
                                style: TextStyle(
                                  color: Color(AppColor.primary),
                                  fontSize: 52.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Where Care Meets Connection",
                                style: TextStyle(
                                  color: Color(AppColor.textPrimary),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),

                SizedBox(height: 55.h),

                /// Email
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle: TextStyle(
                      color: Color(AppColor.primary),
                      fontSize: 22.sp,
                    ),
                    hintStyle: TextStyle(
                      color: Color(AppColor.textHint),
                      fontSize: 16.sp,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(AppColor.primary)),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(AppColor.primary)),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),

                SizedBox(height: 45.h),

                /// Password
                TextField(
                  controller: _passwordController,
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
                      fontSize: 22.sp,
                    ),
                    hintStyle: TextStyle(
                      color: Color(AppColor.textHint),
                      fontSize: 16.sp,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(AppColor.primary)),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(AppColor.primary)),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Add password reset feature later
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    ),
                  ),
                ),

                SizedBox(height: 45.h),

                /// Login Button
                _isLoading
                    ? const CircularProgressIndicator(color: Colors.blue)
                    : CustomButton(title: 'Log In', onPressed: _loginUser),

                SizedBox(height: 40.h),

                /// Signup Row
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4.w,
                  children: [
                    Text(
                      "Don’t Have An Account? ",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(AppColor.textHint),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color(AppColor.textPrimary),
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
