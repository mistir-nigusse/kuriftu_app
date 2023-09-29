import 'package:get/state_manager.dart';
import 'package:kuriftu_app/model/bookings_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BookingController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  var isLoading = true.obs;
  UserBookings? userBookings;
  final apiUrl = Uri.parse('https://kuriftu.hasura.app/api/rest/bookings');
  final apiKey =
      "k5CofBoD4eDCAG4VCL469xQ5ciua4RCcoeYOabGYLdcsMEMLlOj9iQG7H0rt15Oh";
  // final apiHost = "booking-com.p.rapidapi.com";

  fetchData() async {
    try {
      final response = await http.get(
        apiUrl,
        headers: {
          'x-hasura-admin-secret': apiKey,
        },
      );

      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        userBookings = UserBookings.fromJson(jsonString);
        print(userBookings!.toJson());
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading(false);
    }
  }
}
