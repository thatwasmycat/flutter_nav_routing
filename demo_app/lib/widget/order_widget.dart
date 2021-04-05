import 'package:demo_app/model/order.dart';
import 'package:demo_app/widget/utils_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {

  final Order _order;

  OrderWidget(this._order);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _singleOrderWidget(_order),
    );
  }

  Widget _singleOrderWidget(Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Utils.nameWithPrice(name: order.name, price: order.price),
        if(order != null && order.note.isNotEmpty)
          Text("\"${order.note}\""),
        ...order.options
            .where((option) => option?.isSelected)
            .map((option) => Text("- ${option?.title}")),
        Divider(),
      ],
    );
  }



}