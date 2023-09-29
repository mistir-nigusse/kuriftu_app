import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Package_detail extends StatefulWidget {
  var package;
  Package_detail({super.key, required this.package});

  @override
  State<Package_detail> createState() => _Package_detailState();
}

class _Package_detailState extends State<Package_detail> {
  @override
  Widget build(BuildContext context) {
    print("hello");
    print(widget.package.price);
    print(widget.package.descripition);

    print("ddd");
    return Scaffold(
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height / 18,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 79, 173, 192),
            ),
            onPressed: () {
              Get.snackbar("successful", "booked successfully");
            },
            child: Text(
              "BOOK",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            )),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            )),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/boarding_image/kuriftu.jpeg"))),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 33.0, 8, 23),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      widget.package.packageName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 47, 146, 192),
                          fontSize: 25),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "\$ " + widget.package.price.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 25),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 100),
              child: Text(widget.package.descripition,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
            ),
          ],
        ),
      )),
    );
  }
}
