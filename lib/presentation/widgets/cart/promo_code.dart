import 'package:flutter/material.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';

class PromoCode extends StatelessWidget {
  final bool promoIsActive;
  final TextEditingController promoCodeController;
  final Function apply;
  final Function remove;
  final bool errorMsg;
  const PromoCode(
      {Key? key,
      required this.promoCodeController,
      required this.apply,
      required this.remove,
      required this.promoIsActive,
      required this.errorMsg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              AppLocalizations.of(context)!.tr('promo_code'),
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Card(
            color: Theme.of(context).colorScheme.secondary,
            elevation: 3,
            shadowColor: Theme.of(context)
                .colorScheme
                .secondaryContainer
                .withOpacity(0.14),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.5))),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6.5)),
                child: Container(
                  constraints: const BoxConstraints(minHeight: 55),
                  width: SizeConfig.screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: SizeConfig.screenWidth! * 0.63,
                        constraints: BoxConstraints(
                          minWidth: SizeConfig.setWidgetWidth(
                              SizeConfig.screenWidth! - 150, 200, 200),
                          maxWidth: SizeConfig.setWidgetWidth(
                              SizeConfig.screenWidth! - 127, 400, 400),
                        ),
                        child: Form(
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 1,
                            maxLength: 25,
                            keyboardType: TextInputType.text,
                            keyboardAppearance: Brightness.dark,
                            textAlign: TextAlign.start,
                            enabled: !promoIsActive,
                            cursorColor: Theme.of(context).primaryColor,
                            controller: promoCodeController,
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    fontSize: 16,
                                    fontWeight: promoIsActive
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                isDense: true,
                                prefixIcon: Icon(
                                  TURKIICONS.ticket_discount,
                                  color: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .color,
                                ),
                                counterText: "",
                                fillColor:
                                    Theme.of(context).colorScheme.secondary,
                                filled: true,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 1)),
                                errorStyle: const TextStyle(fontSize: 12),
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.transparent,
                                )),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.transparent,
                                )),
                                disabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                hintText: AppLocalizations.of(context)!
                                    .tr('promo_code'),
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal)),
                            validator: (value) {
                              return "null";
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          if (promoCodeController.text.isNotEmpty) {
                            promoIsActive ? remove() : apply();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: SizedBox(
                            height: 50,
                            width: SizeConfig.screenWidth! / 5.5,
                            child: Center(
                              child: Text(
                                !promoIsActive
                                    ? AppLocalizations.of(context)!.tr('apply')
                                    : AppLocalizations.of(context)!
                                        .tr('remove'),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
          Visibility(
            visible: errorMsg,
            child: Text(
              "    ${AppLocalizations.of(context)!.tr('invalid_discount_code')}",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Colors.red, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
