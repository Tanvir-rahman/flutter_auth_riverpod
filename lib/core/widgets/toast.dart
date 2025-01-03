import 'package:flutter/material.dart';

class Toast extends StatelessWidget {
  final Color? bgColor;
  final IconData? icon;
  final String message;
  final Color? textColor;

  const Toast({
    Key? key,
    this.bgColor,
    this.icon,
    required this.message,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: bgColor ?? Colors.black87,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: textColor ?? Colors.white,
            ),
            const SizedBox(width: 12.0),
          ],
          Flexible(
            child: Text(
              message,
              style: TextStyle(
                color: textColor ?? Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
