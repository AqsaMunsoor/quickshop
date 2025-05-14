import 'package:flutter/material.dart';
import 'package:quickshop/configs/configs.dart';
import 'package:quickshop/router/routes.dart';

part '_data.dart';
part '_model.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPath = context.currentPath;
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      child: Material(
        color: Colors.transparent,
        child: Row(
          children:
              _tabs.map((tab) {
                final isActive = tab.path == currentPath;

                return Expanded(
                  child: InkWell(
                    onTap: () {
                      if (tab.path == currentPath) return;
                      tab.path.pushReplace(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            isActive
                                ? AppColors.whiteTransparent
                                : Colors.black,
                      ),

                      child: Column(
                        children: [
                          Space.y.t15,
                          Image.asset(
                            tab.icon,
                            color: AppColors.white,
                            width: 24,
                            height: 24,
                          ),
                          Space.y.t15,
                          Text(tab.label, style: AppText.t12 + AppColors.white),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
