import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickshop/configs/configs.dart';

import 'package:quickshop/models/product/product.dart';
import 'package:quickshop/providers/favourite.dart';
import 'package:quickshop/ui/widgets/header/header.dart';
import 'package:quickshop/ui/widgets/input/app_search_input.dart';
import 'package:quickshop/ui/widgets/screen/screen.dart';

part '_state.dart';
part 'widgets/_body.dart';
part 'widgets/_favourite_card.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
