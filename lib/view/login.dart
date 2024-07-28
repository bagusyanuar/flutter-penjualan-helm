import 'dart:developer';

import 'package:app_sadean_helm/components/button/button-loading.dart';
import 'package:app_sadean_helm/components/images/logo.dart';
import 'package:app_sadean_helm/components/textfield/icon-passwordfield.dart';
import 'package:app_sadean_helm/components/textfield/icon-textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';
  bool onLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const LogoContainer(),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: TextfieldIcon(
                    onChanged: (params) {
                      log(params);
                    },
                    icon: Icons.account_circle_outlined,
                    placeholder: "username",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: PasswordfieldIcon(
                    onChanged: (params) {
                      log(params);
                    },
                    icon: Icons.lock_outline,
                    placeholder: "password",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ButtonLoading(
                    text: "Login",
                    onLoading: onLoading,
                    onTap: () {
                      _eventLogin();
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: const Text(
                        "Belum Punya Akun?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _eventLogin() async {
    setState(() {
      onLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      onLoading = false;
    });
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(
        context, "/home", ModalRoute.withName("/home"));
  }
}
