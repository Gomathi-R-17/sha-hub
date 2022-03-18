import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rcc_project/components/constants.dart';
import 'package:rcc_project/components/text_field_container.dart';
import 'package:rcc_project/quantity_icon_icons.dart';
import 'package:rcc_project/screens/buyer/login/login_screen.dart';

class BuyerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
              title: Text("Home"),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                    onPressed: () async {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.pop(context);
                      });
                    },
                    icon: Icon(Icons.logout))
              ]),
          backgroundColor: bglight,
          body: Body()),
    );
  }
}

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime? date;
  TimeOfDay? time;

  String? value;

  final nameController = TextEditingController();

  final quantityController = TextEditingController();

  final phoneNoController = TextEditingController();

  final collectionCentres = ["SSS Shasun Jain College"];

  final formKey = GlobalKey<FormState>();

  String getDate() {
    if (date == null) {
      return "Select Date";
    } else {
      return '${date!.day}/${date!.month}/${date!.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
          child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.02),
                nameInputField("Name", size, nameController),
                SizedBox(height: size.height * 0.02),
                phoneNoInputField("Phone Number", size, phoneNoController),
                SizedBox(height: size.height * 0.02),
                quantityInputField("No. Of. Bags", size, quantityController,
                    QuantityIcon.quantity),
                SizedBox(height: size.height * 0.02),
                datetimePickerButton(getDate(), size, () => pickDate(context),
                    Icons.calendar_today_rounded),
                SizedBox(height: size.height * 0.02),
              ]),
          Column(children: [
            dropDown(size),
            SizedBox(height: size.height * 0.04),
            button("Place Order", size, () async {
              final isValid = formKey.currentState!.validate();
              String orderDate = DateFormat.yMMMd().format(date!);
              String name = nameController.text;
              String mobileNo = phoneNoController.text;
              String quantity = quantityController.text;

              final data = orderData(
                  name: name,
                  mobileNo: mobileNo,
                  quantity: quantity,
                  date: orderDate,
                  center: value);
              createOrderData(data);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Order Date Submitted")));
            }),
          ])
        ]),
      )),
    );
  }

  Widget nameInputField(
      String hint, Size size, TextEditingController controller) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.length < 2) {
            return "Enter atleast Two Characters";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.person, color: iconcolor),
            hintText: hint,
            hintStyle: TextStyle(color: iconcolor),
            border: InputBorder.none),
      ),
    );
  }

  Widget phoneNoInputField(
      String hint, Size size, TextEditingController controller) {
    return TextFieldContainer(
      child: TextFormField(
        validator: (value) {
          if (value!.length < 10 || value.length > 10) {
            return "Phone Number should contain 10 digits";
          } else {
            return null;
          }
        },
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.phone, color: iconcolor),
            hintText: hint,
            hintStyle: TextStyle(color: iconcolor),
            border: InputBorder.none),
      ),
    );
  }

  Widget quantityInputField(
      String hint, Size size, TextEditingController controller, IconData icon) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(icon, color: iconcolor),
            hintText: hint,
            hintStyle: TextStyle(color: iconcolor),
            border: InputBorder.none),
      ),
    );
  }

  Widget button(String buttonName, Size size, VoidCallback press) {
    return ElevatedButton(
      onPressed: press,
      child: Text(buttonName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(300)),
          primary: bgcolor,
          fixedSize: Size(size.width * 0.75, 50.0)),
    );
  }

  Widget datetimePickerButton(
      String buttonName, Size size, VoidCallback press, IconData icon) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: size.width * 0.75,
        height: 65,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.0, 1.0],
                colors: [Color(0xFFc4cbf0), Color(0xFF8f9de4)])),
        child: Row(children: <Widget>[
          SizedBox(width: size.width * 0.02),
          Icon(icon, color: iconcolor),
          SizedBox(width: size.width * 0.04),
          Text(buttonName, style: TextStyle(fontSize: 15.0, color: iconcolor))
        ]),
      ),
    );
  }

  Widget dropDown(Size size) {
    return Container(
      width: size.width * 0.75,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3.0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 1.0],
              colors: [Color(0xFFc4cbf0), Color(0xFF8f9de4)])),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            value: value,
            items: collectionCentres.map(buildMenuItem).toList(),
            onChanged: (value) => setState(() => this.value = value)),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item, style: TextStyle(fontSize: 15.0, color: iconcolor)),
      );

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (newDate == null) {
      return;
    } else {
      setState(() => date = newDate);
    }
  }

  Future createOrderData(orderData data) async {
    final docUser =
        FirebaseFirestore.instance.collection("BuyerOrderData").doc();

    final json = data.toJson();
    await docUser.set(json);
  }
}

class orderData {
  final String? name;
  final String? mobileNo;
  final String? quantity;
  final String? date;
  final String? center;

  orderData(
      {required this.name,
      required this.mobileNo,
      required this.quantity,
      required this.date,
      required this.center});

  Map<String, dynamic> toJson() => {
        'name': name,
        'mobileNo': mobileNo,
        'quantity': quantity,
        'date': date,
        'center': center,
      };
}
