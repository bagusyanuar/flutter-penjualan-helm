class Product {
  int id;
  int categoryID;
  String name;
  int price;
  int qty;
  String image;
  String description;

  Product({
    required this.id,
    required this.categoryID,
    required this.name,
    required this.image,
    required this.price,
    required this.qty,
    required this.description,
  });

  factory Product.fromJson(dynamic e) {
    return Product(
      id: e['id'] as int,
      categoryID: e['category_id'] as int,
      name: e['name'] as String,
      price: e['price'] as int,
      qty: e['qty'] as int,
      image: e['image'] as String,
      description: e['description'] as String,
    );
  }
}
