import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:quickshop/configs/configs.dart';
import 'package:quickshop/models/product/product.dart';
import 'package:quickshop/router/routes.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRoutes.productDetail.push(
          context,
          arguments: {'productId': product.id},
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(15),
          decoration: AppProps.productCard,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 300,
                height: 250,
                child: CachedNetworkImage(
                  imageUrl: product.images.first,

                  fit: BoxFit.cover,
                ),
              ),
              Space.y.t10,
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.title, style: AppText.t16 + FontWeight.bold),
                      Row(
                        children: [
                          Text('4.9 ', style: AppText.t12 + FontWeight.bold),
                          Row(
                            children: List.generate(
                              5,
                              (index) => Icon(
                                Icons.star,
                                size: 16,
                                color:
                                    index < product.rating.floor()
                                        ? AppColors.yellow
                                        : AppColors.inActive,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    '\$${product.price.toString()}',
                    style: AppText.t18 + FontWeight.bold,
                  ),
                ],
              ),
              Space.y.t08,
              Text(
                'by ${product.brand}',
                style: AppText.t12 + AppColors.lightBlack,
              ),
              Space.y.t15,
              Text('in ${product.category}', style: AppText.t12),
            ],
          ),
        ),
      ),
    );
  }
}
