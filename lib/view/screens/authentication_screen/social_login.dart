import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:kuriftu_app/view/screens/home_page/home_page.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialLogin extends StatefulWidget {
  const SocialLogin({super.key});

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  GoogleSignIn googleAuth = new GoogleSignIn();

  bool _isLoggedIn = false;
  Map _userObj = {};

  Future twitterLogin() async {
    final twitterLogin = TwitterLogin(
      apiKey: 'p4oxKhVC4DwAchYosdVoTqs6B',
      apiSecretKey: '2yuY5kH27R3AclxEt9OJmtlgbisvrt15Lnbw4Rs2eqZOEHmxJZ',
      redirectURI: 'flutter-twitter-login://',
    );
    final authResult = await twitterLogin.login();
    final AuthCredential credential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!);
    await FirebaseAuth.instance.signInWithCredential(credential);
    Get.to(HomePage(guest: false,));
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child:           Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      print("facebook");
                      FacebookAuth.instance.login(permissions: [
                        "publice_profile",
                        "email"
                      ]).then((value) {
                        FacebookAuth.instance
                            .getUserData()
                            .then((userData) async {
                          setState(() {
                            _isLoggedIn = true;
                            _userObj = userData;
                          });
                        });
                      });
                    },
                    icon: Image.asset("assets/icons/facebook.png")),
                IconButton(
                    onPressed: () {
                      print("google");
                      googleAuth.signIn().then((result) {
                        result!.authentication.then((googleKey) => {
                          
                              FirebaseAuth.instance
                                  .signInWithCredential(
                                      GoogleAuthProvider.credential(
                                          idToken: googleKey.idToken,
                                          accessToken: googleKey.accessToken))
                                  .then((signedInUser) {
                                print(
                                    'Signed in as ${signedInUser.user!.displayName}');
                                Get.to(HomePage(guest: false,));
                              }).catchError((e) {
                                print(e);
                              })
                            });
                      });
                    },
                    icon: Image.asset("assets/icons/google.png")),
                IconButton(
                    onPressed: () async {
                      print("twitter");
                      await twitterLogin();
                    },
                    icon: Image.asset("assets/icons/twitter.png")),
              ],
            ),
    );
  }
}