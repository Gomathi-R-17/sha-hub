import 'package:flutter/material.dart';
import 'package:rcc_project/components/constants.dart';
import 'package:rcc_project/screens/buyer/login/body.dart';

class BuyerLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Buyer Login",
            )),
        backgroundColor: bglight,
        body: Body());
  }
}
