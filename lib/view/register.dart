import 'dart:developer';

import 'package:app_sadean_helm/components/button/button-loading.dart';
import 'package:app_sadean_helm/components/images/logo.dart';
import 'package:app_sadean_helm/components/textfield/icon-passwordfield.dart';
import 'package:app_sadean_helm/components/textfield/icon-textfield.dart';
import 'package:app_sadean_helm/controller/register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String username = '';
  String password = '';
  String phone = '';
  String name = '';
  String address = '';
  bool onLoading = false;

  void _eventRegister() async {
    Map<String, String> data = {
      "username": username,
      "password": password,
      "phone": phone,
      "name": name,
      "address": address,
    };
    setState(() {
      onLoading = true;
    });
    RegisterResponse registerResponse = await registerHandler(data);
    setState(() {
      onLoading = false;
    });
    if (!registerResponse.error) {
      log("show toast");
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("token", registerResponse.accessToken);
      } catch (e) {
        log(e.toString());
      }
      Navigator.pushNamedAndRemoveUntil(
          context, "/home", ModalRoute.withName("/dashboard"));
    } else {
      Fluttertoast.showToast(
        msg: registerResponse.message,
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
                  margin: const EdgeInsets.only(bottom: 10),
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
                  child: TextfieldIcon(
                    onChanged: (value) {
                      log(value);
                      setState(() {
                        name = value;
                      });
                    },
                    icon: Icons.perm_identity_outlined,
                    placeholder: "nama lengkap",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: TextfieldIcon(
                    onChanged: (value) {
                      log(value);
                      setState(() {
                        address = value;
                      });
                    },
                    icon: Icons.home,
                    placeholder: "alamat",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextfieldIcon(
                    onChanged: (value) {
                      log(value);
                      setState(() {
                        phone = value;
                      });
                    },
                    icon: Icons.phone_android_outlined,
                    placeholder: "nomor handphone",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ButtonLoading(
                    text: "Register",
                    onLoading: onLoading,
                    onTap: () {
                      _eventRegister();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
