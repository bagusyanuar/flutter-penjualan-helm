import 'dart:developer';

import 'package:app_sadean_helm/components/button/button-loading.dart';
import 'package:app_sadean_helm/components/images/logo.dart';
import 'package:app_sadean_helm/components/textfield/icon-passwordfield.dart';
import 'package:app_sadean_helm/components/textfield/icon-textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                  margin: const EdgeInsets.only(bottom: 10),
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
                  child: TextfieldIcon(
                    onChanged: (params) {
                      log(params);
                    },
                    icon: Icons.perm_identity_outlined,
                    placeholder: "nama lengkap",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextfieldIcon(
                    onChanged: (params) {
                      log(params);
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
                      setState(() {
                        onLoading = true;
                      });
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
