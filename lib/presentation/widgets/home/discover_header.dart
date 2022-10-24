import 'package:flutter/material.dart';
import '../../../core/utilities/size_config.dart';

class DiscoverHeader extends StatelessWidget {
  final String title;
  final String image;

  const DiscoverHeader({Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            color: Colors.transparent,
            height: 250,
            width: SizeConfig.screenWidth!,
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Container(
                color: Colors.transparent,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
        ),
        Positioned(
            top: 40,
            right: 40,
            child: SizedBox(
              width: 250,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 2),
              ),
            ))
      ],
    );
  }
}
