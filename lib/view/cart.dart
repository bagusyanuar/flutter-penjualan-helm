import 'dart:developer';

import 'package:app_sadean_helm/controller/cart.dart';
import 'package:app_sadean_helm/controller/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  MidtransSDK? _midtrans;

  @override
  void initState() {
    super.initState();
    // initSDK();
  }

  @override
  void dispose() {
    _midtrans?.removeTransactionFinishedCallback();
    super.dispose();
  }

  void _eventCheckout() async {
    Map<String, dynamic> data = {
      "shipping_id": 1,
      "address": "jl. hos cokroaminoto"
    };

    CheckoutResponse checkoutResponse = await checkoutHandler(data);
    if (!checkoutResponse.error) {
      String? token = checkoutResponse.token;
      if (token != null) {
        Navigator.pushNamed(context, "/payment", arguments: token);
      }
      log("success checkout");
    } else {
      log(checkoutResponse.message);
    }
  }

  void initSDK() async {
    _midtrans = await MidtransSDK.init(
      config: MidtransConfig(
        clientKey: 'SB-Mid-client-nlCokSIKTSAVV-1R',
        merchantBaseUrl: '$hostApiAddress/check-token/',
        colorTheme: ColorTheme(
          colorPrimary: Colors.blue,
          colorPrimaryDark: Colors.blue,
          colorSecondary: Colors.red,
        ),
      ),
    );
    _midtrans?.setUIKitCustomSetting(
      skipCustomerDetailsPages: true,
    );
    _midtrans!.setTransactionFinishedCallback((result) {
      log(result.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            child: Text("Checkout"),
            onPressed: () {
              // _midtrans?.startPaymentUiFlow(
              //   token: 'b1c42287-df92-498a-b4d7-417d4a0de478',
              // );
              _eventCheckout();
            },
          ),
        ),
      ),
    );
  }
}
