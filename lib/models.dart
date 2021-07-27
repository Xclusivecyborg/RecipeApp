class Recipe {
  final String name;
  final String images;
  final String totalTime;
  final double rating;

  Recipe({this.name, this.images, this.totalTime, this.rating});

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
      name: json["name"] as String,
      images: json["images"][0]['hostedLargeUrl'] as String,
      totalTime: json["totalTime"] as String,
      rating: json["rating"] as double,
    );
  }

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) => Recipe.fromJson(data)).toList();
  }

  // @override
  // String toString() {
  //   return 'Recipe name: $name, images: $images, totalTime: $totalTime, rating: $rating';
  // }
}
