import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utilities/size_config.dart';

class CustomCheckbox extends StatelessWidget {
  final bool cheeked;
  final String title;
  final double? width;
  final Function onTap;

  const CustomCheckbox({
    super.key,
    required this.cheeked,
    required this.title,
    this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          onTap();
        },
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: cheeked
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: cheeked
                        ? Colors.black.withValues(alpha: 0.3)
                        : Colors.transparent,
                    offset: const Offset(1, 3),
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                border: Border.all(
                  color: cheeked
                      ? Theme.of(context).primaryColor
                      : AppColors.grey.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Visibility(
                visible: cheeked,
                child: const Center(
                  child: Icon(Icons.check, size: 20, color: AppColors.white),
                ),
              ),
            ),
            SizedBox(
              width: width ?? (SizeConfig.screenWidth! - 75),
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.displayMedium!.copyWith(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
