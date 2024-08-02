import 'dart:developer';

import 'package:app_sadean_helm/components/card/card.checkout.summary.dart';
import 'package:app_sadean_helm/controller/cart.dart';
import 'package:app_sadean_helm/controller/category.dart';
import 'package:app_sadean_helm/controller/shipping.dart';
import 'package:app_sadean_helm/model/shipping.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShippingPage extends StatefulWidget {
  const ShippingPage({super.key});

  @override
  State<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage> {
  int subTotal = 0;
  int ongkir = 0;
  int total = 0;
  bool isLoading = true;
  bool isLoadingPayment = false;
  List<Shipping> dataShipping = [];
  Shipping? selectedShipping;
  String address = '';

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      int tmpTotal = ModalRoute.of(context)!.settings.arguments as int;
      setState(() {
        subTotal = tmpTotal;
        total = tmpTotal + ongkir;
      });
      // _getODCKMLFile(id);
    });
    super.initState();
    _initPage();
  }

  void _initPage() async {
    setState(() {
      isLoading = true;
    });
    ShippingResponse shippingResponse = await fetchShippingList();
    if (!shippingResponse.error) {
      setState(() {
        dataShipping = shippingResponse.data;
        isLoading = false;
      });
    }
  }

  void _eventCheckout() async {
    Map<String, dynamic> data = {
      "shipping_id": selectedShipping!.id,
      "address": address
    };
    setState(() {
      isLoadingPayment = true;
    });
    CheckoutResponse checkoutResponse = await checkoutHandler(data);
    setState(() {
      isLoadingPayment = false;
    });
    if (!checkoutResponse.error) {
      String? token = checkoutResponse.token;
      String? orderID = checkoutResponse.orderID;
      if (token != null) {
        // ignore: use_build_context_synchronously
        Map<String, dynamic> args = {'token': token, 'id': orderID};
        Navigator.pushNamed(context, "/payment", arguments: args);
      }
      log("success checkout");
    } else {
      log(checkoutResponse.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
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
                    child: isLoading
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  margin: const EdgeInsets.only(right: 5),
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.brown,
                                  ),
                                ),
                                const Text(
                                  "loading...",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.brown,
                                  ),
                                )
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: const Text(
                                      "Pilih Kota",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: DropdownButton<Shipping>(
                                      isExpanded: true,
                                      elevation: 16,
                                      value: selectedShipping,
                                      items: dataShipping
                                          .map<DropdownMenuItem<Shipping>>(
                                              (element) {
                                        return DropdownMenuItem<Shipping>(
                                          value: element,
                                          child: Text(element.city),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        log(value!.city);
                                        int tmpSubTotal = subTotal;
                                        int tmpOngkir = value.price;
                                        int tmpTotal = tmpSubTotal + tmpOngkir;
                                        setState(() {
                                          selectedShipping = value;
                                          total = tmpTotal;
                                          ongkir = tmpOngkir;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: const Text(
                                      "Alamat Lengkap",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    onChanged: (value) {
                                      // onChanged(value);
                                      setState(() {
                                        address = value;
                                      });
                                    },
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      hintText: "alamat",
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                  );
                },
              ),
            ),
            CardCheckoutSummary(
              subTotal: subTotal,
              ongkir: ongkir,
              total: total,
              onCheckout: () {
                _eventCheckout();
              },
              onLoadingCheckout: isLoadingPayment,
            )
          ],
        ),
      ),
    );
  }
}
