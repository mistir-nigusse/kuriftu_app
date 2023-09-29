class UserBookings {
  UserBookings({
    required this.bookings,
  });

  List<Bookings>? bookings;

  UserBookings.fromJson(Map<String, dynamic> json) {
    if (json['bookings'] != null) {
      bookings =
          List.from(json['bookings']).map((e) => Bookings.fromJson(e)).toList();
    } else {
      print("empty one executed");
      // case where 'Bookings' is null or missing in the JSON.
      bookings= [];
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bookings'] = bookings?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Bookings {
  Bookings(
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

  Bookings.fromJson(Map<String, dynamic> json) {
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
