class Shipping {
  int id;
  String city;
  int price;

  Shipping({
    required this.id,
    required this.city,
    required this.price,
  });

  factory Shipping.fromJson(dynamic e) {
    return Shipping(
      id: e['id'] as int,
      city: e['city'] as String,
      price: e['price'] as int,
    );
  }
}
