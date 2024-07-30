import 'dart:developer';

import 'package:app_sadean_helm/components/button/button-loading.dart';
import 'package:app_sadean_helm/components/images/logo.dart';
import 'package:app_sadean_helm/components/textfield/icon-passwordfield.dart';
import 'package:app_sadean_helm/components/textfield/icon-textfield.dart';
import 'package:app_sadean_helm/controller/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';
  bool onLoading = false;

  void _eventLogin() async {
    Map<String, String> data = {
      "username": username,
      "password": password,
    };
    setState(() {
      onLoading = true;
    });
    LoginResponse loginResponse = await loginHandler(data);
    setState(() {
      onLoading = false;
    });
    if (!loginResponse.error) {
      log("show toast");
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("token", loginResponse.accessToken);
      } catch (e) {
        log(e.toString());
      }
      Navigator.pushNamedAndRemoveUntil(
          context, "/home", ModalRoute.withName("/dashboard"));
    } else {
      Fluttertoast.showToast(
        msg: loginResponse.message,
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
                    onChanged: (value) {
                      log(value);
                      setState(() {
                        username = value;
                      });
                    },
                    icon: Icons.account_circle_outlined,
                    placeholder: "username",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: PasswordfieldIcon(
                    onChanged: (value) {
                      log(value);
                      setState(() {
                        password = value;
                      });
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
}
