//twittwr
//api key p4oxKhVC4DwAchYosdVoTqs6B
//api key secret 2yuY5kH27R3AclxEt9OJmtlgbisvrt15Lnbw4Rs2eqZOEHmxJZ

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuriftu_app/view/components/custom_textField.dart';
import 'package:kuriftu_app/view/screens/authentication_screen/auth_container_screen.dart';
import 'package:kuriftu_app/view/screens/authentication_screen/signup_page.dart';
import 'package:kuriftu_app/view/screens/authentication_screen/social_login.dart';
import 'package:kuriftu_app/view/screens/authentication_screen/verification_page.dart';
import 'package:kuriftu_app/view/screens/home_page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

// client id b1ZxbUxTRVhYOUF2RThFNFEtNW06MTpjaQ
// client secret xlKmvmhmKKntxfOWnh-fqskFZgJR8pc9-foRSXnzCbEEeYhEj3
class Login_page extends StatefulWidget {
  const Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  void logIn() async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      if (userCredential.user!.emailVerified == true) {
        Get.to(() => HomePage(guest: false,));
      } else {
        Get.to(() => Verfication_Page());
      }

      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      Get.snackbar('Invalid login credential',
          'Incorrect email address or password, please register if you do not have account',
          backgroundColor: Colors.white, colorText: Colors.red);
      print('No user found for that email.');

      emailController.clear();
      passwordController.clear();
    }
  }

  bool isLoading = false;
  bool emailValidator = false;
  bool passowrdValidator = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Auth_Container(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Login to you account',
                style: TextStyle(
                    letterSpacing: 0,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black54),
              ),
            ),
            SocialLogin(),
            ////
            Text(
              'or use your email',
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: CustomTextField(
                  controller: emailController,
                  errorText: emailValidator
                      ? 'Please enter a correct format email'
                      : null,
                  label: "Email address"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: CustomTextField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Email';
                  }
                  return null;
                },
                errorText:
                    passowrdValidator ? 'Password cannot be empty' : null,
                controller: passwordController,
                label: "Password",
                obscureText: true,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                    value: false,
                    onChanged: (value) {
                      setState(() {
                        value = true;
                      });
                    }),
                Text("Remember me"),
                SizedBox(
                  width: MediaQuery.of(context).size.height / 10,
                ),
                TextButton(
                    onPressed: () {
                      print("forgot passd");
                    },
                    child: Text('Forgot password?'))
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    emailController.text.isEmpty
                        ? emailValidator = true
                        : emailValidator = false;
                    passwordController.text.isEmpty
                        ? passowrdValidator = true
                        : passowrdValidator = false;
                    emailController.text.contains(RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                        ? emailValidator = false
                        : emailValidator = true;
                  });

                  logIn();
                },
                child: (isLoading)
                    ? Center(
                        child: const SizedBox(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1.3,
                        )),
                      )
                    : Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white),
                      ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width / 1.3,
                      MediaQuery.of(context).size.height / 120),
                  backgroundColor: Colors.lightBlueAccent,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dont't have an account? "),
                TextButton(
                    onPressed: () {
                      Get.to(Signup_Page());
                    },
                    child: Text('Register here')),
              ],
            ),
            Text("Or"),
            TextButton(
                onPressed: () {
                  Get.to(HomePage(guest: true,));
                },
                child: Text('Continue as a guest')),
          ],
        ),
      ),
    );
  }
}
