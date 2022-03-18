import 'package:flutter/material.dart';
import 'package:rcc_project/components/constants.dart';
import 'package:rcc_project/screens/admin/login/login_screen.dart';
import 'package:rcc_project/screens/buyer/login/login_screen.dart';
import 'package:rcc_project/screens/customer/customer_home_screen/customer_home_screen.dart';
import 'package:rcc_project/screens/customer/login/login_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: ColoredBox(
      color: bglight,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
          Widget>[
        Image.asset("assets/images/shasun-logo.png", height: size.height * 0.2),
        Image.asset("assets/images/donate_clothes.png",
            width: size.width * 1.0, height: size.height * 0.4),
        SizedBox(height: size.height * 0.02),
        Text("Want to Donate Clothes ?",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15.0)),
        SizedBox(height: size.height * 0.02),
        Text("Then, you have come to the right place!",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15.0)),
        SizedBox(height: size.height * 0.03),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          button("ADMIN", size, () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AdminLoginScreen()));
          }),
          SizedBox(width: size.width * 0.1),
          button("CUSTOMER", size, () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CustomerLoginScreen()));
          })
        ]),
        SizedBox(height: size.height * 0.03),
        button("BUYER", size, () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => BuyerLoginScreen()));
        })
      ]),
    ));
  }

  Widget button(String buttonName, Size size, VoidCallback press) {
    return ElevatedButton(
      onPressed: press,
      child: Text(buttonName, style: TextStyle(fontWeight: FontWeight.w700)),
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(300)),
          primary: bgcolor,
          fixedSize: Size(size.width * 0.40, 50.0)),
    );
  }
}
