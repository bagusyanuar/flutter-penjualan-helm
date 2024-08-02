import 'package:app_sadean_helm/controller/util.dart';

class Cart {
  int id;
  String name;
  String image;
  int price;
  int qty;
  int total;

  Cart({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.qty,
    required this.total,
  });

  factory Cart.fromJson(dynamic e) {
    String url = '/no-data.jpg';
    if (e['product']['image'] != null) {
      url = e['product']['image'] as String;
    }
    String image = "$hostAddress$url";
    return Cart(
      id: e['id'] as int,
      name: e['product']['name'] as String,
      price: e['price'] as int,
      qty: e['qty'] as int,
      image: image,
      total: e['total'] as int,
    );
  }
}
