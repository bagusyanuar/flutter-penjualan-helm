import 'package:app_sadean_helm/view/cart.dart';
import 'package:app_sadean_helm/view/history.dart';
import 'package:app_sadean_helm/view/home.dart';
import 'package:app_sadean_helm/view/login.dart';
import 'package:app_sadean_helm/view/payment.dart';
import 'package:app_sadean_helm/view/register.dart';
import 'package:app_sadean_helm/view/shipping.dart';
import 'package:app_sadean_helm/view/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/cart': (context) => const CartPage(),
        '/shipping': (context) => const ShippingPage(),
        '/payment': (context) => const PaymentPage(),
        '/history': (context) => const HistoryPage(),
      },
    );
  }
}
