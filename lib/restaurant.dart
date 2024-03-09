class Restaurant {
  String alias;
  int distance;
  //List<String> cats;

  Restaurant({required this.alias, required this.distance});

  getTitle() {
    return alias;
  }

  getDistance() {
    return distance;
  }

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    var obj = json['categories'];
    return Restaurant(
      alias: json['businesses']['alias'],
      distance: json['businesses']['distance'],
      //cats: List<String>.from(obj),
    );
  }
}
