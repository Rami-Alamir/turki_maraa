import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final int index;
  final String title;
  final String image;
  final Color color;
  final Color color2;
  final double scaleFactor;

  const CategoryCard({
    required this.title,
    required this.scaleFactor,
    required this.image,
    required this.color,
    required this.color2,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/ProductsHome$index"),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
            colors: [
              color,
              color2,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 40.0, right: 20, left: 20, bottom: 0),
              child: Text(title, style: Theme.of(context).textTheme.headline3),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0)),
                  // child: Image.network(
                  child: Image.asset(
                    image,
                    fit: BoxFit.fitWidth,
                    height: (133 * scaleFactor) - 21,
                    width: (MediaQuery.of(context).size.width / 2) -
                        18 -
                        (color2 == Colors.indigo ? 40 : 0),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
