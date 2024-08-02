import 'dart:developer';

import 'package:app_sadean_helm/controller/order.dart';
import 'package:app_sadean_helm/controller/util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String snapToken = '';
  String orderID = '';
  MidtransSDK? _midtrans;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      String tmpSnapToken = args['token'];
      String tmpOrderID = args['id'];
      setState(() {
        snapToken = tmpSnapToken;
        orderID = tmpOrderID;
      });
      // _getODCKMLFile(id);
    });
    super.initState();
    initSDK();
  }

  void initSDK() async {
    _midtrans = await MidtransSDK.init(
      config: MidtransConfig(
        clientKey: 'SB-Mid-client-nlCokSIKTSAVV-1R',
        merchantBaseUrl: '$hostApiAddress/',
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
      _setSuccessPayment();
      log(result.toString());
    });
  }

  void _setSuccessPayment() async {
    OrderSuccessResponse orderSuccessResponse =
        await orderSuccessHandler(orderID);
    if (!orderSuccessResponse.error) {
      Fluttertoast.showToast(
        msg: 'successfully order',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushNamedAndRemoveUntil(
          context, "/home", ModalRoute.withName("/home"));
    } else {
      Fluttertoast.showToast(
        msg: orderSuccessResponse.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double height = constraints.maxHeight;
                  return SizedBox(
                    height: height,
                    width: double.infinity,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 300,
                            width: 250,
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/payment-bg.png"),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: const Offset(4, 4), // changes position of shadow
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  _midtrans?.startPaymentUiFlow(
                    token: snapToken,
                  );
                  // if (!onLoadingCheckout) {
                  //   onCheckout();
                  // }
                },
                child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Bayar',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
