import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:quickshop/configs/configs.dart';
import 'package:quickshop/router/routes.dart';
import 'package:quickshop/ui/widgets/bottom_bar/bottom_bar.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

class Screen extends StatefulWidget {
  const Screen({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.keyboardHandler = false,
    this.renderSettings = true,
    this.bottomBar = false,
    this.resizeToAvoidBottomInset = false,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.scaffoldBackgroundColor,
    this.onBackPressed,
    this.canPop,
    this.appBar,
    this.bottomBarHeightChanged,
    this.belowBuilders,
    this.overlayBuilders,
  });

  final Widget child;
  final EdgeInsets padding;
  final bool keyboardHandler;
  final bool renderSettings;
  final bool bottomBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? scaffoldBackgroundColor;
  final List<Widget>? belowBuilders;
  final List<Widget>? overlayBuilders;
  final bool resizeToAvoidBottomInset;
  final void Function()? onBackPressed;
  final bool? canPop;
  final PreferredSizeWidget? appBar;

  final void Function(double height)? bottomBarHeightChanged;

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  final bottomBarKey = GlobalKey();
  double get _getBottomBarHeight {
    final renderBox =
        bottomBarKey.currentContext?.findRenderObject() as RenderBox?;
    final height = renderBox?.size.height ?? context.bottomSafe();
    return height;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.bottomBarHeightChanged?.call(_getBottomBarHeight);
    });
  }

  @override
  Widget build(BuildContext context) {
    var body = widget.child;
    var onWillPop = widget.onBackPressed;
    var canPopValue = widget.canPop ?? true;

    const bottomBarRoutes = <String>[
      AppRoutes.categories,
      AppRoutes.favourites,
      AppRoutes.profile,
    ];
    final currentRoute = context.currentPath;

    if (onWillPop == null && bottomBarRoutes.contains(currentRoute)) {
      onWillPop = () {
        const homeRoute = AppRoutes.home;
        homeRoute.pushReplace(context);
      };
      canPopValue = false;
    }

    if (onWillPop != null || !canPopValue) {
      body = PopScope(
        canPop: canPopValue,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop && onWillPop != null) {
            onWillPop();
          }
        },
        child: body,
      );
    }

    body = Padding(padding: widget.padding, child: body);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        backgroundColor: widget.scaffoldBackgroundColor,
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        appBar: widget.appBar,
        body: Stack(
          fit: StackFit.expand,
          children: [
            if (widget.belowBuilders != null) ...widget.belowBuilders!,
            Positioned.fill(child: body),
            if (widget.bottomBar)
              Positioned(
                key: bottomBarKey,
                left: 0,
                right: 0,
                bottom: 0,
                child: const BottomBar(),
              ),
            if (widget.overlayBuilders != null) ...widget.overlayBuilders!,
          ],
        ),
      ),
    );
  }
}
