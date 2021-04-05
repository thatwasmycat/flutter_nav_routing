import 'package:demo_app/model/option.dart';

class Order {
  String name;
  double price;
  List<Option> options;
  String note = "";
  Order({this.name, this.price, this.options, this.note});
}