class Category {
  int id;
  String name;
  String image;

  Category({this.id, this.name, this.image});

  Category.fromJson(
    Map<String, dynamic> json,
  ) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
