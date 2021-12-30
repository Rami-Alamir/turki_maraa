import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CategoryCardG1 extends StatelessWidget {
  final int index;
  final String title;
  final String image;
  final Color color;
  final Color color2;

  const CategoryCardG1({
    required this.title,
    required this.image,
    required this.color,
    required this.color2,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/ProductsHome$index"),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 200,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 40.0, right: 20, left: 20, bottom: 0),
                child: AutoSizeText(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: title.length < 15 ? 20 : 16),
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(30.0, 45, 30, 15),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0)),
                  child: Image.network(
                    image,
                    fit: BoxFit.contain,
                    height: 170,
                    width: 140,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
