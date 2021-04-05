import 'package:demo_app/checkout_page.dart';
import 'package:demo_app/model/checkout_args.dart';
import 'package:demo_app/new_order_page.dart';
import 'package:demo_app/menu_page.dart';
import 'package:demo_app/payment_page.dart';
import 'package:flutter/material.dart';
import 'model/order.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MenuPage(),
      initialRoute: '/menu',
      onGenerateRoute: generateRoute,
    );
  }

  // ref: https://medium.com/flutter-community/clean-navigation-in-flutter-using-generated-routes-891bd6e000df
  /// generate our routes
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MenuPage.routeName:  // /menu
        return MaterialPageRoute(
            builder: (_) => MenuPage(), settings: settings);
      case CheckoutPage.routeName:  // /checkout
        /// [Example] set parameters directly from arguments
        CheckoutArgs args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => CheckoutPage(args.orders), settings: settings);
      case PaymentPage.routeName:  // /payment
        return MaterialPageRoute(
            builder: (_) => PaymentPage(), settings: settings);
      case NewOrderPage.routeName: // /new-order
        return MaterialPageRoute(
            builder: (_) => NewOrderPage(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }

}
