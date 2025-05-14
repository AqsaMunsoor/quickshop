import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quickshop/configs/configs.dart';
import 'package:quickshop/router/routes.dart';

import 'package:quickshop/ui/widgets/screen/screen.dart';

part '_state.dart';

part 'widgets/_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
