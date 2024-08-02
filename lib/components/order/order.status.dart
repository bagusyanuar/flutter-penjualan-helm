import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrderStatus extends StatelessWidget {
  final int status;
  const OrderStatus({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String statusText = '-';
    Color statusColor = Colors.blue;
    switch (status) {
      case 0:
        statusText = 'Belum dibayar';
        statusColor = Colors.red.shade400;
        break;
      case 1:
        statusText = 'Terbayar';
        statusColor = Colors.blue.shade400;
        break;
      case 2:
        statusText = 'Proses';
        statusColor = Colors.orange.shade400;
        break;
      case 3:
        statusText = 'Di Kirim';
        statusColor = Colors.orange.shade400;
        break;
      case 4:
        statusText = 'Selesai';
        statusColor = Colors.green.shade400;
        break;
      default:
    }
    return Container(
      width: double.infinity,
      height: 20,
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          statusText,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
