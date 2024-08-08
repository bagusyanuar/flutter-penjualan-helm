import 'dart:developer';

import 'package:app_sadean_helm/components/card/cart.wrapper.dart';
import 'package:app_sadean_helm/components/order/wrapper.dart';
import 'package:app_sadean_helm/controller/order.dart';
import 'package:app_sadean_helm/model/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isLoading = true;
  List<Order> dataOrder = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPage();
  }

  void _initPage() async {
    setState(() {
      isLoading = true;
    });
    OrderListResponse orderListResponse = await getOrderListHandler();
    if (!orderListResponse.error) {
      setState(() {
        dataOrder = orderListResponse.data;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Belanja"),
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
                                    horizontal: 20, vertical: 20),
                                child: OrderListWrapper(
                                  onLoading: isLoading,
                                  orders: dataOrder,
                                  onOrderTap: (id) {
                                    Navigator.pushNamed(
                                        context, "/history-detail",
                                        arguments: id);
                                  },
                                ),
                              ),
                            ),
                    ),
                    onRefresh: () async {
                      _initPage();
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: ((value) {
          if (value == 0) {
            Navigator.pushNamed(context, "/home");
          } else if (value == 2) {
            Navigator.pushNamedAndRemoveUntil(
                context, "/login", ModalRoute.withName("/login"));
          }
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout"),
        ],
        currentIndex: 1,
      ),
    );
  }
}
