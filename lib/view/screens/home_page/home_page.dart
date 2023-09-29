import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuriftu_app/view/components/custom_tabs.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kuriftu_app/view/screens/authentication_screen/Login_page.dart';
import 'package:twitter_login/twitter_login.dart';

class HomePage extends StatefulWidget {
  final bool guest;
  const HomePage({super.key, required this.guest});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  final twitterLogin = TwitterLogin(
    apiKey: 'p4oxKhVC4DwAchYosdVoTqs6B',
    apiSecretKey: '2yuY5kH27R3AclxEt9OJmtlgbisvrt15Lnbw4Rs2eqZOEHmxJZ',
    redirectURI: 'flutter-twitter-login://',
  );
  final googleSignIn = GoogleSignIn();
  Future logout() async {
    try {
      if (user!.providerData[0].providerId == "google.com") {
        await googleSignIn.disconnect();
        print('logged out google too');
      }
      FirebaseAuth.instance.signOut();

      print('logged out successfully');
      Get.to(Login_page());
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "DISCOVER",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: widget.guest
                            ? TextButton(
                                onPressed: () {
                                  Get.to(Login_page());
                                },
                                child: Text("login"))
                            : IconButton(
                                onPressed: () {
                                  _showSimpleDialog();
                                },
                                icon: Icon(
                                  Icons.account_circle,
                                  color:
                                      const Color.fromARGB(255, 120, 207, 247),
                                  size: 50,
                                )),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                    child: Text(
                      "An exciting place for childrens and adults alike!",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color.fromARGB(255, 66, 64, 64)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0, 0),
                child: SearchBar(
                  shadowColor: MaterialStatePropertyAll(Colors.lightBlueAccent),
                  surfaceTintColor:
                      MaterialStatePropertyAll(Colors.transparent),
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(252, 206, 239, 255)),
                  hintText: "Search for packages, things to do....",
                  leading: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Expanded(child: Custom_tabs())
          ],
        ),
      ),
    );
  }

  Future<void> _showSimpleDialog() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Account information'),
            children: <Widget>[
              Text('You are logged in as : '),
              Text(user?.displayName ?? ' '),
              SimpleDialogOption(
                onPressed: () {
                  logout();
                },
                child: const Text('Logout'),
              ),
            ],
          );
        });
  }
}
