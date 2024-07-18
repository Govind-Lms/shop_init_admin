
import 'package:flutter/material.dart';
import 'package:shop_init_admin/src/consts/constant.dart';

class Filter {

  final ValueNotifier<String> statusFilter = ValueNotifier<String>("");


  final ValueNotifier<Stream> streamQuery = ValueNotifier<Stream>(orderListRef.orderBy('timestamp',descending: true).snapshots());
}