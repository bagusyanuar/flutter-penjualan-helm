import 'package:app_sadean_helm/model/cart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class CardCart extends StatefulWidget {
  final Cart item;
  final AsyncCallback onItemRemove;
  final VoidCallback onQtyChange;

  const CardCart({
    Key? key,
    required this.item,
    required this.onItemRemove,
    required this.onQtyChange,
  }) : super(key: key);

  @override
  State<CardCart> createState() => _CardCartState();
}

class _CardCartState extends State<CardCart> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('id');
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    textEditingController.text = widget.item.qty.toString();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(4, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(widget.item.image),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.name,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        'Rp${numberFormat.format(widget.item.price)}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.brown,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     String currentQtyString = textEditingController.text;
                      //     int currentQty = int.parse(currentQtyString);
                      //     if (currentQty > 1) {
                      //       int nextQty = currentQty - 1;
                      //       textEditingController.text = nextQty.toString();
                      //       // _onQtyChange(nextQty);
                      //       // widget.onChangeQty();
                      //     } else {
                      //       // _eventRemoveItem(context);
                      //       // _onQtyChange(0);
                      //       // _eventRemoveItemCart(context, widget.cartIndex);
                      //     }
                      //   },
                      //   child: Container(
                      //     height: 25,
                      //     width: 25,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(5),
                      //       color: Colors.brown,
                      //       border: Border.all(width: 1, color: Colors.brown),
                      //     ),
                      //     child: const Icon(
                      //       Icons.remove,
                      //       color: Colors.white,
                      //       size: 10,
                      //     ),
                      //   ),
                      // ),
                      Container(
                        height: 30,
                        width: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextField(
                          controller: textEditingController,
                          textAlign: TextAlign.center,
                          readOnly: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding: const EdgeInsets.all(1)),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     String currentQtyString = textEditingController.text;
                      //     int currentQty = int.parse(currentQtyString);
                      //     if (currentQty <= 99) {
                      //       int nextQty = currentQty + 1;
                      //       textEditingController.text = nextQty.toString();
                      //       // _onQtyChange(nextQty);
                      //       // widget.onChangeQty();
                      //     }
                      //   },
                      //   child: Container(
                      //     height: 25,
                      //     width: 25,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(5),
                      //       color: Colors.brown,
                      //       border: Border.all(width: 1, color: Colors.brown),
                      //     ),
                      //     child: const Icon(
                      //       Icons.add,
                      //       color: Colors.white,
                      //       size: 10,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // void _onQtyChange(int qty) async {
  //   Product product = Product(
  //     id: widget.item.id,
  //     name: widget.item.name,
  //     image: widget.item.image,
  //     price: widget.item.price,
  //     description: "",
  //     type: widget.item.type,
  //     items: [],
  //   );

  //   Map<String, dynamic> value = await isStoragedCartChange(product, qty);
  //   if (value['value']) {
  //     widget.onQtyChange();
  //   }
  // }

  // void _removeItemHandler(VoidCallback callback) async {
  //   Product product = Product(
  //     id: widget.item.id,
  //     name: widget.item.name,
  //     image: widget.item.image,
  //     price: widget.item.price,
  //     description: "",
  //     type: widget.item.type,
  //     items: [],
  //   );

  //   Map<String, dynamic> value = await isStoragedCartChange(product, 0);
  //   if (value['value']) {
  //     callback();
  //   }
  // }

  // void _eventRemoveItem(BuildContext rootContext) {
  //   showDialog(
  //     context: rootContext,
  //     builder: (BuildContext context) {
  //       return DialogConfirmation(
  //         title: 'Confirmation',
  //         content: 'Are you sure to remove item?',
  //         onYesTap: () {
  //           _removeItemHandler(() {
  //             Navigator.pop(context);
  //             widget.onItemRemove();
  //           });
  //         },
  //         onNoTap: () {
  //           Navigator.pop(context);
  //         },
  //       );
  //     },
  //   );
  // }
}
