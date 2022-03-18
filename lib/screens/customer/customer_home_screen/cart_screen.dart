import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rcc_project/components/constants.dart';
import 'package:rcc_project/components/text_field_container.dart';
import 'package:rcc_project/screens/admin/admin_home_screen/collection_center.dart';

class CartScreen extends StatefulWidget {
  Map cartList = {};
  int totalQuantity;
  List cartItemsList;

  CartScreen(
      {Key? key,
      required this.cartList,
      required this.totalQuantity,
      required this.cartItemsList})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CartScreen();
  }
}

class _CartScreen extends State<CartScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneNoController = TextEditingController();

  DateTime? date;

  String? value;
  String getDate() {
    if (date == null) {
      return "Select Date";
    } else {
      return '${date!.day}/${date!.month}/${date!.year}';
    }
  }

  final collectionCentres = ["SSS Shasun Jain College"];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Map clothList = widget.cartList;

    int sareeCount = clothList['saree'];
    int tshirtCount = clothList['tshirt'];
    int shirtCount = clothList['shirt'];
    int kurtiCount = clothList['kurti'];
    int kidsClothesCount = clothList['kidsclothes'];
    int pantCount = clothList['pants'];

    String? currentUserEmail = FirebaseAuth.instance.currentUser!.email;

    String name;
    String mobileNo;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Cart",
          ),
        ),
        backgroundColor: bglight,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<User>(
                  future: currentUserDetails(currentUserEmail),
                  builder: (context, user) {
                    name = user.data!.name!;
                    mobileNo = user.data!.mobileNo!;
                    return Column(
                      children: <Widget>[
                        Container(
                          width: size.width * 0.75,
                          height: 65,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 3.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  stops: [
                                    0.0,
                                    1.0
                                  ],
                                  colors: [
                                    Color(0xFFc4cbf0),
                                    Color(0xFF8f9de4)
                                  ])),
                          child: Row(children: <Widget>[
                            SizedBox(width: size.width * 0.02),
                            Icon(Icons.person, color: iconcolor),
                            SizedBox(width: size.width * 0.04),
                            Text("${user.data!.name}",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: iconcolor,
                                    fontWeight: FontWeight.bold))
                          ]),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          width: size.width * 0.75,
                          height: 65,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 3.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  stops: [
                                    0.0,
                                    1.0
                                  ],
                                  colors: [
                                    Color(0xFFc4cbf0),
                                    Color(0xFF8f9de4)
                                  ])),
                          child: Row(children: <Widget>[
                            SizedBox(width: size.width * 0.02),
                            Icon(Icons.phone, color: iconcolor),
                            SizedBox(width: size.width * 0.04),
                            Text("${user.data!.mobileNo}",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: iconcolor,
                                    fontWeight: FontWeight.bold))
                          ]),
                        ),
                      ],
                    );
                  }),
              SizedBox(height: size.height * 0.02),
              datetimePickerButton(getDate(), size, () => pickDate(context),
                  Icons.calendar_today_rounded),
              SizedBox(height: size.height * 0.02),
              dropDown(size),
              SizedBox(height: size.height * 0.02),
              sareeCount != 0 && sareeCount != null
                  ? Text("Saree: ${widget.cartList['saree']}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold))
                  : Container(),
              SizedBox(height: 5),
              tshirtCount != 0 && tshirtCount != null
                  ? Text("T-Shirt: ${widget.cartList['tshirt']}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold))
                  : Container(),
              SizedBox(height: 5),
              shirtCount != 0 && shirtCount != null
                  ? Text("Shirt: ${widget.cartList['shirt']}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold))
                  : Container(),
              SizedBox(height: 5),
              pantCount != 0 && pantCount != null
                  ? Text("Pants: ${widget.cartList['pants']}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold))
                  : Container(),
              SizedBox(height: 5),
              kurtiCount != 0 && kurtiCount != null
                  ? Text("Kurti: ${widget.cartList['kurti']}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold))
                  : Container(),
              SizedBox(height: 5),
              kidsClothesCount != 0 && kidsClothesCount != null
                  ? Text("Kids Clothes: ${widget.cartList['kidsclothes']}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold))
                  : Container(),
              SizedBox(height: 5),
              widget.totalQuantity != 0
                  ? Text("Total Quantity: ${widget.totalQuantity}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold))
                  : Container(),
              SizedBox(height: size.height * 0.04),
              button("Donate", size, () {
                String orderDate = DateFormat.yMMMd().format(date!);
                final data = CustomerData(
                    name: '',
                    mobileNo: '',
                    date: orderDate,
                    center: value,
                    saree: sareeCount.toString(),
                    tshirt: tshirtCount.toString(),
                    shirt: shirtCount.toString(),
                    pants: pantCount.toString(),
                    kurti: kurtiCount.toString(),
                    kidsclothes: kidsClothesCount.toString(),
                    total: widget.totalQuantity.toString());
                addCustomerData(data);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Data Added Successfully")));
              }),
            ],
          ),
        ));
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
          Text(buttonName,
              style: TextStyle(
                  fontSize: 15.0,
                  color: iconcolor,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }

  Widget dropDown(Size size) {
    return Container(
      width: size.width * 0.75,
      height: 65.0,
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
        child: Text(item,
            style: TextStyle(
                fontSize: 15.0, color: iconcolor, fontWeight: FontWeight.bold)),
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

  Future<User> currentUserDetails(currentUserEmail) async {
    var query = await FirebaseFirestore.instance
        .collection("CustomerData")
        .where('email', isEqualTo: currentUserEmail)
        .get();

    var snapshot = query.docs[0];
    var data = snapshot.data();

    String name = data['name'];
    String mobileNo = data['mobileNo'];

    Map userData = {'name': name, 'mobileNo': mobileNo};

    return User.fromJson(userData);
  }

  Future addCustomerData(CustomerData data) async {
    final docUser =
        FirebaseFirestore.instance.collection("CustomerOrderData").doc();

    final json = data.toJson();
    await docUser.set(json);
  }
}

class CustomerData {
  final String? id;
  final String? name;
  final String? mobileNo;
  final String? date;
  final String? center;
  final String? saree;
  final String? tshirt;
  final String? shirt;
  final String? pants;
  final String? kurti;
  final String? kidsclothes;
  final String? total;

  CustomerData({
    this.id,
    required this.name,
    required this.mobileNo,
    required this.date,
    required this.center,
    required this.saree,
    required this.tshirt,
    required this.shirt,
    required this.pants,
    required this.kurti,
    required this.kidsclothes,
    required this.total,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mobileNo': mobileNo,
        'date': date,
        'center': center,
        'saree': saree,
        'tshirt': tshirt,
        'shirt': shirt,
        'pants': pants,
        'kurti': kurti,
        'kidsClothes': kidsclothes,
        'Total': total
      };
}

class User {
  final String? id;
  final String? name;
  final String? mobileNo;
  final String? email;
  final String? password;

  User(
      {this.id,
      required this.name,
      required this.mobileNo,
      required this.email,
      required this.password});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mobileNo': mobileNo,
        'email': email,
        'password': password
      };

  static User fromJson(Map<dynamic, dynamic> json) => User(
      name: json['name'],
      mobileNo: json['mobileNo'],
      password: json['password'],
      id: json['id'],
      email: json['email']);
}
