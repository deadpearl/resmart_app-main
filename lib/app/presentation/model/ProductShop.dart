import 'package:resmart/app/presentation/model/Shop.dart';

class ProductShop {
  Shop shop;
  String time;
  num oldPrice;
  num price;

  ProductShop({
    required this.shop,
    this.time = "",
    this.oldPrice = 800,
    this.price = 500,
  });
}