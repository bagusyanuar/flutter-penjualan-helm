import 'dart:developer';

import 'package:app_sadean_helm/components/card/card.summary.dart';
import 'package:app_sadean_helm/components/card/cart.wrapper.dart';
import 'package:app_sadean_helm/controller/cart.dart';
import 'package:app_sadean_helm/controller/util.dart';
import 'package:app_sadean_helm/model/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  MidtransSDK? _midtrans;
  NumberFormat numberFormat = NumberFormat.decimalPattern('id');
  List<Cart> dataCart = [];
  int totalPrice = 0, totalPoint = 0;
  bool isLoading = true;
  bool isLoadingCheckout = false;
  // List<Cart> carts = [];

  @override
  void initState() {
    super.initState();
    _initPage();
    // initSDK();
  }

  @override
  void dispose() {
    _midtrans?.removeTransactionFinishedCallback();
    super.dispose();
  }

  void _initPage() async {
    setState(() {
      isLoading = true;
    });
    CartListResponse cartListResponse = await getCartListHandler();
    if (!cartListResponse.error) {
      int total = 0;
      List<Cart> tmpCart = cartListResponse.data;
      for (var element in tmpCart) {
        total += element.total;
      }
      setState(() {
        dataCart = cartListResponse.data;
        totalPrice = total;
        isLoading = false;
      });
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
      appBar: AppBar(
        title: const Text("Keranjang"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double height = constraints.maxHeight;
                return RefreshIndicator(
                  child: SizedBox(
                    height: height,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: CartListWrapper(
                          onLoading: isLoading,
                          carts: dataCart,
                          onItemRemove: () async {},
                          onQtyChange: () {},
                        ),
                      ),
                    ),
                  ),
                  onRefresh: () async {},
                );
              },
            ),
          ),
          CardSummary(
            onLoading: isLoading,
            totalPoint: totalPoint,
            totalPrice: totalPrice,
            onLoadingCheckout: isLoadingCheckout,
            onCheckout: () {
              Navigator.pushNamed(context, "/shipping", arguments: totalPrice);
              // _checkout(context);
            },
          )
        ],
      )),
    );
  }
}
