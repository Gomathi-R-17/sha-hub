import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:rcc_project/components/constants.dart';
import 'package:rcc_project/components/text_field_container.dart';

class collectionCenter extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              nameInputField("Center Name", size, nameController),
              SizedBox(height: size.height * 0.02),
              addressInputField("Address", size, addressController),
              SizedBox(height: size.height * 0.02),
              phoneNoInputField("Phone Number", size, phoneNoController),
              SizedBox(height: size.height * 0.04),
              button("Add Centre", size, () async {
                final isValid = formKey.currentState!.validate();
                String center = nameController.text;
                String address = addressController.text;
                String mobileNo = phoneNoController.text;

                if (center.isNotEmpty &&
                    address.isNotEmpty &&
                    mobileNo.isNotEmpty) {
                  final centerdata = centerData(
                      center: center, address: address, mobileNo: mobileNo);
                  addCenterData(centerdata);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Center Added Successfully')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please Enter the Details')));
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget nameInputField(
      String hint, Size size, TextEditingController controller) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.length > 20) {
            return "Only 20 Characters Allowed";
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

  Widget addressInputField(
      String hint, Size size, TextEditingController controller) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.length < 4) {
            return "Enter atleast Four Characters";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.location_pin, color: iconcolor),
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

  Future addCenterData(centerData data) async {
    final docUser =
        FirebaseFirestore.instance.collection("collectionCenter").doc();

    final json = data.toJson();
    await docUser.set(json);
    debugPrint("success");
  }
}

class centerData {
  final String? center;
  final String? address;
  final String? mobileNo;

  centerData({
    required this.center,
    required this.address,
    required this.mobileNo,
  });

  Map<String, dynamic> toJson() => {
        'center': center,
        'address': address,
        'mobileNo': mobileNo,
      };
}
