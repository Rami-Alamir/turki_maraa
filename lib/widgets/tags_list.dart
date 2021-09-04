import 'package:flutter/material.dart';
import 'package:new_turki/widgets/tag.dart';

class TagsList extends StatelessWidget {
  final title;
  final tags;
  final List isSelected;
  final onTap;

  TagsList({
    required this.title,
    required this.tags,
    required this.onTap,
    required this.isSelected,
  });
  List<Widget> tagsList = [];

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return tags.length == 0
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 0.0, 10.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontSize: _width > 600 ? 24 : 16, color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                width: _width,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: getTags(),
                ),
              ),
            ],
          );
  }

  List<Widget> getTags() {
    for (int i = 0; i < tags.length; i++)
      tagsList.add(Tag(
        selected: isSelected[i],
        onTap: () {
          isSelected[i] = !isSelected[i];
          onTap();
        },
        title: tags[i],
      ));
    return tagsList;
  }
}
