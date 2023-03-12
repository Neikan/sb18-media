import 'package:flutter/material.dart';

class UiButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;

  const UiButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.green.withOpacity(0.5),
      ),
      width: 56,
      height: 56,
      child: IconButton(
        icon: Icon(icon, size: 36),
        onPressed: onPressed,
      ),
    );
  }
}
