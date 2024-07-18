import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String id;
  int totalAmt;
  int totalQty;
  Timestamp? timestamp = Timestamp.now();
  String? approve;
  String? uid;
 

  OrderModel({
    required this.totalAmt,
    required this.totalQty,
    required this.id,
    this.timestamp,
    this.approve,
    this.uid,
  });

  factory OrderModel.fromJson(document){
    final data = document;
    if (data.isEmpty) return OrderModel(id:'',totalAmt: 0,totalQty: 0);
    return OrderModel(
      id: data.containsKey('id') ? data['id'] : '',
      totalAmt: data['total'],
      totalQty: data['totalQty'],
      approve: data['approve'],
      timestamp: data['timestamp'],
      uid: data['uid'],

    );
  }
}

