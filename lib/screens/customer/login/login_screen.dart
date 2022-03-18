import 'package:flutter/material.dart';
import 'package:rcc_project/components/constants.dart';
import 'package:rcc_project/screens/Customer/login/body.dart';

class CustomerLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Customer Login",
              textAlign: TextAlign.center,
            )),
        backgroundColor: bglight,
        body: Body());
  }
}
