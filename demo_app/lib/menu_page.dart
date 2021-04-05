import 'package:demo_app/checkout_page.dart';
import 'package:demo_app/model/checkout_args.dart';
import 'package:demo_app/new_order_page.dart';
import 'package:demo_app/widget/order_widget.dart';
import 'package:demo_app/widget/utils_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/dish.dart';
import 'model/order.dart';

class MenuPage extends StatefulWidget {

  static const String routeName = "/menu";

  final title = "Menu";

  // Our menu (mock)
  final List<Dish> menu = [
    Dish(name: "Cappuccino", price: 45, optionTitles: ["Soy milk", "No sugar"]),
    Dish(name: "Iced Chocolate", price: 40, optionTitles: [
      "Add caramel",
      "Add whipped cream",
      "Add ice cream"
    ]),
  ];

  @override
  State createState() => _MenuState();

}

class _MenuState extends State<MenuPage> {

  // user's orders
  List<Order> orders = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      /// [Example] Disable device back button
      onWillPop: () => Future<bool>.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: Container(
            child: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                // basically, just clear our state (our orders)
                setState(() => orders.clear() ); },
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              _menuWidget(context, widget.menu),
              if(orders.isNotEmpty)
                _ordersWidget(context, orders),
            ],
          ),
        ),
      ),
    );
  }


  /// Navigation ///

  /// Called when user choose an item to order
  _onItemClicked(context, Dish selectedDish) async {

    /// [Example] Anonymous route with parameters
    Order newOrder = await Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => NewOrderPage(dish: selectedDish)));

    /// [Example] set state from the result
    if(newOrder != null) {
      setState(() {
        orders.add(newOrder);
      });
    }
  }

  /// Called when user presses the 'Checkout' button
  _onGotoCheckout(context) async {
    /// [Example] Named route with arguments
    Navigator.pushNamed(context, CheckoutPage.routeName,
        arguments: CheckoutArgs(orders: orders));
  }



  /* Widgets */

  /// Display our menu, which is a list of our dishes/drinks
  Widget _menuWidget(context, List<Dish> dishes) {
    return Expanded(
      child: Column(
        children: dishes.map((dish) => _singleDish(context, dish)).toList()
      ),
    );
  }

  /// Widget of each dish/drink
  Widget _singleDish(context, Dish dish) {
    return InkWell(
      splashColor: Colors.black12,
      onTap: () => _onItemClicked(context, dish),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
                width: double.infinity,
                height: 30,
                child: Utils.nameWithPrice(name: dish.name, price: dish.price),
            ),
          ),
          Divider(
            height: 0,
            thickness: 1,
          ),
        ],
      )
    );
  }

  /// Display our order list
  Widget _ordersWidget(context, List<Order> orders) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: 40,
              child: Text("Your Orders",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Divider(),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 150.0),
              child: ListView(
                children: orders.map( (order) => OrderWidget(order)).toList(),
              ),
            ),
            _checkoutWidget(context),
          ],
        ),
      ),
    );
  }

  /// Checkout layout including total price and a checkout button
  Widget _checkoutWidget(context) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 5),
      color: Colors.white,
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Text("Total:  ${Utils.calculatePrice(orders).toStringAsFixed(2)}  ฿",
              style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          if(Utils.calculatePrice(orders) > 0)
            Container(
              width: 100,
              child: RaisedButton(
                onPressed: () => _onGotoCheckout(context),
                color: Colors.lightBlue,
                child: Text("Checkout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

}



