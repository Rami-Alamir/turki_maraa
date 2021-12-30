import 'package:flutter/material.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
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
                    height: 72,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        item(
                            type: 0,
                            context: context,
                            title: 'delivery',
                            icon: TURKIICONS.delivery_truck_2),
                        item(
                            type: 1,
                            context: context,
                            title: 'pickup',
                            icon: TURKIICONS.merchant_1),
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
      required IconData icon}) {
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
          width: SizeConfig.screenWidth! / 2 - 30,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(6.0, 0, 8, 0),
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryVariant
                            .withOpacity(0.16),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Icon(
                      icon,
                      size: 17.5,
                      color: Colors.white,
                    )),
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
