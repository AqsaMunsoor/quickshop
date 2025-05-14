import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quickshop/blocs/product/cubit.dart';
import 'package:quickshop/configs/configs.dart';
import 'package:quickshop/router/routes.dart';
import 'package:quickshop/static/category.dart';
import 'package:quickshop/ui/widgets/button/app_button.dart';
import 'package:quickshop/ui/widgets/header/header.dart';
import 'package:quickshop/ui/widgets/input/app_search_input.dart';

import 'package:quickshop/ui/widgets/screen/screen.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

part '_state.dart';

part 'widgets/_body.dart';
part 'widgets/category_card.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    ProductCubit.c(context).fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
