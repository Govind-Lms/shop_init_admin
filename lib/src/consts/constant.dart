import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final firebaseAuth = FirebaseAuth.instance;

const url = "https://fcm.googleapis.com/v1/projects/sho-pinit/messages:send";





final userRef = FirebaseFirestore.instance.collection('users');
final tokenRef = FirebaseFirestore.instance.collection('tokens');
final orderLengthRef = FirebaseFirestore.instance.collection('totalOrders');
final itemRef = FirebaseFirestore.instance.collection('items');
final orderRef = FirebaseFirestore.instance.collection('orders');
final orderListRef = FirebaseFirestore.instance.collection('orderLists');
final bannerRef = FirebaseFirestore.instance.collection("banners");


navNameReplacement(context, name) => Navigator.of(context).pushReplacementNamed(name);
navName(context, name) => Navigator.of(context).pushNamed(name);
navPop(context) => Navigator.of(context).pop(true);
nav(context, screen) => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> screen ));



String accessToken = "";
String categoryName = '';
final List<String> categoryNames = [
  'tee',
  'outerwear',
  'sneaker',
  'hoodie',
];
final List<Color> colors = [
  const Color(0xff9872f9),
  const Color(0xffff8c8d),
  const Color(0xff42c1ac),
  const Color(0xff7183ff),
];
final List<String> images = [
  'assets/category/tee.png',
  'assets/category/outerwear.png',
  'assets/category/sneaker.png',
  'assets/category/tee.png',
];
final List<double> angles = [
  -45,
  -45,
  0,
  -45,
];


final List<String> subCategoryNames = [
  'Total Sales',
  'Total Orders',
  'Total Revenues',
  'Total Customers',
];

final List<String> managementNames = [
  'Users Management',
  'Orders Management',
  'Products Management',
  'Banner Management',
];




final List<String> subCategoryNumbers = [
  '12 %',
  '14 %',
  '10 %',
  '9 %',
];

final List<String> subCategoryAmount = [
  '126000.00 Ks',
  '1237',
  '25000.00 Ks',
  '123 ',
];
final List<bool> subCategoryBools = [
  true,
  false,
  false,
  true
];