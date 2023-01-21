import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final EdgeInsetsDirectional padding;

  const CircleIcon(
      {Key? key,
      required this.onTap,
      required this.icon,
      this.padding = const EdgeInsetsDirectional.fromSTEB(0.0, 0, 0, 0)})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      splashColor: Colors.transparent,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(0.3),
              blurRadius: 44,
              offset: const Offset(4, 8), // Shadow position
            ),
          ],
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
        ),
        child: Padding(
          padding: padding,
          child: Icon(icon, color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
