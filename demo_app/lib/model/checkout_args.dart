import 'order.dart';

class CheckoutArgs {
  String payment;
  List<Order> orders;
  CheckoutArgs({this.payment, this.orders});
}