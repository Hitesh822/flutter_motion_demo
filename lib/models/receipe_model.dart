class ReceipeModel {
  final String name;
  final String author;
  final String image;
  final List<String> ingredients;
  final List<String> directions;

  ReceipeModel({
    required this.name,
    required this.author,
    required this.image,
    required this.ingredients,
    required this.directions,
  });

  factory ReceipeModel.fromJSON(Map<String, dynamic> data) {
    return ReceipeModel(
      name: data['name'],
      author: data['author'],
      image: data['image'],
      ingredients: List<String>.from(data['ingredients']),
      directions: List<String>.from(data['directions']),
    );
  }
}
