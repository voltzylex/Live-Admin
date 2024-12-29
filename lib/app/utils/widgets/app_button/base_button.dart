import 'package:flutter/cupertino.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.color,
    this.disabledColor = CupertinoColors.quaternarySystemFill,
  });
  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;
  final Color disabledColor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        minSize: 0,
        color: color,
        borderRadius: BorderRadius.zero,
        disabledColor: disabledColor,
        child: child,
      ),
    );
  }
}
