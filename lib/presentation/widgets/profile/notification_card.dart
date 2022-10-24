import 'package:flutter/material.dart';
import '../../../models/notification_data.dart';
import '../../../core/utilities/size_config.dart';

class NotificationCard extends StatelessWidget {
  final NotificationData notificationData;

  const NotificationCard({
    Key? key,
    required this.notificationData,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          height: SizeConfig.screenWidth! > 900 ? 400 : 375,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context)
                    .colorScheme
                    .secondaryContainer
                    .withOpacity(0.14),
                spreadRadius: 0.5,
                blurRadius: 11,
              ),
            ],
          ),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: SizedBox(
                    width: SizeConfig.screenWidth! > 900
                        ? SizeConfig.screenWidth! / 3
                        : SizeConfig.screenWidth,
                    height: SizeConfig.screenWidth! > 900 ? 450 : 220,
                    child: Image.network(
                      notificationData.image!,
                      width: SizeConfig.screenWidth! > 900
                          ? SizeConfig.screenWidth! / 3
                          : SizeConfig.screenWidth,
                      height: SizeConfig.screenWidth! > 900 ? 450 : 220,
                      fit: BoxFit.fill,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: SizeConfig.screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notificationData.title!,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(fontSize: 14)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(notificationData.subtitle!,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    height: 1.45,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: SizedBox(
                          width: SizeConfig.screenWidth,
                          child: Text(notificationData.date!,
                              textAlign: TextAlign.end,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
