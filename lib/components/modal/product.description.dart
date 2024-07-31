import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModalProductDescription extends StatelessWidget {
  final String description;
  final String image;
  final bool onLoading;

  const ModalProductDescription({
    super.key,
    required this.description,
    required this.onLoading,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black45,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
