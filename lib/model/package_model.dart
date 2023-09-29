class KuriftuPackages {
  KuriftuPackages({
    required this.packages,
  });

  List<Packages>? packages;

  KuriftuPackages.fromJson(Map<String, dynamic> json) {
    if (json['packages'] != null) {
      packages =
          List.from(json['packages']).map((e) => Packages.fromJson(e)).toList();
    } else {
      print("empty one executed");
      // case where 'packages' is null or missing in the JSON.
      packages = [];
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['packages'] = packages?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Packages {
  Packages(
      {required this.packageName,
      required this.id,
      required this.descripition,
      required this.price,
      required this.url});

  String? packageName;
  int? id;
  int? price;
  String? descripition;
  String? url;

  Packages.fromJson(Map<String, dynamic> json) {
    packageName = json['packageName'];
    id = json['id'];
    price = json['price'];
    descripition = json['descripition'];
    url = json['url'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'packageName': packageName,
      'id': id,
      'price': price,
      'descripition': descripition,
      'url': url
    };
    return data;
  }
}
