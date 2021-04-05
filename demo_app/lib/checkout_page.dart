import 'package:demo_app/menu_page.dart';
import 'package:demo_app/model/checkout_args.dart';
import 'package:demo_app/payment_page.dart';
import 'package:demo_app/widget/order_widget.dart';
import 'package:demo_app/widget/utils_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/order.dart';

class CheckoutPage extends StatefulWidget {

  static const String routeName = "/checkout";

  final List<Order> _orders;


  CheckoutPage(this._orders);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  String _payment = "-";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        /// Back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            /// on back button pressed
            _onBackPressed(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Utils.titleText("Your Orders"),
            Divider(height: 20,),
            Column(
              children: widget._orders.map((order) => OrderWidget(order)).toList(),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Utils.titleText("Total:${Utils.calculatePrice(widget._orders)} ฿"),
            ),
            Divider(height: 20,),
            Container(
              child: Utils.titleText("Payment: ${_payment ?? '-'}"),
            ),
            /// Payment button
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.white,
                onPressed: () {
                  /// on confirm button pressed
                  _onPaymentButtonPressed(context);
                },
                child: Text("Payment",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            /// Confirm button
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  /// on confirm button pressed
                  _onConfirmButtonPressed(context);
                },
                child: Text("Confirm",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Called when user presses back
  _onBackPressed(context) {
    /// [Example] simple pop
    Navigator.pop(context);
  }

  /// Called when user presses the 'Confirm' button
  _onConfirmButtonPressed(context) {
    /// [Example] pushNamedAndRemoveUntil
    // In this case, we want to remove all routes in the stack and push a new MenuPage route
    Navigator.pushNamedAndRemoveUntil(context, MenuPage.routeName, (route) => false);
  }

  /// Called when user presses the 'Confirm' button
  _onPaymentButtonPressed(context) async {

    /// [Example] Named route without arguments
    await Navigator.pushNamed(context, PaymentPage.routeName);

    /// [Example] Manually retrieve arguments from settings
    final CheckoutArgs args =
      ModalRoute.of(context).settings.arguments as CheckoutArgs;
    setState( () => _payment = args.payment);
  }
}
