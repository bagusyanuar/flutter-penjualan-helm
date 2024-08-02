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
