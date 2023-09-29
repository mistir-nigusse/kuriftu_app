import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuriftu_app/controllers/booking_controller.dart';

class BookingList extends StatefulWidget {
  const BookingList({super.key});

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  final BookingController bookingController = Get.put(BookingController());

  @override
  void initState() {
    bookingController.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Obx(() => bookingController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: bookingController.userBookings?.bookings?.length,
                itemBuilder: (context, index) {
                  var name = bookingController.userBookings?.bookings;
                  return Container(
                    child: ListTile(
                      hoverColor: Color.fromARGB(102, 64, 195, 255),
                      leading: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Image.asset("assets/icons/logo.png"),
                      ),
                      title: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Text(
                          bookingController
                                  .userBookings?.bookings![index].packageName!
                                  .toUpperCase() ??
                              'Package Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 47, 146, 192)),
                        ),
                      ),
                      subtitle: Text(
                        "\$" + " ${bookingController.userBookings?.bookings![index].price}" ??
                            'Package Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ),
                  );
                })));
  }
}
