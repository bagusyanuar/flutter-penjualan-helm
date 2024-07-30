import 'package:app_sadean_helm/controller/util.dart';

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
    String url = e['image'] as String;
    String image = "$hostAddress$url";
    return Product(
      id: e['id'] as int,
      categoryID: e['category_id'] as int,
      name: e['name'] as String,
      price: e['price'] as int,
      qty: e['qty'] as int,
      image: image,
      description: e['description'] as String,
    );
  }
}
