import 'package:flutter/material.dart';

class Counter {
  final ValueNotifier<int> quantity = ValueNotifier<int>(1);

  void incrementCount() {
    quantity.value++;
  }
  void descrementCount() {
    quantity.value--;
  }
}
