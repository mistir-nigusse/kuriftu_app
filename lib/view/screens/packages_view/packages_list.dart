import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuriftu_app/view/screens/packages_view/packages_detail.dart';
import 'package:kuriftu_app/controllers/package_controller.dart';

class PackagesList extends StatefulWidget {
  const PackagesList({super.key});

  @override
  State<PackagesList> createState() => _PackagesListState();
}

class _PackagesListState extends State<PackagesList> {
  final PackageController packageController = Get.put(PackageController());

  @override
  void initState() {
    packageController.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Obx(() => packageController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: packageController.kuriftuPackages?.packages?.length,
                itemBuilder: (context, index) {
                  var name = packageController.kuriftuPackages?.packages;
                  return Container(
                    child: ListTile(
                      hoverColor: Color.fromARGB(102, 64, 195, 255),
                      onTap: () {
                        Get.to(Package_detail(
                            package: packageController
                                .kuriftuPackages?.packages![index]));
                      },
                      leading: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Image.asset("assets/icons/logo.png"),
                      ),
                      title: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Text(
                          packageController.kuriftuPackages?.packages![index]
                                  .packageName!
                                  .toUpperCase() ??
                              'Package Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 47, 146, 192)),
                        ),
                      ),
                      subtitle: Text(
                        "\$" + " ${packageController.kuriftuPackages?.packages![index].price}" ??
                            'Package Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ),
                  );
                })));
 
 
  }
}
