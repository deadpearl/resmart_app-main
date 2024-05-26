import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/model/Product.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';

class ProductListItem extends StatefulWidget {

  final Product product;
  final Function? onPressed;
  final Function? add;
  final Function? remove;

  const ProductListItem(
    this.product, {
      super.key,
      this.onPressed,
      this.add,
      this.remove
    }
  );

  @override
  State<StatefulWidget> createState() {
    return _ProductListItem();
  }
}

class _ProductListItem extends State<ProductListItem> {

  var _count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0.0, 5.0),
            blurRadius: 30,
            spreadRadius: 0,
          )
        ], //
      ),
      child: InkWell(
        onTap: () {
          widget.onPressed?.call();
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 4),
                height: 160,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: 120,
                        child: Image.network(
                          widget.product.image,
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
                margin: const EdgeInsets.only(right: 40),
              ),
              Container(
                padding: const EdgeInsets.only(left: 14, right: 14, bottom: 8, top: 4),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.product.name,
                          style: const TextStyle(
                            color: AppColor.text,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Rubik',
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 4),
                          child: Text(
                            widget.product.size,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 10,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 2, bottom: 6),
                      child: Text(
                        widget.product.shop,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 12,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    _getControlButtons()
                  ],
                )
              ),
            ],
          ),
        ),
      ),
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