import 'package:flutter/material.dart';

class Boarding_Page extends StatelessWidget {
  final img;
  final title;
  final body;

  const Boarding_Page(
      {super.key, required this.img, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.asset(img),
          Positioned(
            top: MediaQuery.of(context).size.height / 2.5,
            bottom: 0, // Align at the bottom of the stack
            left: 0, // Align to the left side
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(234, 79, 173, 192),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 30),
                      ),
                    ),
                    Text(
                      body,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
