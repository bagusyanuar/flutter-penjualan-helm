class Product {
  int id;
  String name;
  String image;
  int price;
  int qty;
  String description;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.qty,
    required this.description,
  });

  factory Product.fromJson(dynamic e) {
    return Product(
      id: e['id'] as int,
      name: e['name'] as String,
      image: e['image'] as String,
      price: e['price'] as int,
      qty: e['qty'] as int,
      description: e['description'] as String,
    );
  }
}
