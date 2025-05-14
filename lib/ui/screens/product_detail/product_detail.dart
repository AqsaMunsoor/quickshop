// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quickshop/blocs/product/cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:quickshop/configs/configs.dart';
import 'package:quickshop/models/product/product.dart';
import 'package:quickshop/models/review/review.dart';
import 'package:quickshop/ui/widgets/header/header.dart';
import 'package:quickshop/ui/widgets/screen/screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickshop/providers/favourite.dart';

part '_state.dart';
part 'widgets/_body.dart';

part 'listeners/_fetch_product_by_id.dart';

class ProductDetailScreen extends StatelessWidget {
  final String? productId;
  const ProductDetailScreen({this.productId});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(args: args),
      child: const _Body(),
    );
  }
}
