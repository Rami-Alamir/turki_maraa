import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/show_snack_bar.dart';
import '../../../core/utilities/size_config.dart';
import '../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';

class PromoCode extends StatelessWidget {
  const PromoCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartProvider cart = Provider.of<CartProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 5, left: 5),
            child: Text(
              AppLocalizations.of(context)!.tr('promo_code'),
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: 14),
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
                            enabled: !cart.promoIsActive,
                            cursorColor: Theme.of(context).primaryColor,
                            controller: cart.promoCodeController,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontSize: 16,
                                    fontWeight: cart.promoIsActive
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                isDense: true,
                                prefixIcon: Icon(
                                  TURKIICONS.ticket_discount,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
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
                                        color: AppColors.red, width: 1)),
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
                                    .titleSmall!
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
                        onTap: () async {
                          if (cart.promoCodeController.text.isNotEmpty) {
                            if (cart.promoIsActive) {
                              cart.removePromoCode();
                            } else {
                              bool status =
                                  await cart.checkCoupon(context: context);
                              if (context.mounted) return;
                              Navigator.of(context, rootNavigator: true).pop();
                              if (!status) {
                                sl<ShowSnackBar>()
                                    .show(context, "unexpected_error");
                              }
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: SizedBox(
                            height: 50,
                            width: SizeConfig.screenWidth! / 5.5,
                            child: Center(
                              child: Text(
                                !cart.promoIsActive
                                    ? AppLocalizations.of(context)!.tr('apply')
                                    : AppLocalizations.of(context)!
                                        .tr('remove'),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
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
            visible: cart.errorMsg,
            child: Text(
              "    ${AppLocalizations.of(context)!.tr('invalid_discount_code')}",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: AppColors.red, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
