import 'package:app_sadean_helm/controller/util.dart';

class Order {
  int id;
  String date;
  String referenceNumber;
  int total;
  int status;

  Order({
    required this.id,
    required this.date,
    required this.referenceNumber,
    required this.total,
    required this.status,
  });

  factory Order.fromJson(dynamic e) {
    return Order(
      id: e['id'] as int,
      date: e['date'] as String,
      referenceNumber: e['reference_number'] as String,
      total: e['total'] as int,
      status: e['status'] as int,
    );
  }
}

class OrderDetail {
  int id;
  String date;
  String referenceNumber;
  String shippingCity;
  String shippingAddress;
  int subTotal;
  int shipping;
  int total;
  int status;
  List<OrderCart> carts;

  OrderDetail({
    required this.id,
    required this.date,
    required this.referenceNumber,
    required this.shippingCity,
    required this.shippingAddress,
    required this.subTotal,
    required this.shipping,
    required this.total,
    required this.status,
    required this.carts,
  });

  factory OrderDetail.fromJson(dynamic e) {
    List<dynamic> tmpResponseCarts = e['cart'] as List<dynamic>;

    List<OrderCart> tmpCarts =
        tmpResponseCarts.map((e) => OrderCart.fromJson(e)).toList();
    return OrderDetail(
      id: e['id'] as int,
      date: e['date'] as String,
      referenceNumber: e['reference_number'] as String,
      shippingCity: e['shipping_city'] as String,
      shippingAddress: e['shipping_address'] as String,
      subTotal: e['sub_total'] as int,
      shipping: e['shipping'] as int,
      total: e['total'] as int,
      status: e['status'] as int,
      carts: tmpCarts,
    );
  }
}

class OrderCart {
  String productName;
  String productImage;
  int qty;
  int price;
  int total;

  OrderCart({
    required this.productName,
    required this.productImage,
    required this.qty,
    required this.price,
    required this.total,
  });

  factory OrderCart.fromJson(dynamic e) {
    String url = '/no-data.jpg';
    if (e['product']['image'] != null) {
      url = e['product']['image'] as String;
    }
    String image = "$hostAddress$url";
    return OrderCart(
      productName: e['product']['name'] as String,
      productImage: image,
      qty: e['qty'] as int,
      price: e['price'] as int,
      total: e['total'] as int,
    );
  }
}
