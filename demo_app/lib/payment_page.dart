import 'package:demo_app/checkout_page.dart';
import 'package:demo_app/menu_page.dart';
import 'package:demo_app/model/checkout_args.dart';
import 'package:demo_app/widget/utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentPage extends StatelessWidget {

  static const String routeName = "/payment";

  // text field controller
  final TextEditingController tfController = TextEditingController();

  PaymentPage();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        /// [Example] customize device back button
        onWillPop: () => _onWillPop(context),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Payment"),
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
                Utils.titleText("Enter your credit card info"),
                Divider(height: 20),
                _creditCardTf(),
                Divider(height: 30,),
                /// OK button
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      /// on OK button pressed
                      _onOkButtonPressed(context);
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
                /// Back-to-menu button
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.white,
                    onPressed: () {
                      /// on Back-to-menu button pressed
                      _onBackToMenuButtonPressed(context);
                    },
                    child: Text("Back to Menu",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  /* Navigation */

  /// Called when user presses back
  _onBackPressed(context) {
    /// [Example] simple pop until
    _showOnBackAlertDialog(context,() => Navigator.pop(context));
  }

  /// Called when user presses the 'OK' button
  _onOkButtonPressed(context) {
    /// [Example] simple pop with a return value
    Navigator.popUntil(context, (route) {
     if(route.settings.name == CheckoutPage.routeName) {
       (route.settings.arguments as CheckoutArgs).payment = tfController.text
           ?? "-";
       return true;
     } else
       return false;
     });
  }

  /// Called when user presses the 'Back to Menu' button
  _onBackToMenuButtonPressed(context) {
    /// [Example] pop until with argument
    Navigator.popUntil(context, ModalRoute.withName(MenuPage.routeName));
  }

  /// set actions for device back button
  Future<bool> _onWillPop(context) async {
    return _showOnBackAlertDialog(context, () => Navigator.pop(context));
  }



  /* Other functions */

  /// credit card text field
  Widget _creditCardTf() => Container(
    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
    decoration: new BoxDecoration(
      shape: BoxShape.rectangle,
      border: new Border.all(
        color: Colors.black12,
        width: 1.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white54,
    ),
    child: TextField(
      controller: tfController,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintText: "Credit card number.",
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.number,
      minLines: 1,
      maxLines: 1,
      maxLength: 12,
    ),
  );


  // ref: https://stackoverflow.com/questions/53844052/how-to-make-an-alertdialog-in-flutter
  _showOnBackAlertDialog(BuildContext context, Function yesAction) {
    // set up yes button
    Widget yesButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        // close the alert dialog
        Navigator.pop(context);
        // go back
        yesAction();
      },
    );

    // set up no button
    Widget noButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        // close the alert dialog
        Navigator.pop(context);
        /* do nothing */ },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text("You have unsaved changes which will not be saved. Are you sure you want to go back?"),
      actions: [
        noButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
