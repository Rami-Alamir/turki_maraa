import 'package:flutter/material.dart';

class CategoryCard2 extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final double width;
  final double height;

  const CategoryCard2(
      {required this.title,
      required this.image,
      required this.color,
      required this.width,
      required this.height});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, right: 20, left: 20, bottom: 10),
              child: Text(title, style: Theme.of(context).textTheme.headline3),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Sheep.png',
                  fit: BoxFit.cover,
                  width: width - 40,
                  height: height - 60,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
