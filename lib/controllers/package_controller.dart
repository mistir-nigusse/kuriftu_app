import 'package:get/state_manager.dart';
import 'package:kuriftu_app/model/package_model.dart';
import 'package:kuriftu_app/services/user_services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PackageController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  var isLoading = true.obs;
  KuriftuPackages? kuriftuPackages;
  final apiUrl = Uri.parse('https://kuriftu.hasura.app/api/rest/packages');
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
        kuriftuPackages = KuriftuPackages.fromJson(jsonString);
        print(kuriftuPackages!.toJson());
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
