import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class buyerReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<orderData>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(5), child: dataBody(data!)),
                )
              ],
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          }
        });
  }
}

SingleChildScrollView dataBody(List<orderData> orderData) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: DataTable(
      dividerThickness: 0,
      headingTextStyle:
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      dataTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: 'Noto Sans',
      ),
      sortColumnIndex: 0,
      showCheckboxColumn: false,
      columns: [
        DataColumn(label: Center(child: Text("Date")), numeric: false),
        DataColumn(
          label: Expanded(child: Center(child: Text("Name"))),
          numeric: false,
        ),
        DataColumn(
          label: Center(child: Text("Phone No")),
          numeric: false,
        ),
        DataColumn(
          label: Center(child: Text("Center")),
          numeric: false,
        ),
        DataColumn(
          label: Center(child: Text("No of Bags")),
          numeric: false,
        )
      ],
      rows: orderData
          .map(
            (buyerOrderData) => DataRow(cells: [
              DataCell(Center(child: Text(buyerOrderData.date!))),
              DataCell(
                Center(child: Text(buyerOrderData.name!)),
              ),
              DataCell(
                Center(child: Text(buyerOrderData.mobileNo!)),
              ),
              DataCell(
                Center(child: Text(buyerOrderData.center!)),
              ),
              DataCell(
                Center(child: Text(buyerOrderData.quantity!)),
              ),
            ]),
          )
          .toList(),
    ),
  );
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

  static orderData fromJson(Map<String, dynamic> json) => orderData(
      name: json['name'],
      mobileNo: json['mobileNo'],
      quantity: json['quantity'],
      date: json['date'],
      center: json['center']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'mobileNo': mobileNo,
        'quantity': quantity,
        'date': date,
        'center': center,
      };
}

Stream<List<orderData>> readUsers() => FirebaseFirestore.instance
    .collection('BuyerOrderData')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => orderData.fromJson(doc.data())).toList());
