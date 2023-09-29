import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuriftu_app/view/screens/authentication_screen/Login_page.dart';
import 'package:kuriftu_app/view/screens/authentication_screen/social_login.dart';
import 'package:kuriftu_app/view/screens/authentication_screen/verification_page.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import '../../components/custom_textField.dart';
import '../home_page/home_page.dart';
import 'auth_container_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup_Page extends StatefulWidget {
  const Signup_Page({super.key});

  @override
  State<Signup_Page> createState() => _Signup_PageState();
}

class _Signup_PageState extends State<Signup_Page> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool emailValidator = false;
  bool passwordValidator = false;

  register() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      print(FirebaseAuth.instance.currentUser);
      print("this is the user nameee");
      Get.to(() => Verfication_Page());
      setState(() {
        isLoading = false;
      });
      print(emailController.text + passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });

      if (e.code == 'weak-password') {
        Get.snackbar(
          'Password to short',
          'password must be 8 or more charachers, please try again',
        );
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'Account exists',
          'A user is already registered with that account, please try to login',
        );

        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

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
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Create an account',
                style: TextStyle(
                    letterSpacing: 1.3,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black54),
              ),
            ),

            SocialLogin(),
          
            Text(
              'or use your email',
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: emailController,
                label: "Email address",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email cannot be empty';
                  }
                  return null;
                },
                errorText:
                    emailValidator ? 'Please Enter valid email adress' : null,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: passwordController,
                label: "Password",
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'password cannot be empty';
                  }
                },
                errorText:
                    passwordValidator ? 'password cannot be empty' : null,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 70,
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Checkbox(
            //         value: false,
            //         onChanged: (value) {
            //           setState(() {
            //             value = true;
            //           });
            //         }),
            //     Text("Remember me"),
            //     SizedBox(
            //       width: MediaQuery.of(context).size.height / 10,
            //     ),
            //     TextButton(
            //         onPressed: () {
            //           print("forgot passd");
            //         },
            //         child: Text('Forgot password?'))
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      emailController.text.isEmpty
                          ? emailValidator = true
                          : emailValidator = false;
                      passwordController.text.isEmpty
                          ? passwordValidator = true
                          : passwordValidator = false;
                      emailController.text.contains(RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                          ? emailValidator = false
                          : emailValidator = true;
                      // userNameController.text.isEmpty
                      //     ? userNameValidator = true
                      //     : userNameValidator = false;
                    });
                    print("Register method call");
                    register();
                  },
                  child: (isLoading)
                      ? Center(
                          child: const SizedBox(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1.3,
                          ),
                        ))
                      : Text(
                          "REGISTER",
                          style: TextStyle(color: Colors.white),
                        ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width / 1.3,
                        MediaQuery.of(context).size.height / 120),
                    backgroundColor: Colors.lightBlueAccent,
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Get.to(Login_page());
                    },
                    child: Text(
                      'Login here',
                      style: TextStyle(
                          fontWeight: FontWeight.w800, letterSpacing: 0.7),
                    )),
              ],
            ),
            Text(
              "Or",
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
            TextButton(
                onPressed: () {
                  Get.to(HomePage(guest: true,));
                },
                child: Text(
                  'Continue as a guest',
                  style: TextStyle(
                      fontWeight: FontWeight.w800, letterSpacing: 0.7),
                )),
          ],
        ),
      ),
    );
  }
}
