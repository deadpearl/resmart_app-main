import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/model/Shop.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';

class ShopListItem extends StatelessWidget {

  final Shop shop;
  final Function? onPressed;

  const ShopListItem(this.shop, {super.key, this.onPressed});

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
          onPressed?.call();
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  shop.images[0],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: 150,
                height: 1,
                color: AppColor.primary,
              ),
              Container(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: HeaderText(
                        shop.name,
                        size: 14,
                      ),
                    ),
                    const Icon(
                      Icons.star_rounded,
                      color: AppColor.primary,
                      size: 18,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: Text(
                        shop.rating.toString().replaceAll(".", ","),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
