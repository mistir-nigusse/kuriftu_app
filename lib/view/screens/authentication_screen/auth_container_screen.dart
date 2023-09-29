import 'package:flutter/material.dart';
import 'package:kuriftu_app/view/screens/authentication_screen/signup_page.dart';

class Auth_Container extends StatelessWidget {
  final child;
  const Auth_Container({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Image.asset('assets/boarding_image/kuriftuWP.jpeg'),
          Positioned(
            top: MediaQuery.of(context).size.height / 4.2,
            bottom: 0, // Align at the bottom of the stack
            left: 0, // Align to the left side
            right: 0, // Align to the right side
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              child: child,
            ),
          ),
        ],
      ),
    )));
  }
}
