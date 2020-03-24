import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double borderRadius;
  final Color backgroundColor;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BoxShadow boxShadow;
  final Widget child;
  final bool showOnOverflow;

  const CustomCard({
    Key key,
    this.borderRadius,
    this.child,
    this.boxShadow,
    this.backgroundColor,
    this.margin,
    this.padding,
    this.showOnOverflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(),
      decoration: BoxDecoration(boxShadow: [
        boxShadow ?? BoxShadow(blurRadius: 10, color: Theme.of(context).colorScheme.surface.withOpacity(.09)),
      ], borderRadius: BorderRadius.circular(borderRadius ?? 10), color: backgroundColor ?? Theme.of(context).cardColor),
      child: showOnOverflow ?? true
          ? Padding(
              padding: padding ?? EdgeInsets.only(),
              child: child ?? Container(),
            )
          : ClipRRect(
              child: Padding(
                padding: padding ?? EdgeInsets.only(),
                child: child ?? Container(),
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
            ),
    );
  }
}
