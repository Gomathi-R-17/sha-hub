import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomerReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CustomerData>>(
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

SingleChildScrollView dataBody(List<CustomerData> orderData) {
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
                Center(child: Text(buyerOrderData.saree!)),
              ),
              DataCell(
                Center(child: Text(buyerOrderData.tshirt!)),
              ),
              DataCell(
                Center(child: Text(buyerOrderData.shirt!)),
              ),
              DataCell(
                Center(child: Text(buyerOrderData.pants!)),
              ),
              DataCell(
                Center(child: Text(buyerOrderData.kurti!)),
              ),
              DataCell(
                Center(child: Text(buyerOrderData.kidsclothes!.toString())),
              ),
              DataCell(
                Center(child: Text(buyerOrderData.total!.toString())),
              ),
            ]),
          )
          .toList(),
    ),
  );
}

class CustomerData {
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

  static CustomerData fromJson(Map<String, dynamic> json) => CustomerData(
      name: json['name'],
      mobileNo: json['mobileNo'],
      date: json['date'],
      center: json['center'],
      saree: json['saree'],
      tshirt: json['tshirt'],
      shirt: json['shirt'],
      pants: json['pants'],
      kurti: json['kurti'],
      kidsclothes: json['kidsClothes'],
      total: json['total']);
}

Stream<List<CustomerData>> readUsers() => FirebaseFirestore.instance
    .collection('CustomerOrderData')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => CustomerData.fromJson(doc.data())).toList());
