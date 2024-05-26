import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/model/ProductShop.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';

class ProductShopListItem extends StatefulWidget {

  final ProductShop product;
  final Function? add;
  final Function? remove;

  const ProductShopListItem(
    this.product, {
      super.key,
      this.add,
      this.remove
    }
  );

  @override
  State<StatefulWidget> createState() {
    return _ProductShopListItem();
  }
}

class _ProductShopListItem extends State<ProductShopListItem> {

  var _count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal, bottom: 24),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  height: 90,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: 120,
                          child: Image.network(
                            widget.product.shop.images[0],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                "${widget.product.price}₸",
                                style: const TextStyle(
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: AppColor.primary,
                  height: 1,
                  width: 150,
                ),
              ],
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.only(left: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.product.shop.name,
                            style: const TextStyle(
                              color: AppColor.text,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Rubik',
                              fontSize: 14,
                            ),
                          ),
                          Expanded(child: Container()),
                          const Icon(
                            Icons.star_rounded,
                            color: AppColor.primary,
                            size: 18,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 4),
                            child: Text(
                              widget.product.shop.rating.toString().replaceAll(".", ","),
                              style: const TextStyle(
                                  color: AppColor.primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Rubik'
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 2, bottom: 16),
                        child: Text(
                          widget.product.time,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 12,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30),
                        child: _getControlButtons(),
                      )
                    ],
                  )
              ),
            )
          ],
        )
    );
  }

  Widget _getControlButtons() {
    if (_count == 0) {
      return _cartButton();
    } else {
      return Row(
        children: [
          InkWell(
            onTap: () {
              widget.remove?.call();
              if (_count > 0) {
                setState(() {
                  _count--;
                });
              }
            },
            borderRadius: BorderRadius.circular(5),
            child: Container(
              alignment: Alignment.center,
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: const Text(
                "-",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Rubik'
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              "$_count шт",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColor.primary,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              widget.remove?.call();
              if (_count < 100) {
                setState(() {
                  _count++;
                });
              }
            },
            borderRadius: BorderRadius.circular(5),
            child: Container(
              alignment: Alignment.center,
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: const Text(
                "+",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Rubik'
                ),
              ),
            ),
          )
        ],
      );
    }
  }

  Widget _cartButton() {
    return SizedBox(
      height: 30,
      child: InkWell(
        onTap: () {
          widget.add?.call();
          setState(() {
            _count++;
          });
        },
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: 30,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(5)
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_rounded,
                color: Colors.white,
                size: 14,
              ),
              Text(
                "  В корзину",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.normal
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}