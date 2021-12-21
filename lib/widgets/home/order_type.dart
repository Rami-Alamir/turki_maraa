import 'package:flutter/material.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:provider/provider.dart';

class OrderType extends StatelessWidget {
  final bool visible;

  const OrderType({required this.visible});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: visible ? 110 : 40,
      color: Theme.of(context).backgroundColor == Colors.black
          ? Theme.of(context).colorScheme.secondary
          : Theme.of(context).primaryColor,
      child: visible
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    width: SizeConfig.screenWidth,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        item(
                            type: 0,
                            context: context,
                            title: 'delivery',
                            image: 'assets/images/delivery-truck.png'),
                        item(
                            type: 1,
                            context: context,
                            title: 'pickup',
                            image: 'assets/images/shop.png'),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Container(),
    );
  }

  Widget item(
      {required BuildContext context,
      required int type,
      required String title,
      required String image}) {
    final _homeProvider = Provider.of<HomeProvider>(context);
    bool selected = _homeProvider.selectedOrderType == type;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () {
          _homeProvider.setOrderType = type;
        },
        child: Container(
          padding: const EdgeInsets.all(3.0),
          width: SizeConfig.screenWidth! * .37,
          height: 87,
          constraints: const BoxConstraints(
            minHeight: 75,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: selected
                      ? Colors.white
                      : Theme.of(context).colorScheme.secondaryVariant,
                  width: selected ? 1 : 0.8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Image.asset(
                  image,
                  width: 40,
                  height: 28,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.tr(title),
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
