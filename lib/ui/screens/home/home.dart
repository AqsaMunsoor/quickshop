import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quickshop/blocs/product/cubit.dart';
import 'package:quickshop/configs/configs.dart';
import 'package:quickshop/ui/widgets/button/app_button.dart';
import 'package:quickshop/ui/widgets/header/header.dart';
import 'package:quickshop/ui/widgets/input/app_search_input.dart';

import 'package:quickshop/ui/widgets/screen/screen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/cards/product_card.dart';

part '_state.dart';

part 'widgets/_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ProductCubit.c(context).fetch();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
