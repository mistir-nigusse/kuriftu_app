import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuriftu_app/view/screens/authentication_screen/Login_page.dart';
import 'package:kuriftu_app/view/screens/boarding_screen/borading_page.dart';
import 'package:kuriftu_app/view/screens/home_page/home_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final controller = new PageController();
  bool isLastPage = false;
  void loadHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      final showHome = prefs.getBool('showHome') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadHome();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
              });
            },
            children: [
              Boarding_Page(
                img: "assets/boarding_image/kuriftu.jpeg",
                title: 'KURIFTU WATER PARK',
                body:
                    'Located in the town of Bishoftu, at 35 km from the capital city of Addis Abeba, Kuriftu Water Park is east Africa’s largest water park and first of its kind. Opened since August 2019, it is part of a 90 000 square meter development that includes a resort hotel and a shopping village known as Ethiopian cultural village and featuring Ethiopian arts, crafts and clothing shops.',
              ),
              Boarding_Page(
                img: "assets/boarding_image/group.jpeg",
                title: 'MORE FUN, WHEN YOU COME IN GROUP',
                body:
                    'With over 30 000 square meters of fun filled activities and rides for young and old, including a wave pool, Boomerang slide, Fekat circus and more, the water park promises to become Ethiopia’s and Africa’s premier entertainment and tourism destination.',
              ),
              Boarding_Page(
                img: "assets/boarding_image/birthday.jpeg",
                title: 'MAKE YOUR BIRTHDAY A SPLASH!',
                body:
                    'Kuriftu Water Park is the perfect destination for birthday parties for kids. All of our party packages include all day admission to the park, balloons, a birthday cake, an announcement over PA system and a birthday surprise for birthday kid (a free ticket to come back again). Plus, we take care of everything from set-up to clean up, so you, too, can enjoy the party and relax!',
              ),
            ],
          ),
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
              color: Color.fromARGB(234, 79, 173, 192),
              height: MediaQuery.of(context).size.height / 9,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: ElevatedButton(
                  child: Text('GET STARTED',
                      style: TextStyle(
                          color: Color.fromARGB(234, 79, 173, 192),
                          fontWeight: FontWeight.w900)),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('showHome', true);
                    Get.to(Login_page());
                  },
                ),
              ))
          : Container(
              color: Color.fromARGB(234, 79, 173, 192),
              height: 80,
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                      child: ElevatedButton(
                          onPressed: () => Get.to(Login_page()),
                          // onPressed: () => controller.jumpToPage(2),
                          child: Text(
                            'SKIP',
                            style: TextStyle(
                                color: Color.fromARGB(255, 79, 173, 192),
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Center(
                        child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                        spacing: 12,
                        dotHeight: 10,
                        dotWidth: 10,
                        activeDotColor: Colors.white,
                      ),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.easeIn),
                    )),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                      child: ElevatedButton(
                          onPressed: () => controller.nextPage(
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.easeIn),
                          child: Text(
                            'NEXT',
                            style: TextStyle(
                                color: Color.fromARGB(255, 79, 173, 192),
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          )),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
