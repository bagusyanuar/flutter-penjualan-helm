import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TopNavbar extends StatelessWidget {
  final double height;
  final Color backgroundColor;
  final Color color;
  final String username;

  const TopNavbar(
      {Key? key,
      this.height = 40,
      this.backgroundColor = Colors.red,
      this.color = Colors.white,
      this.username = 'Customer'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(username)
              ],
            ),
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        'https://blogunik.com/wp-content/uploads/2018/01/Tatjana-Saphira-1.jpg'),
                    fit: BoxFit.cover),
              ),
            )
          ],
        ),
      ),
    );
  }
}
