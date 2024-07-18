import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  String id;
  String name;
  int quantity;
  int price;
  String category;
  int stocks;
  String? color;
  String? size;
  String imageUrl;
  int totalPrice;
  Timestamp? timestamp = Timestamp.now();

  CartModel({
    required this.imageUrl,
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.category,
    required this.stocks,
    required this.color,
    required this.size,
    required this.totalPrice,
    this.timestamp,
  });

  factory CartModel.fromJson(Map<String, dynamic> document) {
    final doc = document;
    return 
         CartModel(
            imageUrl: doc['imageUrl'],
            id: doc['id'],
            name: doc['name'],
            quantity: doc['quantity'],
            price: doc['price'],
            category: doc['category'],
            stocks: doc['stocks'],
            color: doc['color'],
            size: doc['size'],
            totalPrice: doc['totalPrice'],
          );
  }
}
