class Product {
  String name;
  String image;
  String size;
  num oldPrice;
  num price;
  double percent;
  String shop;
  String time;

  // Product({
  //   required this.name,
  //   required this.image,
  //   required this.size,
  //   required this.oldPrice,
  //   required this.price,
  //   required this.percent,
  //   required this.shop,
  //   required this.time,
  // });
  
  Product({
    this.name = "Чудо йогурт",
    this.image = "https://shymkent.instashop.kz/upload/resize_cache/iblock/171/476_342_1/1710fef42208be936e0322b64babb1ff.png",
    this.size = "115 гр",
    this.oldPrice = 0,
    this.price = 500,
    this.percent = 0.0,
    this.shop = "Galmart",
    this.time = "",
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      image: json['imageUrl'],
      size: json['size'] ?? '',
      oldPrice: json['oldPrice'] ?? 0,
      price: json['price'],
      percent: json['discount']?.toDouble() ?? 0.0,
      shop: json['category'],
      time: json['expiredDate'],
    );
  }
}
