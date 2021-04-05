import 'package:demo_app/model/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {

  static double calculatePrice(List<Order> orders) {
    return orders.fold(0, (sum, order) => sum + order.price);
  }

  static Widget nameWithPrice({String name, double price}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Text(name),
        ),
        Container(
          width: 60,
          child: Text("฿$price"),
        ),
      ],
    );
  }

  static Widget titleText(String text) => Text(text,
    style: TextStyle(
      color: Colors.lightBlue,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  );


}