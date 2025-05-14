import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quickshop/blocs/product/cubit.dart';
import 'package:quickshop/configs/configs.dart';
import 'package:quickshop/models/product/product.dart';
import 'package:quickshop/ui/widgets/cards/product_card.dart';
import 'package:quickshop/ui/widgets/header/header.dart';

import 'package:quickshop/ui/widgets/screen/screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '_state.dart';

part 'widgets/_body.dart';
part 'widgets/_product_list.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String? category;
  const CategoryDetailScreen({super.key, this.category});

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
