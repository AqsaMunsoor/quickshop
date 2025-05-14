import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final IconData? icon;
  final EdgeInsetsGeometry padding;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  });

  @override
  Widget build(BuildContext context) {
    final color = isPrimary ? Theme.of(context).primaryColor : Colors.grey[800];
    final background = color!.withOpacity(0.1);

    final style = TextButton.styleFrom(
      padding: padding,
      backgroundColor: background,
      foregroundColor: color,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ).copyWith(
      overlayColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.pressed)
                ? color.withValues(alpha: 0.08)
                : null,
      ),
    );

    return TextButton.icon(
      onPressed: onPressed,
      style: style,
      icon:
          icon != null
              ? Icon(icon, size: 20, color: color)
              : const SizedBox.shrink(),
      label: Text(label),
    );
  }
}
