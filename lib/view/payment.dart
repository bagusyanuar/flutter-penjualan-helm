import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  MidtransSDK? _midtrans;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      String id = ModalRoute.of(context)!.settings.arguments as String;
      log("Argument Value $id");
      // _getODCKMLFile(id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
