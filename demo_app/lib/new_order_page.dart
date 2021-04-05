

import 'package:demo_app/widget/utils_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/dish.dart';
import 'model/option.dart';
import 'model/order.dart';

class NewOrderPage extends StatefulWidget {

  static const String routeName = "/new-order";

  // selected dish
  final Dish dish;

  NewOrderPage({this.dish});
  @override
  State createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrderPage> {

  // our order
  Order _order;

  // text field controller
  TextEditingController tfController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // initialise the order object
    _order = Order(
      name: widget.dish.name,
      price: widget.dish.price,
      note: "",
      options: widget.dish.optionTitles.map((title) => Option(title: title)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_order.name),
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
            Utils.titleText("Options"),
            _optionsWidget(_order.options),
            _noteWidget(),
            Divider(
              height: 20,
            ),
            /// Order button
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  /// on order button pressed
                  _onOrderButtonPressed(context);
                },
                child: Text("Order",
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
  
  /// Navigation ///

  /// Called when user presses back
  _onBackPressed(context) {
    /// [Example] simple pop
    Navigator.pop(context);
  }

  /// Called when user presses the 'Order' button
  _onOrderButtonPressed(context) {
    /// [Example] pop with a return object
    // set notes to the order
    _order.note = tfController.text;
    Navigator.pop(context, _order);
  }


  /* Widgets */

  Widget _optionsWidget(List<Option> options) => Column(
    children: _order.options.map((option) =>
      CheckboxListTile(
        title: Text(option.title),
        value: option.isSelected,
        onChanged: (currVal) => setState(() => option.isSelected = currVal),
      ),
    ).toList(),
  );

  Widget _noteWidget() => Container(
    padding: EdgeInsets.all(10),
    decoration: new BoxDecoration(
      shape: BoxShape.rectangle,
      border: new Border.all(
        color: Colors.black12,
        width: 1.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.white54,
    ),
    child: TextField(
      controller: tfController,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintText: "Special Instructions",
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.multiline,
      minLines: 5,
      maxLines: 5,
    ),
  );

}



