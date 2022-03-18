import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rcc_project/components/NamedIcon.dart';
import 'package:rcc_project/components/constants.dart';
import 'package:rcc_project/screens/customer/customer_home_screen/cart_screen.dart';
import 'package:rcc_project/screens/customer/login/login_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int sareeCount = 0;
  int tshirtCount = 0;
  int shirtCount = 0;
  int kurtiCount = 0;
  int kidsClothesCount = 0;
  int pantCount = 0;

  final shoppingCart = {
    "saree": 0,
    "tshirt": 0,
    "shirt": 0,
    "pants": 0,
    "kurti": 0,
    "kidsclothes": 0
  };

  int totalQuantity = 0;
  @override
  Widget build(BuildContext context) {
    final cartItemList = [
      sareeCount,
      tshirtCount,
      shirtCount,
      pantCount,
      kurtiCount,
      kidsClothesCount
    ];

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Text("Home"),
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            actions: [
              totalQuantity != 0
                  ? NamedIcon(
                      text: "Cart",
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CartScreen(
                                cartList: shoppingCart,
                                totalQuantity: totalQuantity,
                                cartItemsList: cartItemList,
                              ))),
                      iconData: Icons.shopping_cart,
                      notificationCount: totalQuantity)
                  : IconButton(
                      onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
              IconButton(
                  onPressed: () async {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.pop(context);
                    });
                  },
                  icon: Icon(Icons.logout))
            ]),
        backgroundColor: bglight,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.02),
                  sareeTile(
                    size,
                    "assets/images/saree.jpg",
                    "Saree",
                  ),
                  SizedBox(height: size.height * 0.02),
                  tshirtTile(
                    size,
                    "assets/images/t-shirt.png",
                    "T-Shirt",
                  ),
                  SizedBox(height: size.height * 0.02),
                  shirtTile(
                    size,
                    "assets/images/shirt.png",
                    "Shirt",
                  ),
                  SizedBox(height: size.height * 0.02),
                  pantsTile(size, "assets/images/pants.png", "Pants"),
                  SizedBox(height: size.height * 0.02),
                  kurtiTile(
                    size,
                    "assets/images/kurti.png",
                    "Kurti",
                  ),
                  SizedBox(height: size.height * 0.02),
                  kidsClothesTile(
                    size,
                    "assets/images/kids_clothes.png",
                    "Kids Clothes",
                  ),
                  SizedBox(height: size.height * 0.02),
                ]),
          ),
        ));
  }

  Widget sareeTile(Size size, String imgName, String clName) {
    return Container(
      height: size.height * 0.25,
      width: size.width * 0.90,
      child: Card(
          color: Color(0xFFc4cbf0),
          elevation: 1.0,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(imgName,
                          width: size.width * 0.25, height: size.height * 0.25),
                    ),
                    Column(children: <Widget>[
                      SizedBox(height: size.height * 0.02),
                      Text(clName,
                          style: TextStyle(
                              color: iconcolor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: size.height * 0.06),
                      Row(
                        children: <Widget>[
                          sareeCount != 0
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: iconcolor),
                                  onPressed: () {
                                    setState(() {
                                      sareeCount--;
                                      shoppingCart['saree'] = sareeCount;
                                      print(shoppingCart['saree']);
                                      totalQuantity--;
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove_outlined,
                                  ),
                                )
                              : Container(),
                          SizedBox(width: size.width * 0.05),
                          Text(sareeCount != 0 ? "$sareeCount" : "Add",
                              style: TextStyle(
                                  color: iconcolor,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(width: size.width * 0.05),
                          ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: iconcolor),
                              onPressed: () {
                                setState(() {
                                  sareeCount++;
                                  shoppingCart['saree'] = sareeCount;
                                  print(shoppingCart['saree']);
                                  totalQuantity++;
                                });
                              },
                              child: Icon(Icons.add))
                        ],
                      )
                    ])
                  ]))),
    );
  }

  Widget tshirtTile(Size size, String imgName, String ClName) {
    return Container(
      height: size.height * 0.25,
      width: size.width * 0.90,
      child: Card(
          color: Color(0xFFc4cbf0),
          elevation: 1.0,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(imgName,
                          width: size.width * 0.25, height: size.height * 0.25),
                    ),
                    Column(children: <Widget>[
                      SizedBox(height: size.height * 0.02),
                      Text(ClName,
                          style: TextStyle(
                              color: iconcolor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: size.height * 0.06),
                      Row(
                        children: <Widget>[
                          tshirtCount != 0
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: iconcolor),
                                  onPressed: () {
                                    setState(() {
                                      tshirtCount--;
                                      shoppingCart['tshirt'] = tshirtCount;
                                      totalQuantity--;
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove_outlined,
                                  ),
                                )
                              : Container(),
                          SizedBox(width: size.width * 0.05),
                          Text(tshirtCount != 0 ? "$tshirtCount" : "Add",
                              style: TextStyle(
                                  color: iconcolor,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(width: size.width * 0.05),
                          ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: iconcolor),
                              onPressed: () {
                                setState(() {
                                  tshirtCount++;
                                  shoppingCart['tshirt'] = tshirtCount;
                                  totalQuantity++;
                                });
                              },
                              child: Icon(Icons.add))
                        ],
                      )
                    ])
                  ]))),
    );
  }

  Widget shirtTile(Size size, String imgName, String ClName) {
    return Container(
      height: size.height * 0.25,
      width: size.width * 0.90,
      child: Card(
          color: Color(0xFFc4cbf0),
          elevation: 1.0,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(imgName,
                          width: size.width * 0.25, height: size.height * 0.25),
                    ),
                    Column(children: <Widget>[
                      SizedBox(height: size.height * 0.02),
                      Text(ClName,
                          style: TextStyle(
                              color: iconcolor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: size.height * 0.06),
                      Row(
                        children: <Widget>[
                          shirtCount != 0
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: iconcolor),
                                  onPressed: () {
                                    setState(() {
                                      shirtCount--;
                                      shoppingCart['shirt'] = shirtCount;
                                      totalQuantity--;
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove_outlined,
                                  ),
                                )
                              : Container(),
                          SizedBox(width: size.width * 0.05),
                          Text(shirtCount != 0 ? "$shirtCount" : "Add",
                              style: TextStyle(
                                  color: iconcolor,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(width: size.width * 0.05),
                          ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: iconcolor),
                              onPressed: () {
                                setState(() {
                                  shirtCount++;
                                  shoppingCart['shirt'] = shirtCount;
                                  totalQuantity++;
                                });
                              },
                              child: Icon(Icons.add))
                        ],
                      )
                    ])
                  ]))),
    );
  }

  Widget pantsTile(Size size, String imgName, String ClName) {
    return Container(
      height: size.height * 0.25,
      width: size.width * 0.90,
      child: Card(
          color: Color(0xFFc4cbf0),
          elevation: 1.0,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(imgName,
                          width: size.width * 0.25, height: size.height * 0.25),
                    ),
                    Column(children: <Widget>[
                      SizedBox(height: size.height * 0.02),
                      Text(ClName,
                          style: TextStyle(
                              color: iconcolor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: size.height * 0.06),
                      Row(
                        children: <Widget>[
                          pantCount != 0
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: iconcolor),
                                  onPressed: () {
                                    setState(() {
                                      pantCount--;
                                      shoppingCart['pant'] = pantCount;
                                      totalQuantity--;
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove_outlined,
                                  ),
                                )
                              : Container(),
                          SizedBox(width: size.width * 0.05),
                          Text(pantCount != 0 ? "$pantCount" : "Add",
                              style: TextStyle(
                                  color: iconcolor,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(width: size.width * 0.05),
                          ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: iconcolor),
                              onPressed: () {
                                setState(() {
                                  pantCount++;
                                  shoppingCart['pant'] = pantCount;
                                  totalQuantity++;
                                });
                              },
                              child: Icon(Icons.add))
                        ],
                      )
                    ])
                  ]))),
    );
  }

  Widget kurtiTile(Size size, String imgName, String ClName) {
    return Container(
      height: size.height * 0.25,
      width: size.width * 0.90,
      child: Card(
          color: Color(0xFFc4cbf0),
          elevation: 1.0,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(imgName,
                          width: size.width * 0.25, height: size.height * 0.25),
                    ),
                    Column(children: <Widget>[
                      SizedBox(height: size.height * 0.02),
                      Text(ClName,
                          style: TextStyle(
                              color: iconcolor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: size.height * 0.06),
                      Row(
                        children: <Widget>[
                          kurtiCount != 0
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: iconcolor),
                                  onPressed: () {
                                    setState(() {
                                      kurtiCount--;
                                      shoppingCart['kurti'] = kurtiCount;
                                      totalQuantity--;
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove_outlined,
                                  ),
                                )
                              : Container(),
                          SizedBox(width: size.width * 0.05),
                          Text(kurtiCount != 0 ? "$kurtiCount" : "Add",
                              style: TextStyle(
                                  color: iconcolor,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(width: size.width * 0.05),
                          ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: iconcolor),
                              onPressed: () {
                                setState(() {
                                  kurtiCount++;
                                  shoppingCart['kurti'] = kurtiCount;
                                  totalQuantity++;
                                });
                              },
                              child: Icon(Icons.add))
                        ],
                      )
                    ])
                  ]))),
    );
  }

  Widget kidsClothesTile(Size size, String imgName, String ClName) {
    return Container(
      height: size.height * 0.25,
      width: size.width * 0.90,
      child: Card(
          color: Color(0xFFc4cbf0),
          elevation: 1.0,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(imgName,
                          width: size.width * 0.25, height: size.height * 0.25),
                    ),
                    Column(children: <Widget>[
                      SizedBox(height: size.height * 0.02),
                      Text(ClName,
                          style: TextStyle(
                              color: iconcolor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: size.height * 0.06),
                      Row(
                        children: <Widget>[
                          kidsClothesCount != 0
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: iconcolor),
                                  onPressed: () {
                                    setState(() {
                                      kidsClothesCount--;
                                      shoppingCart['kidsclothes'] =
                                          kidsClothesCount;
                                      totalQuantity--;
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove_outlined,
                                  ),
                                )
                              : Container(),
                          SizedBox(width: size.width * 0.05),
                          Text(
                              kidsClothesCount != 0
                                  ? "$kidsClothesCount"
                                  : "Add",
                              style: TextStyle(
                                  color: iconcolor,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(width: size.width * 0.05),
                          ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: iconcolor),
                              onPressed: () {
                                setState(() {
                                  kidsClothesCount++;
                                  shoppingCart['kidsclothes'] =
                                      kidsClothesCount;
                                  totalQuantity++;
                                });
                              },
                              child: Icon(Icons.add))
                        ],
                      )
                    ])
                  ]))),
    );
  }
}
