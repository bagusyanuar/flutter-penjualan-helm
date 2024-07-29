class Category {
  int id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(dynamic e) {
    return Category(
      id: e['id'] as int,
      name: e['name'] as String,
    );
  }
}
