import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kuriftu_app/view/screens/authentication_screen/Login_page.dart';
import 'package:kuriftu_app/view/screens/home_page/home_page.dart';

class Verfication_Page extends StatefulWidget {
  const Verfication_Page({super.key});

  @override
  State<Verfication_Page> createState() => _Verfication_PageState();
}

class _Verfication_PageState extends State<Verfication_Page> {
  late Timer timer;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    user!.sendEmailVerification();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });

    return Scaffold(
      body: Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Text(
                'An Email has been sent to ${user!.email}, please verify before you continue',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Text('To back to login page, '),
                  TextButton(
                      onPressed: () {
                        Get.to(() {
                          Login_page();
                        });
                      },
                      child: Text(' Click here'))
                ],
              )
            ],
          ),
        )),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    await user!.reload();
    if (user!.emailVerified) {
      print("user verified");
      Get.to(HomePage(guest: false,));
    } else {
      print("user not verified yet");
    }
  }
}
